import 'package:localizamed_app/app/models/medicos_model.dart';
import 'package:localizamed_app/app/repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

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
}

final medicoBloc = MedicosBloc();