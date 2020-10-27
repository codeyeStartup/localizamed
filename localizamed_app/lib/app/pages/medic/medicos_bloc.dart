import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/app/models/medic_infoModel.dart';
import 'package:localizamed_app/app/models/medicos_model.dart';
import 'package:localizamed_app/app/repositories/repositories.dart';
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicosBloc {
  Repository _repository = Repository();

  final _medicoGet = BehaviorSubject<List<Medicos>>();

  BehaviorSubject<List<Medicos>> get medico => _medicoGet.stream;

  getMedicos() async {
    List<Medicos> medicosRes = await _repository.getMedicos();
    _medicoGet.sink.add(medicosRes);
  }

  dispose() {
    _medicoGet.close();
  }

  Future<List<Medic_info>> medicInfo() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var id = prefs.getString('id');
      var token = prefs.getString('tokenjwt');

      var url = ConexaoAPI().api + 'search_medico_clinica';
      var header = {"Accept": "application/json", "x-access-token": token};

      final response =
          await http.post(url, body: {"search": id}, headers: header);

      final data = response.body;
      
      final parsed = List<Medic_info>.from(json.decode(data).map((x)=> Medic_info.fromJson(x)));

      return parsed;
    } catch (err) {
      return err;
    }
  }
}
