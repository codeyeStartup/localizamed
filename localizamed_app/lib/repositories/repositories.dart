
import 'package:localizamed_app/classes/clinica_class.dart';
import 'package:localizamed_app/classes/tres_clinicas_class.dart';
import 'package:localizamed_app/classes/user_class.dart';
import 'package:localizamed_app/classes/medicos_class.dart';
import 'package:localizamed_app/repositories/clinica_api_client.dart';
import 'package:localizamed_app/repositories/clinicas_api_client.dart';
import 'package:localizamed_app/repositories/medico_api_provider.dart';
import 'package:localizamed_app/repositories/pesquisa_client.dart';
import 'package:localizamed_app/repositories/user_api_client.dart';
import 'package:localizamed_app/repositories/ultimas_3clinicas_api_provider.dart';


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