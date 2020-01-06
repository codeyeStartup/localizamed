import 'package:flutter/material.dart';
import 'package:localizamed_app/components/msg_sem_internet.dart';
import 'package:localizamed_app/screens/login_screen.dart';
import 'package:localizamed_app/screens/usuario_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        home: LoginScreen()
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
