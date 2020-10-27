import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:localizamed_app/app/pages/login/login_bloc.dart';
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:localizamed_app/app/validators/signup_validator.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SingletonBloc with SignupValidator {

  Future<Map<String, dynamic>> signUp(String nome, String dateNasc, String phone, String email, String senha) async{
    Map payload = {
       "nome": nome,
        "email": email,
        "data_nascimento": dateNasc,
        "fone_1": phone,
        "senha": senha,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = ConexaoAPI().api + "usuarios";
    Map<String, String> headers = {"Accept": "application/json"};

    try{
      var response = await http.post(url, headers: headers, body: payload);
      Map mapResponse = json.decode(response.body);

      prefs.setString('tokenjwt', mapResponse['token']);
      await LoginBloc().saveUserAuthentication(mapResponse);

      return {
        'message': 'SignUp successful',
        'code' : response.statusCode
      };
    } catch(err){
      if (err.error is SocketException){
        return {
        'message' : err.message,
        'code': 500
      };
      }
      return {
        'message' : err.response.data['msg'],
        'code': 400
      };
    }
  }
}
