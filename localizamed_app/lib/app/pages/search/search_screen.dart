import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:localizamed_app/app/models/search_model.dart';
import 'package:localizamed_app/app/pages/clinic/clinic_screen.dart';
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Search_model> _list = List<Search_model>();
  bool resultList;

  String _connectionStatus = 'unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  TextEditingController _controller = TextEditingController();

  bool _showClearButton = false;
  var loading;

  Timer _debounce;

  @override
  void initState() {
    _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    resultList = true;
    loading = 1;
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showClearButton = _controller.text.length > 0;
      });
    });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: PreferredSize(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                height: MediaQuery.of(context).size.height / 14,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: new Offset(2, 3),
                          blurRadius: 4)
                    ]),
                child: Center(
                    child: TextField(
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15.0),
                    hintText: 'Pesquisar',
                    suffixIcon: _getButton(),
                    hintStyle: TextStyle(fontSize: 15),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  controller: _controller,
                  onSubmitted: (e) {
                    _search();
                  },
                  onChanged: (a) {
                    _list.clear();
                  },
                )),
              ),
              preferredSize: Size.fromHeight(48.0)),
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[_result()],
        )));
  }

  Widget _getButton() {
    if (!_showClearButton) {
      return Icon(
        FontAwesomeIcons.search,
        size: 18,
      );
    }
    return IconButton(
        padding: EdgeInsets.only(right: 8),
        icon: Container(
            padding: EdgeInsets.all(8),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            child: Icon(
              Icons.clear,
              size: 20,
              color: Colors.white,
            )),
        onPressed: () {
          _list.clear();
          _controller.clear();
          resultList = true;
        });
  }

  _search() async {
    if (_controller.text == null || _controller.text.length == 0) {
      setState(() {
        _list.clear();
        loading = 1;
      });
      return null;
    } else {
      setState(() {
        loading = 2;
      });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('tokenjwt');
      String _url = ConexaoAPI().api + 'search_clinica';
      Response response = await post(_url,
          body: {'search': _controller.text.trim()},
          headers: {'Accept': 'application/json', "x-access-token": token});

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          loading = 3;
        });
        if (data.length >= 1) {
          resultList = true;
          return data.forEach((e) {
            _list.add(Search_model.fromJson(e));
          });
        } else {
          return resultList = false;
        }
      }
    }
  }

  Widget _result() {
    if (_connectionStatus == 'ConnectivityResult.none') {
      return Expanded(
              child: Center(
            child: Text(
          'Não foi possível se conectar. Tente novamente.',
          textAlign: TextAlign.center,
        )),
      );
    } else {
      if (loading == 1 || _list == null || _controller.text.isEmpty) {
        return Expanded(
            child: Center(
          child: Text(
            "Pesquise por Clínicas, \n  exames ou médicos",
            style: TextStyle(color: Colors.grey),
          ),
        ));
      } else if (loading == 2) {
        return Expanded(
          child: Center(
            child: LoadingBouncingLine.circle(
              backgroundColor: Theme.of(context).primaryColor,
            ),
          ),
        );
      } else if (loading == 3 && resultList == true) {
        return Expanded(
            child: ListView.builder(
                itemCount: _list?.length ?? 0,
                itemBuilder: (context, index) {
                  var i = _list[index];
                  if (index.hashCode == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return GestureDetector(
                    onTap: () async {
                      SharedPreferences prefId =
                          await SharedPreferences.getInstance();
                      prefId.setString("id", i.iId.id);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ClinicScreen()));
                    },
                    child: Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(i.iId.nome),
                          subtitle: Text(i.iId.cidade),
                        )),
                  );
                }));
      } else if (loading == 3 && resultList == false) {
        return Expanded(
            child: Center(
          child: Text(
            "Nenhuma resultado foi encontrado",
            style: TextStyle(color: Colors.grey),
          ),
        ));
      }
    }
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      print(e.toString());
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = result.toString());
        break;
    }
  }
}
