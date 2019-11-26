import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/blocs/conexaoAPI.dart';
import 'package:localizamed_app/components/tab_medico.dart';

List<Medicos> parseMedicos(String responseBody){
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Medicos>((json) => Medicos.fromJson(json)).toList();
}

Future<List<Medicos>> getMedicos(http.Client client) async {
  final response = await http.get(Uri.encodeFull( ConexaoAPI().api + 'medicos'),
     headers: {"Accept": "application/json"}
     
  ); 
  //print(response.body);  
   
  
  if (response.statusCode == 200) {
    //print("Status code OK");
    return parseMedicos(response.body);  
    
  } else {
    print("Entrou no exception de erro");
    throw Exception('Falha ao carregar Medicos');    
  }
}

class Medicos {
  final String nome;
  final String cidade;
  final String caminhoFoto;

  Medicos({this.nome, this.cidade, this.caminhoFoto});

  factory Medicos.fromJson(Map<String, dynamic> json) {
    return Medicos(
      nome: json['nome'] as String,
      cidade: json['cidade'] as String,
      caminhoFoto: json['caminho_foto'] as String,
    );
  }
}

void main() => runApp(MedCard());
