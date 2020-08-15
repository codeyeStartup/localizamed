import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/app/models/medicos_model.dart';
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:rxdart/rxdart.dart';
import 'clinica_modelTest.dart';

class Services {
  final _searchController = BehaviorSubject<String>();
  Stream<String> get outSearch => _searchController.stream;
  Function(String) get changeSearch => _searchController.sink.add;

  Future<Search_model> search() async {
    final search = _searchController.value.trim();

    final url = ConexaoAPI().api + 'search_clinica';
    var headers = {"Accept": "application/json"};

    Map params = {"search": search};

    var response = await http.post(url, body: params, headers: headers);

    Map mapResponse = json.decode(response.body);
    try {
      if(response.statusCode == 200){
        var listClinic = Search_model.fromJson(mapResponse);
        return listClinic;
      }else{
        print('Erro get search clinic');
      }
    } catch (err) {
      print(err);
      return err;
    }
  }
}
