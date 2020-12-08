import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:localizamed_app/app/models/medic_infoModel.dart';
import 'package:localizamed_app/app/pages/clinic/clinic_screen.dart';
import 'package:localizamed_app/app/utils/slideRoutes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/conexaoAPI.dart';
import 'medicos_bloc.dart';

class CardMedicoScreen extends StatefulWidget {
  @override
  _CardMedicoScreenState createState() => _CardMedicoScreenState();
}

class _CardMedicoScreenState extends State<CardMedicoScreen> {
  ConexaoAPI conexaoApi;
  Future<Medic_info> medicData;
  final medicoBloc = MedicosBloc();

  String _connectionStatus = 'unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    medicoBloc.getMedicos();
    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  void dispose(){
    _connectivitySubscription.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                    left: size.width / 2.9, top: size.height / 60),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text("LocalizaMed",
                        style: TextStyle(
                            fontSize: size.width / 20,
                            fontFamily: 'Montserrat-Bold',
                            fontWeight: FontWeight.w900)),
                    Image(
                      image: AssetImage('images/pinred.png'),
                      width: size.width / 20,
                      height: size.height / 20,
                    ),
                  ],
                ),
              ),
               _connectionStatus == 'ConnectivityResult.none'
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3),
                            child: Center(
                                child: Text(
                                  'Não foi possível se conectar. Tente novamente.',
                                  textAlign: TextAlign.center,
                                )),
                          )
                        : medCard()
            ],
          ),
        ),
      )),
    );
  }

  Widget medCard() {
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 18.0,
          horizontal: 26.0,
        ),
        child: StreamBuilder(
            stream: medicoBloc.medico,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: LoadingBouncingLine.circle(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                );
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height / 30);
                  },
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot?.data?.length ?? 0,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    String image;
                    String _setImage() {
                      if (snapshot.data[index].temFoto == '0' &&
                          snapshot.data[index].sexo == 'M') {
                        image = 'images/homem_medico.png';
                      } else if (snapshot.data[index].temFoto ==
                              '0' /*|| snapshot.data[index].temFoto == '1' */ &&
                          snapshot.data[index].sexo != 'M') {
                        image = 'images/mulher_medico.png';
                      } else {
                        image = 'images/placeholder.png';
                      }
                      return image;
                    }

                    return GestureDetector(
                      onTap: () async {
                        SharedPreferences prefId =
                            await SharedPreferences.getInstance();
                        prefId.setString('id', snapshot.data[index].sId);
                        medicInfo(context);
                      },
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.height / 6.5,
                            width: MediaQuery.of(context).size.width / 1.3,
                            margin: new EdgeInsets.only(left: 46.0),
                            decoration: new BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.circular(8.0),
                                boxShadow: <BoxShadow>[
                                  new BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 5.0,
                                    offset: new Offset(2.0, 5.0),
                                  )
                                ]),
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 22),
                              padding: EdgeInsets.only(left: 50),
                              child: ListTile(
                                  title: Text(
                                    snapshot.data[index].nome,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: 'Montserrat-Bold',
                                        fontWeight: FontWeight.w600),
                                  ),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 3, bottom: 4),
                                        child: Text(
                                          snapshot.data[index].especialidade ==
                                                  null
                                              ? 'Especialiade não informada'
                                              : snapshot
                                                  .data[index].especialidade,
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(top: 6),
                                        color: Colors.redAccent,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        height: 2,
                                      )
                                    ],
                                  )),
                            ),
                          ),
                          Container(
                            margin: new EdgeInsets.symmetric(vertical: 18),
                            alignment: FractionalOffset.centerLeft,
                            child: new Container(
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 4,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(270)),
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: snapshot.data[index].caminhoFoto ==
                                            null
                                        ? AssetImage(_setImage())
                                        : NetworkImage(
                                            snapshot.data[index].caminhoFoto),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }));
  }

  medicInfo(context) {
    AlertDialog info = AlertDialog(
      contentPadding: EdgeInsets.all(10),
      content: Container(
        height: MediaQuery.of(context).size.height / 4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 6,
                ),
                Text('Clínicas'),
              ],
            ),
            Expanded(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: FutureBuilder(
                      future: medicoBloc.medicInfo(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: LoadingBouncingLine.circle(
                              backgroundColor: Theme.of(context).primaryColor,
                              size: 35,
                            ),
                          );
                        } else {
                          return ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    child: ListTile(
                                      title: Text(snapshot.data[index].nome),
                                    ),
                                    onTap: () async {
                                      SharedPreferences prefId = await SharedPreferences.getInstance();
                                      prefId.setString('id', snapshot.data[index].sId);
                                      Navigator.push(context, SlideTopRoute(page: ClinicScreen()));
                                    });
                              });
                        }
                      })),
            )
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return info;
        });
  }

  Future<void> _initConnectivity() async{
    ConnectivityResult result;

    try{
      result = await _connectivity.checkConnectivity();
    } catch(e){
      print(e.toString());
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async{
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(()=> _connectionStatus = result.toString());
        break;
    }
  }
}
