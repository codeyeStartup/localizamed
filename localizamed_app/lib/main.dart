import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:localizamed_app/components/tab_clinica.dart';
//import 'package:localizamed_app/components/user_page_comp.dart';
import 'package:localizamed_app/screens/bottom_menu_screen.dart';
import 'package:localizamed_app/screens/cadastro_screen.dart';
import 'package:localizamed_app/screens/home_screen.dart';
import 'package:localizamed_app/screens/login_screen.dart';
import 'package:localizamed_app/screens/medico_painel.dart';
//import 'package:localizamed_app/screens/screen_2.dart';
import 'package:localizamed_app/screens/signup/signup_screen_2.dart';
import 'package:localizamed_app/screens/signup/signup_screen_3.dart';
import 'package:localizamed_app/screens/signup/signup_screen_4.dart';
import 'package:localizamed_app/screens/signup/signup_screen_5.dart';
import 'package:localizamed_app/screens/signup/signup_screen_home.dart';
//import 'package:localizamed_app/screens/usuario_painel.dart';
import 'package:localizamed_app/screens/whome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:localizamed_app/screens/clinic_screen.dart';
import 'package:localizamed_app/screens/splash_screen.dart';

/* void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        title: "Teste",
        theme: ThemeData(
            primaryColor: Color.fromARGB(255, 29, 26, 255) ,//pode alterar para a cor do aplicativo
            fontFamily: 'BreeSerif'
        ),
        debugShowCheckedModeBanner: false,
        home: SignUpHome()
    );
  }
} */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  //prefs.remove('email');
  //email = null;
  print(email);
  
  runApp(MaterialApp(
    title: 'LocalizaMed',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
            primaryColor: Color.fromARGB(255, 29, 26, 255) ,//pode alterar para a cor do aplicativo
            fontFamily: 'BreeSerif'
        ),
    home: email == null ? LoginScreen() : SplashScreen()));
}
