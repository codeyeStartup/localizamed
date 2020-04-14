import 'package:localizamed_app/app/models/user_model.dart';
import 'package:localizamed_app/app/repositories/repositories.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc {
  Repository _repository = Repository();

  final _usuarioGet = BehaviorSubject<Usuario>();

  BehaviorSubject<Usuario> get usuario => _usuarioGet.stream;

  getUser() async{
    Usuario usuarioRes = await _repository.getUsuario();
    _usuarioGet.sink.add(usuarioRes);
  }

  dispose(){
    _usuarioGet.close();
  }
}

final userBloc = UserBloc();