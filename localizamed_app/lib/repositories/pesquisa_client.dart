import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/blocs/conexaoAPI.dart';
import 'package:localizamed_app/classes/clinica_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PesquisaApiProvider {
  Future<List<Clinicas>> getPesquisa() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var query = prefs.getString('query');

    final response = await http.get(
        ConexaoAPI().api +
            'search_clinica2/' +
            (query == null ? 'clin' : query),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 201) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Clinicas>((json) => Clinicas.fromJson(json)).toList();
    } else {
      print("Entrou no exception de erro");
      throw Exception('Falha ao carregar Clinicas');
    }
  }
}
