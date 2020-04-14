import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:localizamed_app/app/validators/login_validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//estados do login
enum LoginState { IDLE, CARREGANDO, SUCESSO, FALHA }

class LoginBloc extends BlocBase with LoginValidators {
  //controladores
  final _emailController = BehaviorSubject<String>();
  final _senhaController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail => _emailController.stream.transform(validaEmail);
  Stream<String> get outSenha => _senhaController.stream.transform(validaSenha);
  Stream<LoginState> get outState => _stateController.stream;
  Stream<bool> get outSubmitValid => Observable.combineLatest2(
      outEmail,
      outSenha,
      (
        a,
        b,
      ) =>
          true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _senhaController.sink.add;

  //Login com a API
  Future<void> login() async {
    final email = _emailController.value.trim();
    final senha = _senhaController.value.trim();

    _stateController.add(LoginState.CARREGANDO);

    String url = ConexaoAPI().api + "login";
    Map<String, String> headers = {"Accept": "application/json"};

    try {
      http.Response response = await http
          .post(url, headers: headers, body: {"email": email, "senha": senha});
      if (response.statusCode == 201) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', _emailController.value);
        
        _stateController.add(LoginState.SUCESSO);
      } else {
        _stateController.add(LoginState.FALHA);
      }
    } catch (erro) {
      print(_emailController);
      return _stateController.add(LoginState.FALHA);
    }
  }

  @override
  void dispose() {
    _emailController.close();
    _senhaController.close();
    _stateController.close();
  }
}