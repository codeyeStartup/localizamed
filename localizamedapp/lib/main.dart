import 'package:flutter/material.dart';
import 'package:localizamedapp/screens/login_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        title: "Teste",
        theme: ThemeData(
            primaryColor: Colors.blue //pode alterar para a cor do aplicativo
        ),
        debugShowCheckedModeBanner: false,
        home: LoginScreen()
    );
  }
}
