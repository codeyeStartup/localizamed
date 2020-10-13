import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localizamed_app/app/utils/msg_sem_internet.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4)).then((_){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MsgInt()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height ,
      color: Colors.white,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 5,
          child: Image.asset('images/placeholder.png', width: MediaQuery.of(context).size.width / 6 ,
          height: MediaQuery.of(context).size.height / 6,
          )
        )
      )
    );
  }
}
