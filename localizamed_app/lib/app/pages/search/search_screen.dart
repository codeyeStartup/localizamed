import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
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

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  TextEditingController _controller = TextEditingController();

  bool _showClearButton = false;
  var loading = false;

  Timer _debounce;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _showClearButton = _controller.text.length > 0;
      });
    });
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
          children: <Widget>[
            loading || _list == null || _controller.text.isEmpty
                ? Expanded(
                    child: Center(
                    child: Text(
                      "Nenhuma Clinica",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ))
                : Expanded(
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
                        }))
          ],
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
        });
  }

  _search() async {
    if (_controller.text == null || _controller.text.length == 0) {
      setState(() {
        _list.clear();
      });
      loading = false;
      return null;
    } else {
      loading = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('tokenjwt');
      String _url = ConexaoAPI().api + 'search_clinica';
      Response response = await post(_url,
          body: {'search': _controller.text.trim()},
          headers: {'Accept': 'application/json', "x-access-token": token});

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        setState(() {
          loading = false;
        });
        return data.forEach((e) {
          _list.add(Search_model.fromJson(e));
        });
      }
    }
  }
}
