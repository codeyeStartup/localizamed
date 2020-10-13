import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:localizamed_app/app/pages/signup/signup_screen_2.dart';
import 'package:localizamed_app/app/utils/slideRoutes.dart';
import 'package:localizamed_app/app/utils/termos_de_uso.dart';

import '../login/login_screen.dart';

class SignUpHome extends StatefulWidget {
  @override
  _SignUpHomeState createState() => _SignUpHomeState();
}

class _SignUpHomeState extends State<SignUpHome> {
  String t = 'False';
  bool checkVal = false;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    return Scaffold(
        body: Container(
      width: size.width,
      height: size.height,
      child: Column(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: size.height / 20),
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Icon(Icons.close,
                        size: 30, color: Theme.of(context).primaryColor),
                    onPressed: () {
                      Navigator.push(
                          context, SlideRightRoute(page: LoginScreen()));
                    },
                  ),
                  SizedBox(
                    width: size.width / 6,
                  ),
                  Text('Bem Vindo',
                      style: TextStyle(
                          fontSize: 25, color: Theme.of(context).primaryColor))
                ],
              )),
          SizedBox(height: size.height / 1.8),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Faça seu cadastro em instantes',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: size.height / 40,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width / 20),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircularCheckBox(
                              value: checkVal,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.padded,
                              activeColor: Colors.green,
                              inactiveColor: Colors.black,
                              onChanged: (bool resp) {
                                setState(() {
                                  checkVal = resp;
                                });
                              },
                            ),
                            Text(
                              'Li e condordo com os',
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                        FlatButton(
                          child: Text('Termos de Uso e Política de Privacidade',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontSize: 16)),
                          onPressed: () {
                            terms(context);
                          },
                        ),
                      ],
                    )),
                SizedBox(
                  height: size.height / 20,
                ),
                checkVal == true
                    ? RaisedButton(
                        padding: EdgeInsets.symmetric(
                            vertical: size.height / 40,
                            horizontal: size.width / 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          'INICIAR CADASTRO',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: () {
                          Navigator.push(
                              context, SlideLeftRoute(page: SignUpScreen2()));
                        },
                      )
                    : RaisedButton(
                        padding: EdgeInsets.symmetric(
                            vertical: size.height / 40,
                            horizontal: size.width / 5),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          'INICIAR CADASTRO',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        color: Colors.white,
                        disabledColor: Colors.blueGrey,
                      )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
