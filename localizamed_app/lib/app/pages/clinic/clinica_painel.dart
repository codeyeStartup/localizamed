import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:localizamed_app/app/pages/clinic/tab_clinica.dart';

class ClinicaCardScreen extends StatefulWidget {
  @override
  _ClinState createState() => _ClinState();
}

class _ClinState extends State<ClinicaCardScreen> {

  String _connectionStatus = 'unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState(){ 
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
                  children: <Widget>[
                    Text("LocalizaMed",
                        style: TextStyle(
                            fontSize: size.width / 20,
                            fontFamily: 'Montserrat-Bold',
                            fontWeight: FontWeight.w900)),
                    Image(
                      image: AssetImage('images/pin.png'),
                      color: Colors.green,
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
                        : ClinCard()
            ],
          ),
        ),
      )),
    );
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
