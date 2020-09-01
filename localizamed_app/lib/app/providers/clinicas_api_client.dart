import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:localizamed_app/app/models/clinica_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClinicasApiProvider {
  Future<List<Clinicas>> getClinicas() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('tokenjwt');
    final response = await http.get(ConexaoAPI().api + 'clinicas',
        headers: {"Accept": "application/json", "x-access-token" : token});

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Clinicas>((json) => Clinicas.fromJson(json)).toList();
    } else {
      print("Entrou no exception de erro");
      throw Exception('Falha ao carregar Clinicas');
    }
  }
}
