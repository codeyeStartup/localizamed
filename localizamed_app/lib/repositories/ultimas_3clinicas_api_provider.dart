import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/blocs/conexaoAPI.dart';
import 'package:localizamed_app/classes/tres_clinicas_class.dart';

class UltimasClinicasApiProvider {
  Future<TresClinicas> getUltimas() async {
    final response = await http.get(ConexaoAPI().api + 'clinicaLastThree',
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {   
      return TresClinicas.fromJson(json.decode(response.body));      
    } else {
      print("Entrou no exception de erro");
      throw Exception('Falha ao carregar TRÊS ultimas clinicas');
    }
  }
}