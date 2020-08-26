import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localizamed_app/app/app_bloc.dart';
import 'package:localizamed_app/app/pages/splash_screen/splash_screen.dart';
import 'package:localizamed_app/app/pages/onboard_page/onboard_page.dart';

Widget verifyUserLogged() {
  return FutureBuilder(
    future: AppBloc().verifyUserLogged(),
    builder: (_, snapshot) {
      return snapshot.data != true ? OnboardPage() : SplashScreen();
    },
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    statusBarColor: Colors.grey[400],
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(MaterialApp(
      title: 'LocalizaMed',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color.fromARGB(
              255, 23, 55, 254), //pode alterar para a cor do aplicativo
          fontFamily: 'Montserrat-Medium'),
      home: verifyUserLogged()));
}
