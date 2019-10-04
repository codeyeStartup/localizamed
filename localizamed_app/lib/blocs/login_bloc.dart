import 'dart:async';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
//import 'dart:convert';

//estados do login
enum LoginState {IDLE, CARREGANDO, SUCESSO, FALHA}

class LoginBloc extends BlocBase {
  
  //controladores
  final _emailController = BehaviorSubject<String>();
  final _senhaController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail => _emailController.stream;
  Stream<String> get outSenha => _senhaController.stream;

  //Login com a API
  Future<void> login() async{
    final email = _emailController.value;
    final senha = _senhaController.value;    

    _stateController.add(LoginState.CARREGANDO);

    String url = "http://192.168.0.221:8081/login";
    Map<String, String> headers = {"Accept": "application/json"};    

    try {
      http.Response response = await http.post(url,
        headers: headers,
        body: {          
          "email": email,
          "senha": senha
        });
      } catch (erro){
        _stateController.add(LoginState.FALHA);
    }
      
        /* }).catchError((erro){
          
        }); */

    //print(response.body);
  }

  @override
  void dispose() {
    _emailController.close();
    _senhaController.close();
    _stateController.close();
  }  
  
}