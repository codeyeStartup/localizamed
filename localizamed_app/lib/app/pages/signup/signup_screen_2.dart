import 'package:flutter/material.dart';
import 'package:localizamed_app/app/pages/signup/signup_bloc.dart';
import 'package:localizamed_app/app/pages/signup/signup_screen_3.dart';
import 'package:localizamed_app/app/pages/signup/signup_screen_home.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class SignUpScreen2 extends StatefulWidget {
  @override
  _SignUpScreen2State createState() => _SignUpScreen2State();

  final Stream<String> stream;

  SignUpScreen2({this.stream, Key key}) : super(key: key);
}

class _SignUpScreen2State extends State<SignUpScreen2>
    with AutomaticKeepAliveClientMixin<SignUpScreen2> {
  final _signupBloc = SingletonBloc();
  var dateController = new MaskedTextController(mask: '0000/00/00');

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _signupBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    return Scaffold(
        body: StreamBuilder<SignupState>(
            stream: _signupBloc.outState,
            initialData: SignupState.IDLE,
            builder: (context, snapshot) {
              switch (snapshot.data) {
                case SignupState.CARREGANDO:
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Color.fromARGB(255, 23, 29, 255)),
                    ),
                  );
                case SignupState.FALHA:
                case SignupState.CATCH_ERRO:
                case SignupState.SUCESSO:
                case SignupState.IDLE:
                  return SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(top: size.height / 20),
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            alignment: Alignment.center,
                            icon: Icon(
                              Icons.arrow_back,
                              color: Theme.of(context).primaryColor,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUpHome()));
                            },
                          )),
                      SizedBox(
                        height: size.height / 20,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.width / 10),
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Olá, tudo bem? Eu gostaria de te conhecer melhor. Pode por favor me dizer seu Nome, sua Data de Nascimento e seu E-mail?',
                              style:
                                  TextStyle(fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: size.height / 2,
                          width: size.width / 1.3,
                          child: Form(
                              child: ListView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              //campo de NOME
                              StreamBuilder<String>(
                                  stream: _signupBloc.outNome,
                                  builder: (context, snapshot) {
                                    return TextFormField(
                                      onChanged: _signupBloc.changeNome,
                                      decoration: InputDecoration(
                                        errorText: snapshot.hasError
                                            ? snapshot.error
                                            : null,
                                        hintText: 'Exemplo: Ana Laura Pereira',
                                        hintStyle: TextStyle(
                                            fontSize: 16),
                                        labelText: 'Nome Completo',
                                        labelStyle: TextStyle(
                                            fontSize: 20),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black,)
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Theme.of(context).primaryColor),
                                        ),
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: size.height / 100,
                              ),

                              //campo de DATA
                              StreamBuilder<String>(
                                  stream: _signupBloc.outDataNasc,
                                  builder: (context, snapshot) {
                                    return TextFormField(
                                      onChanged: _signupBloc.changeDataNasc,
                                      controller: dateController,
                                      maxLength: 10,
                                      keyboardType: TextInputType.datetime,
                                      decoration: InputDecoration(
                                        counter: SizedBox.shrink(),
                                        labelText: 'Data de Nascimento',
                                        hintText: 'AAAA/MM/DD',
                                        labelStyle: TextStyle(
                                            fontSize: 20),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Theme.of(context).primaryColor),
                                        ),
                                      ),
                                    );
                                  }),
                              SizedBox(
                                height: size.height / 100,
                              ),

                              //campo de EMAIL
                              StreamBuilder<String>(
                                  stream: _signupBloc.outEmail,
                                  builder: (context, snapshot) {
                                    return TextFormField(
                                      onChanged: _signupBloc.changeEmail,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        errorText: snapshot.hasError
                                            ? snapshot.error
                                            : null,
                                        hintText: 'você@gmail.com',
                                        hintStyle: TextStyle(
                                            fontSize: 16),
                                        labelText: 'E-mail',
                                        labelStyle: TextStyle(
                                            fontSize: 20),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Theme.of(context).primaryColor),
                                        ),
                                      ),
                                    );
                                  }),
                            ],
                          ))),

                      //botão para a próxima tela
                      StreamBuilder<bool>(
                          stream: _signupBloc.outSubmitValidOne,
                          builder: (context, snapshot) {
                            return RaisedButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 100),
                                color: Theme.of(context).primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                disabledColor: Colors.blueGrey,
                                disabledTextColor: Colors.white,
                                child: Text(
                                  'PRÓXIMO',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22),
                                ),
                                onPressed: snapshot.hasData
                                    ? () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUpScreen3()));
                                      }
                                    : null);
                          })
                    ]),
                  );
              }
            }));
  }
}
