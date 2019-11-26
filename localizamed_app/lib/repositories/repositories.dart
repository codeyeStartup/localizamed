

import 'package:localizamed_app/classes/user_class.dart';
import 'package:localizamed_app/repositories/user_api_client.dart';

class Repository{
  UserApiProvider appUserApiProvier = UserApiProvider();

  Future<Usuario> getUsuario() => appUserApiProvier.getUsuario();
}