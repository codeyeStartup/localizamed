import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:localizamed_app/app/utils/msg_sem_internet.dart';

class SignupSplashPage extends StatefulWidget {
  @override
  _SignupSplashPageState createState() => _SignupSplashPageState();
}

class _SignupSplashPageState extends State<SignupSplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4)).then((_) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MsgInt()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingBouncingLine.circle(
          backgroundColor: Theme.of(context).primaryColor,
        ),
      )
    );
  }
}
