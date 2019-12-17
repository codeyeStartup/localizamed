import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/blocs/conexaoAPI.dart';
import 'package:localizamed_app/components/tab_medico.dart';
import 'package:localizamed_app/classes/medicos_class.dart';

List<Medicos> parseMedicos(String responseBody){
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Medicos>((json) => Medicos.fromJson(json)).toList();
}

Future<List<Medicos>> getMedicos(http.Client client) async {
  final response = await http.get(Uri.encodeFull( ConexaoAPI().api + 'medicos'),
     headers: {"Accept": "application/json"}
  ); 
  
  if (response.statusCode == 200) {
    return parseMedicos(response.body);      
  } else {
    print("Entrou no exception de erro");
    throw Exception('Falha ao carregar Medicos');    
  }
}

void main() => runApp(MedCard());
