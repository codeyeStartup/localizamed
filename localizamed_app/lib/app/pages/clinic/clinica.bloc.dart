import 'package:localizamed_app/app/models/clinica_model.dart';
import 'package:localizamed_app/app/models/tres_clinicas_model.dart';
import 'package:localizamed_app/app/repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

class ClinicaBloc {
  Repository _repository = Repository();

  final _clinicaGet = BehaviorSubject<Clinicas2>();
  final _clinicasListGet = BehaviorSubject<List<Clinicas>>();
  final _ultimasclinicasListGet = BehaviorSubject<TresClinicas>();

  BehaviorSubject<Clinicas2> get clinica => _clinicaGet.stream;
  BehaviorSubject<List<Clinicas>> get clinicasList => _clinicasListGet.stream;
  BehaviorSubject<TresClinicas> get ultimasclinicasList => _ultimasclinicasListGet.stream;

  //3 Ultimas clinicas
  getUltimasClinicas() async {
  TresClinicas clinicasRes = await _repository.getUltimas();
    _ultimasclinicasListGet.sink.add(clinicasRes);
  }

  //uma UNICA clinica
  getClinica() async {
    Clinicas2 clinicaRes = await _repository.getClinicaById();
    _clinicaGet.sink.add(clinicaRes);
  }

  //lista de TODAS as clinicas
  getListClinicas() async {
    List<Clinicas> clinicasRes = await _repository.getClinicas();
    _clinicasListGet.sink.add(clinicasRes);
  }

  dispose() {
    _clinicaGet.close();
    _clinicasListGet.close();
    _ultimasclinicasListGet.close();
  }
}

  final clinicaBloc = ClinicaBloc();
