import 'package:localizamed_app/classes/clinica_class.dart';
import 'package:localizamed_app/classes/user_class.dart';
import 'package:localizamed_app/repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ClinicaBloc {
  Repository _repository = Repository();

  final _clinicaGet = BehaviorSubject<Clinicas2>();

  BehaviorSubject<Clinicas2> get clinica => _clinicaGet.stream;

  getClinica() async {
    Clinicas2 clinicaRes = await _repository.getClinicaById();
    _clinicaGet.sink.add(clinicaRes);
  }

  dispose() {
    _clinicaGet.close();
  }
}

final clinicaBloc = ClinicaBloc();
