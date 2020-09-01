import 'dart:async';
import 'dart:convert';
import 'package:localizamed_app/app/pages/login/login_bloc.dart';
import 'package:localizamed_app/app/pages/user_profile/user_bloc.dart';
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:localizamed_app/app/validators/signup_validator.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

//estados do cadastro
enum SignupState { IDLE, CARREGANDO, SUCESSO, FALHA, CATCH_ERRO }
enum UpdateState { IDLE, SUCESSO, FALHA, CATCH_ERRO }

class SingletonBloc with SignupValidator {
  static SingletonBloc _signupBloc;
//devolva sempre a mesma instancia
  factory SingletonBloc() {
    if (_signupBloc == null) _signupBloc = SingletonBloc._();
    return _signupBloc;
  }
// coloque aqui seus controllers e as variaveis que você vai acessar

//controladores
  BehaviorSubject<String> _nomeController;
  BehaviorSubject<String> _dataNascController;
  BehaviorSubject<String> _emailController;
  BehaviorSubject<String> _ufController;
  BehaviorSubject<String> _cidadeController;
  BehaviorSubject<String> _telefoneController;
  BehaviorSubject<String> _senhaController;
  BehaviorSubject<String> _cpfController;
  BehaviorSubject<String> _rgController;
  BehaviorSubject<String> _extraTelefoneController;
  BehaviorSubject<SignupState> _stateController;
  BehaviorSubject<UpdateState> _updateController;
  BehaviorSubject<String> _ufUpdateController;

  //Streams
  Stream<String> get outNome => _nomeController.stream.transform(validaNome);
  Stream<String> get outDataNasc => _dataNascController.stream;
  Stream<String> get outEmail => _emailController.stream.transform(validaEmail);
  Stream<String> get outUf => _ufController.stream;
  Stream<String> get outCidade =>
      _cidadeController.stream.transform(validaCidade);
  Stream<String> get outTelefone =>
      _telefoneController.stream.transform(validaTelefone);
  Stream<String> get outSenha => _senhaController.stream.transform(validaSenha);
  Stream<String> get outCpf => _cpfController.stream;
  Stream<String> get outRg => _rgController.stream;
  Stream<String> get outExtraTel => _extraTelefoneController.stream;
  Stream<SignupState> get outState => _stateController.stream;
  Stream<UpdateState> get outUpState => _updateController.stream;
  Stream<String> get outUfUpdate => _ufUpdateController.stream;

  //Sink<String> get inNome => _nomeController;

  Stream<bool> get outSubmitValidOne => Observable.combineLatest3(
      outNome,
      outEmail,
      outDataNasc,
      (
        a,
        b,
        c,
      ) =>
          true);

  Stream<bool> get outSubmitValidTwo => Observable.combineLatest2(
      outCidade,
      outTelefone,
      (
        a,
        b,
      ) =>
          true);

  //Stream<bool> get outSubmitValidFour => Observable.just(data)

  Stream<bool> get outSubmitValidthree => Observable.combineLatest2(
      outSenha,
      outSenha,
      (
        a,
        b,
      ) =>
          true);

  Stream<bool> get apagar => Observable.combineLatest2(
      outNome,
      outNome,
      (
        a,
        b,
      ) =>
          true);

  //validador do botão de UPDATE
  /* Stream<bool> get validaUpdate => Observable.combineLatest4(
    streamA, streamB, streamC, streamD, combiner) */

