import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/blocs/conexaoAPI.dart';
import 'package:localizamed_app/classes/clinica_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClinicaApiProvider {
  Future<Clinicas2> getClinicaById() async {
    SharedPreferences prefId = await SharedPreferences.getInstance();
    var id = prefId.getString('id');

    final response = await http.get(ConexaoAPI().api + 'clinica/' + id,
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      //print(response.body);
      return Clinicas2.fromJson(json.decode(response.body));      
    } else {
      print("Entrou no exception de erro");
      throw Exception('Falha ao carregar Clinica T-T');
    }
  }
}
