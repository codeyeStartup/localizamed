import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localizamed_app/app/pages/clinic/clinica.bloc.dart';
import 'package:localizamed_app/app/pages/medic/tab_med_in_clin.dart';
import 'package:url_launcher/url_launcher.dart';

class ClinicPageView extends StatefulWidget {
  @override
  _ClinicPageViewState createState() => _ClinicPageViewState();
}

class _ClinicPageViewState extends State<ClinicPageView> {
  @override
  void initState() {
    clinicaBloc.getClinica();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    return StreamBuilder(
        stream: clinicaBloc.clinica,
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ));
          } else {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  "Deseja ver a localização desta clínica no mapa?"),
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
                    child: Padding(
                        padding: EdgeInsets.only(top: size.height / 12),
                        child: Container(
                          padding: EdgeInsets.all(18),
                          width: size.width / 1.2,
                          height: size.height / 4,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                  image: AssetImage('images/capturar3.png'),
                                  fit: BoxFit.cover),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5,
                                    color: Colors.black12,
                                    offset: Offset(1, 2))
                              ]),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text("Localização",
                                  style: TextStyle(
                                      fontSize: 22,
                                      shadows: <Shadow>[
                                        Shadow(
                                            offset: Offset(2.0, 2.0),
                                            blurRadius: 3.0,
                                            color: Colors.black26),
                                      ],
                                      color: Color.fromARGB(255, 32, 32, 255))),
                              SizedBox(
                                width: size.width / 2.9,
                              ),
                              Icon(
                                FontAwesomeIcons.locationArrow,
                                color: Color.fromARGB(255, 32, 32, 255),
                                size: 30,
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: size.height / 16,
                  ),
                  Container(
                    width: size.width / 1.2,
                    height: size.height / 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Telefones', style: TextStyle(fontSize: 22)),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        "Desejar ligar para o número ${snapshot.data.fone_1} ?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Sim"),
                                        onPressed: () {
                                          launch("tel:${snapshot.data.fone_1}");
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
                          child: Row(
                            children: <Widget>[
                              Icon(FontAwesomeIcons.phoneAlt,
                                  color: Colors.green),
                              SizedBox(width: 10),
                              snapshot.data.fone_1 == '' ? Text('Telefone não informado') :
                                    Text(
                                      snapshot.data.fone_1,
                                      style: TextStyle(fontSize: 16),
                                    )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        snapshot.data.fone_2 == '0'
                            ? Container()
                            : GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              "Desejar ligar para o número ${snapshot.data.fone_2} ?"),
                                          actions: <Widget>[
                                            FlatButton(
                                              child: Text("Sim"),
                                              onPressed: () {
                                                launch(
                                                    "tel:${snapshot.data.fone_2}");
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
                                child: Row(
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.phoneAlt,
                                        color: Colors.green),
                                    SizedBox(width: 10),
                                    snapshot.data.fone_2 == '' ? Text('Telefone não informado') :
                                    Text(
                                      snapshot.data.fone_2,
                                      style: TextStyle(fontSize: 16),
                                    )
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),

                  //SITE
                  Container(
                      width: size.width / 1.2,
                      height: size.height / 8,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Site', style: TextStyle(fontSize: 22)),
                            SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      if (snapshot.data.site == '') {
                                        return AlertDialog(
                                          title: Text(
                                              "Sinto muito, mas essa clínica não possui um site :("),
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
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.web, color: Colors.black),
                                  SizedBox(width: 10),
                                  Text(
                                    snapshot.data.site == ''
                                        ? "Esta clínica não possui site"
                                        : snapshot.data.site,
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            )
                          ])),
                  Container(
                    width: size.width / 1.2,
                    child: Text('Exames e Consultas',
                        style: TextStyle(fontSize: 22)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: size.width / 1.2,
                      height: size.height / 4,
                      child: ListView.builder(
                        padding: EdgeInsets.all(8),
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount:
                            snapshot?.data?.examConsultaClin?.length ?? 0,
                        itemBuilder: (context, index) {
                          return Row(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(10),
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color.fromARGB(255, 32, 32, 255),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                snapshot.data.examConsultaClin[index]
                                    .exameConsultaId.exame,
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          );
                        },
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  //label de MEDICOS
                  Container(
                    width: size.width / 1.2,
                    child: Text('Médicos', style: TextStyle(fontSize: 22)),
                  ),
                  MedCardInClin()
                ],
              ),
            );
          }
        });
  }
}
