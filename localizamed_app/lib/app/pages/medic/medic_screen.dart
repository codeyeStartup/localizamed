import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:localizamed_app/app/pages/medic/tab_medico.dart';

class CardMedicoScreen extends StatefulWidget {
  @override
  _CardMedicoScreenState createState() => _CardMedicoScreenState();
}

class _CardMedicoScreenState extends State<CardMedicoScreen> {
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
                    padding: EdgeInsets.only(left: size.width/ 2.9, top: size.height/ 60),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("LocalizaMed",
                            style: TextStyle(
                              fontSize: size.width / 20,
                              fontFamily: 'Montserrat-Bold',
                              fontWeight: FontWeight.w900
                            )),
                        Image(
                          image: AssetImage('images/pinred.png'),
                          width: size.width / 20,
                          height: size.height / 20,
                        ),
                      ],
                    ),
                  ),
                  MedCard(),
                ],
              ),
            ),
          )
      ),
    );
  }
}
