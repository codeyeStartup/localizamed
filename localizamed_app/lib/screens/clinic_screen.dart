import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localizamed_app/blocs/clinica.bloc.dart';
import 'package:localizamed_app/blocs/conexaoAPI.dart';
import 'package:localizamed_app/classes/clinica_class.dart';
import 'dart:core';
import 'package:localizamed_app/components/clinic_grid_view.dart';
import 'package:localizamed_app/components/tab_med_in_clin.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:localizamed_app/components/tab_medico.dart';

class ClinicScreen extends StatefulWidget {
 // ClinicScreen(Clinicas clinica);

  @override
  _ClinicScreenState createState() => _ClinicScreenState();
}

class _ClinicScreenState extends State<ClinicScreen> {
  double appBarHeight = 400;

  @override
  Widget build(BuildContext context) {
    clinicaBloc.getClinica();
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    return Scaffold(
      body: StreamBuilder(
          stream: clinicaBloc.clinica,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Stack(
                children: <Widget>[
                  CustomScrollView(
                    slivers: <Widget>[
                      SliverPersistentHeader(
                        delegate: MySliverAppBar(
                          expandedHeight: appBarHeight,
                        ),
                      ),
                      SliverList(
                          delegate: SliverChildListDelegate(<Widget>[
                        Stack(
                          children: <Widget>[

                            //MEDICOS
                             Padding(
                              padding: EdgeInsets.only(                              
                                    top: size.height / 2.2),
                              child: MedCardInClin(),
                              ),
                               

                            //contatos entra aqui
                            Padding(
                                padding: EdgeInsets.only(                                    
                                    top: size.height / 6),
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)), //this right here
                                            child: Container(
                                              height: 200,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    TextField(
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'Selecione o telefone que deseja chamar'),
                                                    ),

                                                    //TELEFONE PRINCIPAL
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          snapshot.data.fone_1,
                                                          style: TextStyle(
                                                              fontSize: 25),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10),
                                                          child:
                                                              GestureDetector(
                                                            child: Icon(
                                                              Icons.phone,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                            onTap: () {
                                                              launch(
                                                                  "tel:${snapshot.data.fone_1}");
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        )
                                                      ],
                                                    ),

                                                    SizedBox(
                                                      height: 10,
                                                    ),

                                                    //TELEFONE 2
                                                    snapshot.data.fone_2 == '0'
                                                        ? Container()
                                                        : Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Text(
                                                                snapshot.data
                                                                    .fone_2,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        25),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            10),
                                                                child:
                                                                    GestureDetector(
                                                                  child: Icon(
                                                                    Icons.phone,
                                                                    color: Colors
                                                                        .blue,
                                                                  ),
                                                                  onTap: () {
                                                                    launch(
                                                                        "tel:${snapshot.data.fone_2}");
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                ),
                                                              )
                                                            ],
                                                          )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        });
                                  },
                                  child: card(
                                      190,
                                      size.height / 3.4,
                                      Icons.phone,
                                      Colors.green,
                                      'Contato',
                                      snapshot.data.fone_1 +
                                          '\n' +
                                          snapshot.data.fone_2),
                                )),

                            //SITE
                            Padding(
                                padding: EdgeInsets.only(
                                    left: size.width / 2,
                                    top: size.height / 6),
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          if (snapshot.data.site == '') {
                                            return AlertDialog(
                                              title: Text(
                                                  "Sinto muito, mas essa clínica não possui um site."),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          } else {
                                            return AlertDialog(
                                              title: Text(
                                                  "Deseja visitar o site desta clínica?"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("Sim"),
                                                  onPressed: () {
                                                    launch(
                                                        "https://${snapshot.data.site}");
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text("Não"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            );
                                          }
                                        });
                                  },
                                  child: card(
                                      190,
                                      size.height / 3.4,
                                      Icons.web,
                                      Colors.black,
                                      'Site',
                                      snapshot.data.site == ''
                                          ? "Sem site"
                                          : snapshot.data.site),
                                )),
                            
                            
                           
                            
                            
                            
                          ],
                        )
                      ]))
                    ],
                  ),
                ],
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.arrow_back,
          size: 30,
          color: Colors.white,
        ),
        onPressed: () async {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  final data;

  MySliverAppBar({@required this.expandedHeight, this.data});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    clinicaBloc.getClinica();
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    return StreamBuilder(
        stream: clinicaBloc.clinica,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              fit: StackFit.expand,
              overflow: Overflow.visible,
              children: [
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                  image: NetworkImage(ConexaoAPI().api +
                      'imagensClinica/' +
                      snapshot.data.caminhoFoto),
                  fit: BoxFit.fill,
                ))),
                /* Image.asset(
                  "images/teste.jpg",
                  fit: BoxFit.cover,
                ), */
                Container(
                  padding:
                      EdgeInsets.only(top: expandedHeight / 1.7 - shrinkOffset),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.3, 1],
                          colors: [Colors.transparent, Colors.white])),
                  child: Padding(
                      padding: EdgeInsets.only(left: size.width / 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            snapshot.data.nome,
                            style: TextStyle(fontSize: 35, color: Colors.white),
                          ),
                          Container(
                              width: size.width / 2,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 4, color: Colors.green))))
                        ],
                      )),
                ),
                Positioned(
                    top: expandedHeight / 1.3 - shrinkOffset,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Desejar ver a localização desta clínica no mapa?"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Sim"),
                                          onPressed: () {
                                            launch(
                                                "https://www.google.com/maps/search/?api=1&query="
                                                "${snapshot.data.latitute},"
                                                "${snapshot.data.longitude}");
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        FlatButton(
                                          child: Text("Não"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: card(
                                //190,
                                size.width / 1.1,
                                size.height / 3.8,
                                FontAwesomeIcons.locationArrow,
                                Theme.of(context).primaryColor,
                                'Localização',
                                snapshot.data.bairro),
                          ),
                        ),
                      ],
                    )),

                                        
              ],
            );
          }
        });
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
