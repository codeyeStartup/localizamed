import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localizamed_app/app/pages/initial/initial_card.dart';
import 'package:localizamed_app/app/pages/search/search_screen.dart';
import 'package:localizamed_app/app/utils/slideRoutes.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool isActive = false;

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
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 10,
                        top: MediaQuery.of(context).size.height / 30),
                    child: Row(
                      children: <Widget>[
                        Image(
                          image: AssetImage('images/icon.png'),
                          width: 40,
                          height: 40,
                        ),
                        Text(
                          'Explore',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Montserrat-ExtraBold'),
                        ),
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 40),
                    width: MediaQuery.of(context).size.width / 1.8,
                    height: MediaQuery.of(context).size.height / 16,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              color: Colors.black26,
                              offset: Offset(1, 2))
                        ]),
                    child: FlatButton(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Pesquisar',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Montserrat-Bold',
                                fontSize: 12),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.4,
                          ),
                          Icon(
                            FontAwesomeIcons.search,
                            size: 16,
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context, SlideTopRoute(page: SearchScreen()));
                      },
                    ))
              ],
            )),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: LayoutBuilder(
          builder: (context, constrains) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 9,
                        top: MediaQuery.of(context).size.height / 8),
                    padding: EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                width: 4,
                                color: Theme.of(context).primaryColor))),
                    child: Text(
                      'Ultimas Clínicas',
                      style: TextStyle(
                          fontSize: 26, fontFamily: 'Montserrat-ExtraBold'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                   _connectionStatus == 'ConnectivityResult.none'
                          ? Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 4),
                              child: Center(
                                  child: Text(
                                    'Não foi possível se conectar. Tente novamente.',
                                    textAlign: TextAlign.center,
                                  )),
                            )
                          : InitialCard()  
                ],
              ),
            );
          },
        ));
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
