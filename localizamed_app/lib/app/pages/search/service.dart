import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:localizamed_app/app/models/medicos_model.dart';
import 'clinica_modelTest.dart';

class Services {
  static const String url = 'http://10.0.0.108:8081/search_clinica';


  static Future<List<Clinicas>> getClinicas() async{
    
    var response = await http.get(url);

    var clinicas = List<Clinicas>();

    if(response.statusCode == 200){
      var clinicasJson = json.decode(response.body).cast<Map<String,dynamic>>();
      for (Map clinicaJson in clinicasJson){
        clinicas.add(Clinicas.fromJson(clinicaJson));
      }
    }
    
    print(response);
    return clinicas;
  }

/*   static Future<List<MedicosClin>> getMedicos() async{
    
    var response = await http.get(url);

    var medicos = List<MedicosClin>();

    if(response.statusCode == 200){
      var clinicasJson = json.decode(response.body);
      for (var clinicaJson in clinicasJson){
        medicos.add(MedicosClin.fromJson(clinicaJson));
      }
    }
    
    return medicos;
  } */

}
