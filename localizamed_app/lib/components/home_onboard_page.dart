import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:localizamed_app/screens/login_screen.dart';

class AnimatedButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    return AnimatedContainer(
        duration: Duration(milliseconds: 150),
        height: size.height / 14.1,
        width: double.infinity,
        color: Color.fromARGB(255, 23, 29, 255),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(80.0),
                topLeft: Radius.circular(80.0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: new Offset(5.0, 5.0),
                  blurRadius: 20.0,
                )
              ]
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                padding: EdgeInsets.all(10.0),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>LoginScreen())
                  );
                },
                child: Text(
                  "INICIAR",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'BreeSerif',
                      color: Color.fromARGB(255, 23, 29, 255)),
                ),
              )
            ],
          ),
        ));
  }
}
