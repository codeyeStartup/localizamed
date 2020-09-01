import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:localizamed_app/app/models/medicos_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicoApiProvider {
  Future<List<Medicos>> getMedicos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('tokenjwt');
    final response = await http.get(ConexaoAPI().api + 'medicos',
        headers: {"Accept": "application/json", "x-access-token" : token});

    if (response.statusCode == 200) {
      //print(response.body);
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<Medicos>((json) => Medicos.fromJson(json)).toList();
    } else {
      print("Entrou no exception de erro");
      throw Exception('Falha ao carregar Médicos T-T');
    }
  }
}
