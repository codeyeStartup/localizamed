import 'dart:async';
import 'dart:convert';
import 'package:localizamed_app/classes/clinica_class.dart';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/blocs/conexaoAPI.dart';

List<Clinicas> parseClinicas(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Clinicas>((json) => Clinicas.fromJson(json)).toList();
}

Future<List<Clinicas>> getClinicas(http.Client client) async {
  final response = await http.get(Uri.encodeFull(ConexaoAPI().api + 'clinicas'),
      headers: {"Accept": "application/json"});

  if (response.statusCode == 200) {
    return parseClinicas(response.body);
  } else {
    print("Entrou no exception de erro");
    throw Exception('Falha ao carregar Clinicas');
  }
}

