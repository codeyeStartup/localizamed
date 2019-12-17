

import 'package:localizamed_app/classes/clinica_class.dart';
import 'package:localizamed_app/classes/user_class.dart';
import 'package:localizamed_app/classes/medicos_class.dart';
import 'package:localizamed_app/repositories/clinica_api_client.dart';
import 'package:localizamed_app/repositories/medico_api_provider.dart';
import 'package:localizamed_app/repositories/user_api_client.dart';

class Repository{
  UserApiProvider appUserApiProvider = UserApiProvider();
  ClinicaApiProvider appClinicaApiProvider = ClinicaApiProvider();
  MedicoApiProvider appMedicoApiProvider = MedicoApiProvider();

  Future<Usuario> getUsuario() => appUserApiProvider.getUsuario();
  Future<Clinicas2> getClinicaById() => appClinicaApiProvider.getClinicaById();
  Future<List<Medicos>> getMedicos() => appMedicoApiProvider.getMedicos();
  }