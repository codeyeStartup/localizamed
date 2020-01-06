import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localizamed_app/blocs/pesquisa_bloc.dart';
import 'package:localizamed_app/components/filter_card.dart';
import 'package:floating_search_bar/floating_search_bar.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = new TextEditingController();
  String filter;

  PesquisaBloc _pesquisaBloc;

  /* _openPesquisa(String pesquisaAtual) async{
    final String  search = await showDialog(context: context,
      builder: (context) => 
    )
  } */

  @override
  initState() {
    searchController.addListener(() {
      setState(() {
        filter = searchController.text;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: Scaffold(
          body: SafeArea(
              child: FloatingSearchBar.builder(
              controller: searchController,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(index.toString()),
          );
        },
        trailing: GestureDetector(
          onTap: (){},
          child: Icon(Icons.search, size: 30)),
        drawer: Drawer(
          child: Container(
              child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.black12,
                child: Row(
                  children: <Widget>[
                    Text(                      
                      'Filtros',
                      style: TextStyle(fontSize: 30, fontFamily: 'Montserrat'),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 3.5),
                      child: Icon(
                        Icons.filter_list,
                        size: 40,
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
        ),
        onChanged: (String value) {},
        onTap: () {},
        decoration: InputDecoration.collapsed(
          hintText: "Pesquisar",
          
        ),
      ))),
    );
  }
}
