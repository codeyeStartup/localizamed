import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:localizamed_app/app/models/clinica_model.dart';

class SearchScreen extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<SearchScreen> {
  List<Clinicas3> _searchResult = [];
  List<Clinicas3> _clinDetails = [];
  TextEditingController controller = new TextEditingController();

  // Get json result and convert it to model. Then add
  Future<Null> getclinicaDetails() async {
    final response = await http.get(ConexaoAPI().api + 'clinicasAll');
    final responseJson = json.decode(response.body);

    setState(() {
      for (Map clinica in responseJson) {
        _clinDetails.add(Clinicas3.fromJson(clinica));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getclinicaDetails();
  }

  Widget _buildclinicasList() {
    return new ListView.builder(
      itemCount: _clinDetails.length,
      itemBuilder: (context, index) {
        return new Card(
          child: new ListTile(
            title: new Text(_clinDetails[index].nome),
          ),
          margin: const EdgeInsets.all(0.0),
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return new ListView.builder(
      itemCount: _searchResult.length,
      itemBuilder: (context, i) {
        return new Card(
          child: new ListTile(
            title: new Text(_searchResult[i].nome),
          ),
          margin: const EdgeInsets.all(0.0),
        );
      },
    );
  }

  Widget _buildSearchBox() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Card(
        child: new ListTile(
          leading: new Icon(Icons.search),
          title: new TextField(
            controller: controller,
            decoration: new InputDecoration(
                hintText: 'Pesquise aqui', border: InputBorder.none),
            onChanged: onSearchTextChanged,
          ),
          trailing: new IconButton(
            icon: new Icon(Icons.cancel),
            onPressed: () {
              controller.clear();
              onSearchTextChanged('');
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return new Column(
      children: <Widget>[
        new Container(
            color: Theme.of(context).primaryColor, child: _buildSearchBox()),
        new Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ? _buildSearchResults()
                : _buildclinicasList()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _buildBody(),
      resizeToAvoidBottomPadding: true,
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _clinDetails.forEach((clinicaDetail) {
      if (clinicaDetail.nome.toLowerCase().contains(text) ||
          clinicaDetail.cidade.toLowerCase().contains(text) /* ||
          clinicaDetail.medicosClin.contains(text) */
          ) 
        _searchResult.add(clinicaDetail); 
    });

    setState(() {});
  }
}

////////////////////////////////////////////////////////////

/* import 'package:flutter/material.dart';
import 'package:localizamed_app/blocs/clinica.bloc.dart';
import 'package:localizamed_app/classes/clinica_class.dart';
import 'package:localizamed_app/repositories/clinicas_api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final search = List<Clinicas>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesquisa"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  //final lista = ["Sandrinho", "Pedrinho", "eu", "laisinha", "diarreia"];
  List<Clinicas> lista = [];
  final suggestion = ["teste1", "teste2"];

  

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? suggestion
        : lista.where((p) => p.toLowerCase().contains(query)).toList(); 

    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        title: Text(suggestionList[index]),
      ),
      itemCount: suggestionList.length,
    );
  }
} */

//////////////////////TERCEIRA TENTATIVA

/* import 'package:flutter/material.dart';
import 'package:localizamed_app/blocs/pesquisa_bloc.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _pesquisaBloc = PesquisaBloc();
   final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  void initState() {
    pesquisaBloc.getPesquisa();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  showSnack() {
    return scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('New content loaded'),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
      showSnack();
      return null;   
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            color: Colors.transparent,
            child: Container(
                child: Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.cyanAccent,
                  ),
                  child: StreamBuilder<String>(
                      initialData: '',
                      stream: _pesquisaBloc.outPesquisa,
                      builder: (context, snapshot) {
                        return TextField(
                            textInputAction: TextInputAction.search,
                            decoration: InputDecoration(
                                hintText: "Ex: Proctologista",
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.only(left: 15, top: 15),
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: _pesquisaBloc.pesquisa,
                                  iconSize: 30,
                                )),
                            onChanged: _pesquisaBloc.changePesquisa);
                      }),
                ),
              ),
              SizedBox(
                height: 50,
              ),

              //RESULTADOS DA PESQUISA
              StreamBuilder(
                  stream: pesquisaBloc.pesquisaList,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                      ));
                    } else {
                      return ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot?.data?.length ?? 0,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.only(left: 20, bottom: 15),
                            child: Text(snapshot.data[index].nome),
                          );
                        },
                      );
                    }
                  })
            ])))); */

/* Column(children: <Widget>[
      StreamBuilder<String>(
          stream: _pesquisaBloc.outPesquisa,
          builder: (context, snapshot) {
            return TextFormField(
              onChanged: _pesquisaBloc.changePesquisa,
            );
          }),
      SizedBox(
        height: 50,
      ),
      FlatButton(
        child: Text("Pesquisar"),
        onPressed: _pesquisaBloc.pesquisa,
      ),
      SizedBox(
        height: 50,
      ),
      StreamBuilder(
          stream: pesquisaBloc.pesquisaList,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
              ));
            } else {
              return ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 10,
                  );
                },
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: snapshot?.data?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Text(snapshot.data[index].nome);
                },
              );
            }
          })
    ]); */
/*   }
} */
