import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/blocs/conexaoAPI.dart';
import 'package:localizamed_app/classes/clinica_class.dart';
import 'package:localizamed_app/classes/tres_clinicas_class.dart';

class UltimasClinicasApiProvider {
  Future<List<TresClinicas>> getUltimas() async {
    final response = await http.get(ConexaoAPI().api + 'clinicaLastThree',
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed.map<TresClinicas>((json) => TresClinicas.fromJson(json)).toList();
    } else {
      print("Entrou no exception de erro");
      throw Exception('Falha ao carregar Clinicas');
    }
  }
}