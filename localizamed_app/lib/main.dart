import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localizamed_app/app/pages/login/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localizamed_app/app/pages/splash_screen/splash_screen.dart';
import 'package:localizamed_app/app/pages/onboard_page/onboard_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  print(email);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    statusBarColor: Colors.grey[400],
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  runApp(MaterialApp(
    title: 'LocalizaMed',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
            primaryColor: Color.fromARGB(255, 29, 26, 255) ,//pode alterar para a cor do aplicativo
            fontFamily: 'BreeSerif'
        ),
    home: email == null ? OnboardPage() : SplashScreen()));
}