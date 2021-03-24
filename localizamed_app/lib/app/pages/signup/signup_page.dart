import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:localizamed_app/app/pages/signup/signup_bloc.dart';
import 'package:localizamed_app/app/pages/signup/signup_splash_page.dart';
import 'package:localizamed_app/app/utils/termos_de_uso.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();

  final Stream<String> stream;

  SignUpPage({this.stream, Key key}) : super(key: key);
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKeySignUp = GlobalKey<FormState>();

  bool checkVal = false;
  bool invisible = true;

  SingletonBloc _signupBloc = SingletonBloc();

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final phoneController = new MaskedTextController(mask: '(00) 0 0000-0000');
  final dateController = new MaskedTextController(mask: '00/00/0000');

  @override
  void initState() {
    super.initState();
  }

  doSignUp() async {
    String nome = nomeController.text ??= '';
    String email = emailController.text ??= '';
    String senha = senhaController.text ??= '';
    String phone = phoneController.text ??= '';
    String dateNasc = dateController.text ??= '';

    var sign = await _signupBloc.signUp(nome, dateNasc, phone, email, senha);

    switch (sign['code']) {
      case 201:
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
                builder: (BuildContext context) => SignupSplashPage()),
            (Route<dynamic> route) => false);
        break;
      case 400:
        Flushbar(
          duration: Duration(seconds: 3),
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          borderRadius: 8,
          backgroundColor: Colors.redAccent,
          boxShadows: [
            BoxShadow(
                color: Colors.black12, offset: Offset(3, 3), blurRadius: 5)
          ],
          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
          message: 'Não foi possível concluir o cadastro. Tente novamente!',
        )..show(context);
        break;
      case 500:
        Flushbar(
          duration: Duration(seconds: 3),
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          borderRadius: 8,
          backgroundColor: Colors.redAccent,
          boxShadows: [
            BoxShadow(
                color: Colors.black12, offset: Offset(3, 3), blurRadius: 5)
          ],
          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
          message: 'Verifique sua internet',
        )..show(context);
        break;
      default:
    }
  }

  @override
  void dispose() {
    nomeController.dispose();
    emailController.dispose();
    senhaController.dispose();
    phoneController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            child: SingleChildScrollView(
          child: Container(
            child: Container(
              margin: EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Text(
                    'Criar Conta',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 10),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 14,
                  ),
                  Form(
                      key: _formKeySignUp,
                      child: Column(
                        children: [
                          TextFormField(
                              controller: nomeController,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 16, bottom: 10),
                                hintStyle: TextStyle(fontSize: 16),
                                labelText: 'Nome e Sobrenome',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Preecha o campo com seu nome';
                                } else if (value.length > 50) {
                                  return 'Este campo tem que conter entre 1 e 50 caracteres';
                                }
                              },
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              }),
                          TextFormField(
                              controller: dateController,
                              maxLength: 10,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                counter: SizedBox.shrink(),
                                contentPadding:
                                    EdgeInsets.only(top: 16, bottom: 10),
                                hintStyle: TextStyle(fontSize: 16),
                                labelText: 'Data de nascimento',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Preecha o campo com sua data de nascimento';
                                } else if (value.length < 8) {
                                  return 'O campo deve conter uma data de nascimento válida';
                                }
                              },
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              }),
                          TextFormField(
                              textInputAction: TextInputAction.next,
                              controller: phoneController,
                              maxLength: 16,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                counter: SizedBox.shrink(),
                                contentPadding:
                                    EdgeInsets.only(top: 16, bottom: 10),
                                hintStyle: TextStyle(fontSize: 16),
                                labelText: 'Telefone',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Preencha o campo com seu telefone';
                                } else if (value.length < 11) {
                                  return 'O campo deve conter um número de telefone válido';
                                }
                              },
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              }),
                          TextFormField(
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 16, bottom: 10),
                                hintStyle: TextStyle(fontSize: 16),
                                labelText: 'E-mail',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black12),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Preecha o campo com seu e-mail';
                                } else if (!value.contains('@')) {
                                  return 'Digite um e-mail válido!';
                                } else if (value.length > 50) {
                                  return 'Este campo tem que conter entre 1 e 50 caracteres';
                                }
                              },
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              }),
                          TextFormField(
                              controller: senhaController,
                              textInputAction: TextInputAction.done,
                              obscureText: invisible,
                              decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(top: 16, bottom: 10),
                                  hintStyle: TextStyle(fontSize: 16),
                                  labelText: 'Senha',
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black12),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      invisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      size: 20.0,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        invisible = !invisible;
                                      });
                                    },
                                  )),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Preencha o campo com uma senha válida';
                                } else if (value.length < 6 ||
                                    value.length > 100) {
                                  return 'A senha deve conter no minímo 6 e no máximo 100';
                                }
                              },
                              onEditingComplete: () {
                                FocusScope.of(context).unfocus();
                              })
                        ],
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 16,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        value: checkVal,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        activeColor: Colors.green,
                        onChanged: (bool resp) {
                          setState(() {
                            checkVal = resp;
                          });
                        },
                      ),
                      FlatButton(
                        padding: EdgeInsets.all(1),
                        child: Text(
                            'Li e concordo com os Termos de Uso\n e Política de Privacidade',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 14)),
                        onPressed: () {
                          terms(context);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                  ),
                  Center(
                      child: RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 80),
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23)),
                          child: Text(
                            'Cadastrar',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    MediaQuery.of(context).size.width / 24,
                                fontWeight: FontWeight.bold),
                          ),
                          disabledColor: Colors.white,
                          onPressed: () {
                            if (checkVal == true &&
                                _formKeySignUp.currentState.validate()) {
                              doSignUp();
                            } else if (checkVal != true) {
                              Flushbar(
                                duration: Duration(seconds: 3),
                                padding: EdgeInsets.all(12),
                                margin: EdgeInsets.only(
                                    bottom: 20, left: 20, right: 20),
                                borderRadius: 8,
                                backgroundColor: Colors.redAccent,
                                boxShadows: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(3, 3),
                                      blurRadius: 5)
                                ],
                                dismissDirection:
                                    FlushbarDismissDirection.HORIZONTAL,
                                forwardAnimationCurve:
                                    Curves.fastLinearToSlowEaseIn,
                                message: 'Concordar com os termos de uso para continuar!',
                              )..show(context);
                            }
                          }))
                ],
              ),
            ),
          ),
        )));
  }
}
