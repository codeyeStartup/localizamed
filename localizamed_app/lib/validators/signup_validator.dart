import 'dart:async';

class SignupValidator {
  //NOME
  final validaNome =
      StreamTransformer<String, String>.fromHandlers(handleData: (nome, sink) {
    if (nome.length > 100) {
      sink.addError("Seu nome é grande demais!");
    } else if (nome != null && nome.length > 5) {
      sink.add(nome);
    } else {
      sink.addError("Entre com seu nome completo");
    }
  });

  //EMAIL
  final validaEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    //String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    //RegExp regExp = new RegExp(p);
    if (email.contains("@") &&
        email != null &&
        email.length > 4 &&
        email.length < 100) {
      sink.add(email);
    } else {
      sink.addError("Entre com um e-mail válido");
    }
  });

  //SENHA
  final validaSenha =
      StreamTransformer<String, String>.fromHandlers(handleData: (senha, sink) {
    if (senha != null && senha.length >= 6) {
      sink.add(senha);
    } else {
      sink.addError("A senha deve conter pelo menos 6 caracteres");
    }
  });

  //UF - ESTADO
  final validaUf =
      StreamTransformer<String, String>.fromHandlers(handleData: (uf, sink) {
    if (uf.length > 2) {
      sink.addError("ISSO VAI SER CONVERTIDO EM UMA LISTA DE SELEÇÃO");
    } else if (uf != null) {
      sink.add(uf);
    } else {
      sink.addError("insira seu estado");
    }
  });

  //CIDADE
  final validaCidade = StreamTransformer<String, String>.fromHandlers(
      handleData: (cidade, sink) {
    if (cidade.length > 100) {
      sink.addError("Cidade inválida!");
    } else if (cidade != null && cidade.length >= 4) {
      sink.add(cidade);
    } else {
      sink.addError("Entre com uma cidade válida");
    }
  });

  //CPF
  /* final validaCpf =
      StreamTransformer<String, String>.fromHandlers(handleData: (cpf, sink) {
    if (cpf != null /* && cpf.length == 11 */) {
      sink.add(cpf);
    } else {
      sink.addError("CPF inválido");
    }
  }); */

  //RG
  /* final validaRg =
      StreamTransformer<String, String>.fromHandlers(handleData: (rg, sink) {
    if (rg != null/*  && rg.length >= 4 && rg.length <= 14 */) {
      sink.add(rg);
    } else {
      sink.addError("RG inválido");
    }
  }); */

  //TELEFONE PRINCIPAL
  final validaTelefone = StreamTransformer<String, String>.fromHandlers(
      handleData: (telefone, sink) {
    if (telefone != null && telefone.length >= 16) {
      sink.add(telefone);
    } else {
      sink.addError("Telefone inválido");
    }
  });

  //TELEFONE SECUNDÁRIO
/*   final validaTelExtra = StreamTransformer<String, String>.fromHandlers(
      handleData: (telExtra, sink) {
    if (telExtra.length > 15) {
      sink.addError("Telefone inválido");
    } else if (telExtra != null/*  &&
        telExtra.length > 8 &&
        telExtra.length <= 15 */) {
      sink.add(telExtra);
    } else {
      sink.addError("Telefone inválido");
    }
  }); */

  //DATA NASCIMENTO
  //por enquanto passa tudo

}
