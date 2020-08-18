import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:localizamed_app/app/pages/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localizamed_app/app/pages/splash_screen/splash_screen.dart';
import 'package:localizamed_app/app/pages/onboard_page/onboard_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Map token = json.decode(prefs.get('tokens'));
  final Map email = token["userData"];

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    statusBarColor: Colors.grey[400],
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  runApp(MaterialApp(
    title: 'LocalizaMed',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
            primaryColor: Color.fromARGB(255, 23, 55, 254) ,//pode alterar para a cor do aplicativo
            fontFamily: 'Montserrat-Medium'
        ),
    home: email['email'] == null ? OnboardPage() : SplashScreen()));
}