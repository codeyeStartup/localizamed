import 'package:flutter/material.dart';
import 'package:localizamed_app/app/pages/clinic/tab_clinica.dart';

class ClinicaCardScreen extends StatefulWidget {
  @override
  _ClinState createState() => _ClinState();
}

class _ClinState extends State<ClinicaCardScreen> {
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
                      children: <Widget>[
                        Text("LocalizaMed",
                            style: TextStyle(
                              fontSize: size.width / 20,
                            )),
                        Image(
                          image: AssetImage('images/pin.png'),
                          color: Colors.green,
                          width: size.width / 20,
                          height: size.height / 20,
                        ),
                      ],
                    ),
                  ),
                  ClinCard(),
                ],
              ),
            ),
          )
      ),
    );
  }
}