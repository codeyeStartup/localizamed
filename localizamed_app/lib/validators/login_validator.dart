import 'dart:async';

class LoginValidators {

  final validaEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      if(email.contains("@")){
        sink.add(email);
      } else {
        sink.addError("Insira um e-mail válido");
      }
    }
  );

  final validaSenha = StreamTransformer<String, String>.fromHandlers(
    handleData: (senha, sink){
      if(senha.length >= 6){
        sink.add(senha);
      } else {
        sink.addError("Senha inválida, deve conter pelo menos 6 caracteres");
      }
    }
  );

}