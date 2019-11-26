import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/blocs/conexaoAPI.dart';
import 'package:localizamed_app/classes/user_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

 
  

//------------------------------------------------------------

/* import 'dart:async';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/blocs/conexaoAPI.dart';
import 'package:localizamed_app/components/tab_medico.dart';
import 'package:localizamed_app/components/tab_usuario.dart';
import 'package:localizamed_app/screens/usuario_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  


class Usuario {
  final String id;
  final String nome;
  final String email;
  final String uf;
  final String fone_1;
  final String cidade;
  final String caminhoFoto;

  Usuario(
      {this.nome,
      this.cidade,
      this.caminhoFoto,
      this.email,
      this.fone_1,
      this.id,
      this.uf});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['_id'] as String,
      nome: json['nome'] as String,
      cidade: json['cidade'] as String,
      caminhoFoto: json['caminho_foto'] as String,
      email: json['email'] as String,
      fone_1: json['fone_1'] as String,
      uf: json['uf'] as String
    );
  }
} */
