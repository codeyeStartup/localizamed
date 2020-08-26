import 'dart:convert';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class AppBloc{

  Future<bool> verifyLogin() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map tokens = jsonDecode(prefs.get("tokens"));
    return tokens.length > 0 ? true : false;
  }

  Future<bool> verifyUserLogged() async{
    return await verifyLogin();
  }

}