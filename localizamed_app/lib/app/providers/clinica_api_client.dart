import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:localizamed_app/app/models/clinica_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClinicaApiProvider {
  Future<Clinicas2> getClinicaById() async {
    SharedPreferences prefs= await SharedPreferences.getInstance();
    var id = prefs.getString('id');
    var token = prefs.getString('tokenjwt');

    final response = await http.get(ConexaoAPI().api + 'clinica/' + id,
        headers: {"Accept": "application/json", "x-access-token" : token});

    if (response.statusCode == 200) {
      //print(response.body);
      return Clinicas2.fromJson(json.decode(response.body));      
    } else {
      print("Entrou no exception de erro");
      throw Exception('Falha ao carregar Clinica T-T');
    }
  }
}
