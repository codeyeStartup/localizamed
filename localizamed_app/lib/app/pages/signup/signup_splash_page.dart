import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:localizamed_app/app/pages/home/home_page.dart';

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
          context, MaterialPageRoute(builder: (context) => BottomMenu()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingJumpingLine.square(
          backgroundColor: Theme.of(context).primaryColor,
        ),
      )
    );
  }
}
