import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/app/models/medicos_model.dart';
/* import 'package:localizamed_app/app/models/clinica_model.dart'; */
import 'package:localizamed_app/app/pages/clinic/clinic_screen.dart';
import 'dart:async';
import 'service.dart';
import 'clinica_modelTest.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Clinicas> _clinicas = List<Clinicas>();
  List<Clinicas> _filteredClinicas = List<Clinicas>();

 /*  List<MedicosClin> _medicos = List<MedicosClin>();
  List<MedicosClin> _filteredMedicos = List<MedicosClin>(); */
  
 /*  List<Clinicas> _list = [];
  var loading = false;
  Future<Clinicas> _fetchData() async {
    setState(() {
      loading = true;
    });
    final response =
        await http.get("http://10.0.0.108:8081/search_clinica");
   /*  final jsonresponse = json.decode(response.body);

    return Clinicas.fromJson(jsonresponse[0]);   */  
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        for (Map i in data) {
          _list.add(Clinicas.fromJson(i));
        }
        loading = false;
      });
      /* return Clinicas.fromJson(data[0]); */
    }
  } */
  
  @override
  void initState() {
    super.initState();
     Services.getClinicas().then((clinicasFromServer) {
      setState(() {
        _clinicas = clinicasFromServer;
        _filteredClinicas = clinicasFromServer; 
        /* _clinicas.addAll(clinicasFromServer); */
      });
    });
    /* _fetchData(); */
    /* Services.getMedicos().then((medicosFromServer) {
      setState(() {
        _medicos = medicosFromServer;
        _filteredMedicos = medicosFromServer; 
      }); 
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: Column(
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'Enter name or city'),
            onChanged: (dynamic string){
              setState(() {
                _filteredClinicas = 
                  _clinicas.where((u) => (
                    u.nome.toLowerCase().contains(string.toLowerCase()) ||
                    u.razaoSocial.toLowerCase().contains(string.toLowerCase())||
                    u.razaoSocial.toLowerCase().contains(string.toLowerCase())||
                     u.razaoSocial.toLowerCase().contains(string.toLowerCase())||
                    u.cidade.toLowerCase().contains(string.toLowerCase()))).toList();
                /* _filteredMedicos = 
                  _medicos.where((u) => (
                    u.nome.toLowerCase().contains(string.toLowerCase())||
                    u.especialidade.toLowerCase().contains(string.toLowerCase())
                    )).toList(); */
              });
            },    
          ),
          Expanded(
            child: /* loading ? Center(child: CircularProgressIndicator(),) : */
            ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: _filteredClinicas.length ,
                itemBuilder: (BuildContext context, index) {
                  return GestureDetector(
                    onTap: () async {
                      SharedPreferences prefId =
                          await SharedPreferences.getInstance();
                      prefId.setString('id', _filteredClinicas[index].id);
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
                              _filteredClinicas[index].nome,
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.black),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              _filteredClinicas[index].cidade,
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.grey),
                            ),
                             SizedBox(
                              height: 5.0,
                            ),
                            /* Text(
                              _filteredClinicas[index].medicosClin.length.toString(),
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.grey),
                            ), */
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              /* FutureBuilder(
                future: _fetchData(),
                builder: (context, i){
                  return Container(
                    child: Text(i.data.medicosClin.nome),
                  );
                }
              ) */ 
          )
        ],
      ),
    ));
  }
}
