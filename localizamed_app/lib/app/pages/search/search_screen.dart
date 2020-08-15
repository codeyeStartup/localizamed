import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:localizamed_app/app/pages/search/clinica_modelTest.dart';
import 'package:localizamed_app/app/pages/clinic/clinic_screen.dart';
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Search_model> _list = [];
  String _url = ConexaoAPI().api + 'search_clinica';

  var loading = false;

  TextEditingController _controller = TextEditingController();

  bool _showClearButton = false;

  StreamController _streamController;

  Timer _debounce;

  _search() async {
    if (_controller.text == null || _controller.text.length == 0) {
      loading = false;
      return;
    } else {
      loading = true;
      Response response = await post(_url, body: {
        'search': _controller.text.trim()
      }, headers: {
        /* 'search': _controller.text.trim(), */
        'Accept': 'application/json',
      });
      if (response.statusCode == 200) {
        final data = json.decode(response.body).cast<Map<String, dynamic>>();
        print(data);
        setState(() {
            loading = false;
        });
        return data.map<Search_model>((json) => Search_model.fromJson(json)).toList();
      }
    }
  }

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
                    onChanged: (String text) {
                      if (_debounce?.isActive ?? false) _debounce.cancel();
                      _debounce = Timer(const Duration(milliseconds: 1000), () {
                        _search();
                      });
                    },
                  ),
                ),
              ),
              preferredSize: Size.fromHeight(48.0)),
        ),
        body: SafeArea(
            child: Column(
          children: <Widget>[
            loading || _list.isEmpty || _controller.text.isEmpty
                ? Expanded(
                    child: Center(
                    child: Text(
                      "Nenhuma Clinica",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ))
                : Expanded(
                    child: ListView.builder(
                        padding: EdgeInsets.all(10),
                        itemCount: _list?.length?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          var i = _list[index];
                          return GestureDetector(
                            onTap: () async {
                              SharedPreferences prefId =
                                  await SharedPreferences.getInstance();
                              prefId.setString("_id", i.iId.id);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => ClinicScreen()));
                            },
                            child: Card(
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      i.iId.nome,
                                      //'',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      i.iId.cidade,
                                      //'',
                                      style: TextStyle(
                                          fontSize: 16.0, color: Colors.grey),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
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
          _controller.clear();
        });
  }
}
