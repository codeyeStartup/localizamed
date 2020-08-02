import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:localizamed_app/app/models/token_model.dart';
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
  saveUserAuthentication(Map accessToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool result =
        await preferences.setString('tokens', jsonEncode(accessToken));

    return result;
  }

  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    return token.toString();
  }

  Future<Token> login() async {
    final email = _emailController.value.trim();
    final senha = _senhaController.value.trim();

    _stateController.add(LoginState.CARREGANDO);

    String url = ConexaoAPI().api + "login";
    var headers = {"Accept": "application/json"};

    Map params = {"email": email, "senha": senha};

    var prefs = await SharedPreferences.getInstance();

    try {
      var response = await http.post(url, headers: headers, body: params);

      Map mapResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        var token = Token.fromJson(mapResponse);
        prefs.setString('tokenjwt', mapResponse['token']);

        _stateController.add(LoginState.SUCESSO);
      } else {
        _stateController.add(LoginState.FALHA);
      }
    } catch (erro) {
      print(_emailController);
      return /* _stateController.add(LoginState.FALHA )*/ erro;
    }
  }

  @override
  void dispose() {
    _emailController.close();
    _senhaController.close();
    _stateController.close();
  }
}
