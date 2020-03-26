import 'package:localizamed_app/classes/user_class.dart';
import 'package:localizamed_app/repositories/repositories.dart';
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