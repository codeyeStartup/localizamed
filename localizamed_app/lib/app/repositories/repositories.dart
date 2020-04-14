import 'package:localizamed_app/app/models/clinica_model.dart';
import 'package:localizamed_app/app/models/tres_clinicas_model.dart';
import 'package:localizamed_app/app/models/user_model.dart';
import 'package:localizamed_app/app/models/medicos_model.dart';
import 'package:localizamed_app/app/providers/clinica_api_client.dart';
import 'package:localizamed_app/app/providers/clinicas_api_client.dart';
import 'package:localizamed_app/app/providers/medico_api_provider.dart';
import 'package:localizamed_app/app/providers/pesquisa_client.dart';
import 'package:localizamed_app/app/providers/user_api_client.dart';
import 'package:localizamed_app/app/providers/ultimas_3clinicas_api_provider.dart';


class Repository{
  UserApiProvider appUserApiProvider = UserApiProvider();
  ClinicaApiProvider appClinicaApiProvider = ClinicaApiProvider();
  MedicoApiProvider appMedicoApiProvider = MedicoApiProvider();
  ClinicasApiProvider appClinicasListApiProvider = ClinicasApiProvider();
  UltimasClinicasApiProvider appUltimasClinicasApiProvider = UltimasClinicasApiProvider();
  PesquisaApiProvider appPesquisaApiProvieder = PesquisaApiProvider();
  
//appUltimasClinicasApiProvider
  Future<Usuario> getUsuario() => appUserApiProvider.getUsuario();
  Future<Clinicas2> getClinicaById() => appClinicaApiProvider.getClinicaById();
  Future<List<Medicos>> getMedicos() => appMedicoApiProvider.getMedicos();
  Future<List<Clinicas>> getClinicas() => appClinicasListApiProvider.getClinicas();
  Future<TresClinicas> getUltimas() => appUltimasClinicasApiProvider.getUltimas();
  Future<List<Clinicas>> getPesquisa() => appPesquisaApiProvieder.getPesquisa();
 }