  SingletonBloc._() {
//inicilize seus métodos e instancie seus controller aqui
/* _contador = BehaviorSubject<int>();
increment(); */
    _nomeController = BehaviorSubject<String>();
    _dataNascController = BehaviorSubject<String>();
    _emailController = BehaviorSubject<String>();
    _ufController = BehaviorSubject<String>();
    _cidadeController = BehaviorSubject<String>();
    _telefoneController = BehaviorSubject<String>();
    _senhaController = BehaviorSubject<String>();
    _cpfController = BehaviorSubject<String>();
    _rgController = BehaviorSubject<String>();
    _extraTelefoneController = BehaviorSubject<String>();
    _stateController = BehaviorSubject<SignupState>();
    _updateController = BehaviorSubject<UpdateState>();
    _ufUpdateController = BehaviorSubject<String>();
  }

//manda uma mensagem de erro caso requisitos não estejam validados
  Function(String) get changeNome => _nomeController.sink.add;
  Function(String) get changeDataNasc => _dataNascController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeUf => _ufController.sink.add;
  Function(String) get changeCidade => _cidadeController.sink.add;
  Function(String) get changeTelefone => _telefoneController.sink.add;
  Function(String) get changeSenha => _senhaController.sink.add;
  Function(String) get changeCpf => _cpfController.sink.add;
  Function(String) get changeRg => _rgController.sink.add;
  Function(String) get changeExtraTel => _extraTelefoneController.sink.add;
  Function(String) get changeUfUpdate => _ufUpdateController.sink.add;

//se precisar chamar algum método, chama assim:

  //Função de CADASTRAR usuário
  Future<void> signUp() async {
    final nome = _nomeController.value;
    final dataNasc = _dataNascController.value.toString();
    final email = _emailController.value.trim();
    final uf = _ufController.value;
    final cidade = _cidadeController.value;
    final telefone = _telefoneController.value;
    final cpf = ' ';
    final rg = ' ';
    final extraTel = ' ';
    final senha = _senhaController.value.trim();

    String url = ConexaoAPI().api + "usuarios";
    Map<String, String> headers = {"Accept": "application/json"};

    try {
      http.Response response = await http.post(url, headers: headers, body: {
        "nome": nome,
        "email": email,
        "data_nascimento": dataNasc,
        "cidade": cidade,
        "uf": uf,
        "fone_1": telefone,
        "senha": senha,
        "cpf": cpf.isEmpty || _cpfController.value == null
            ? ''
            : _cpfController.value,
        "fone_2": extraTel.isEmpty || _extraTelefoneController.value == null
            ? ''
            : _extraTelefoneController.value,
        "rg": rg.isEmpty || _rgController.value == null
            ? ''
            : _rgController.value,
      });

      if (response.statusCode == 201) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('email', _emailController.value);
        print("Cadastrado com Sucesso!");
        _stateController.add(SignupState.SUCESSO);
      } else {
        print("deu errado");
        _stateController.add(SignupState.FALHA);
      }
    } catch (erro) {
      print("robson");
      print(erro);
      return _stateController.add(SignupState.CATCH_ERRO);
    }
  }

  //Função de ATUALIZAR usuário
  Future<void> updateUser() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = await UserBloc().getUserEmail();
    var token = prefs.getString('tokenjwt');
    String url = ConexaoAPI().api + 'usuarioUpdate/$email';
    Map<String, String> headers = {
      "Accept": "application/json",
      "x-access-token": token
    };

    Map payload = {
      "nome": _nomeController.value,
      "email": _emailController.value,
      "cidade": _cidadeController.value,
      "uf": _ufUpdateController.value?.toString() ?? _ufController.value,
      "fone_1": _telefoneController.value,
      "cpf": _cpfController.value,
      "rg": _cpfController.value
    };

    try {
      http.Response response = await http.put(url, headers: headers, body: payload);

      /*SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', _emailController.value);*/
      if (response.statusCode == 201) {
        await LoginBloc().saveUserAuthentication(jsonDecode(response.body));
       
        print("Atualizado com Sucesso!");
        _updateController.add(UpdateState.SUCESSO);
      } else {
        print("deu errado");
        _updateController.add(UpdateState.FALHA);
      }
    } catch (erro) {
      print(erro);
      return _updateController.add(UpdateState.CATCH_ERRO);
    }
  }

//feche suas streams quando o dispose for chamado
  dispose() {
    _nomeController.close();
    _dataNascController.close();
    _emailController.close();
    _ufController.close();
    _cidadeController.close();
    _telefoneController.close();
    _senhaController.close();
    _cpfController.close();
    _rgController.close();
    _extraTelefoneController.close();
    _stateController.close();
    _updateController.close();
  }
}
