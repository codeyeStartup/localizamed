import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/blocs/conexaoAPI.dart';
import 'package:localizamed_app/classes/user_class.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserApiProvider{

 Future<Usuario> getUsuario() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  final response = await http.get(Uri.encodeFull(ConexaoAPI().api + 'usuarioFindOne/' + email),      
      headers: {"Accept": "application/json"});
      //print(response.body);      

  if (response.statusCode == 200) {
    //print("Status code OK");
   return Usuario.fromJson(json.decode(response.body));
  } else {
    print("Entrou no exception de erro");
    throw Exception('Falha ao carregar Usuario');
  }
}
}