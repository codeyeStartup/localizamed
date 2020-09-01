import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:localizamed_app/app/models/tres_clinicas_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UltimasClinicasApiProvider {
  Future<TresClinicas> getUltimas() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('tokenjwt');
    final response = await http.get(ConexaoAPI().api + 'clinicaLastThree',
        headers: {"Accept": "application/json", "x-access-token" : token});

    if (response.statusCode == 200) {   
      return TresClinicas.fromJson(json.decode(response.body));      
    } else {
      print("Entrou no exception de erro");
      throw Exception('Falha ao carregar TRÊS ultimas clinicas');
    }
  }
}