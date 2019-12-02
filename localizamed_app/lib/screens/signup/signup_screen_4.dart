import 'package:flutter/material.dart';
import 'package:localizamed_app/screens/signup/signup_screen_3.dart';
import 'package:localizamed_app/screens/signup/signup_screen_5.dart';
import 'package:localizamed_app/blocs/signup_bloc.dart';

class SignUpScreen4 extends StatefulWidget {
  @override
  _SignUpScreen4State createState() => _SignUpScreen4State();

  final Stream<String> stream;

  SignUpScreen4({this.stream, Key key}) : super(key: key);
}

class _SignUpScreen4State extends State<SignUpScreen4>
    with AutomaticKeepAliveClientMixin<SignUpScreen4> {
  final _signupBloc = SingletonBloc();

  bool invisible;

  @override
  void initState() {
    super.initState();

    invisible = true;
  }

  @override
  bool get wantKeepAlive => true;

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
        backgroundColor: Theme.of(context).primaryColor,
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
                            color: Colors.white,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(MaterialPageRoute(
                                builder: (context) => SignUpScreen3()));
                          },
                        ),
                      ),
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
                              'Agora crie uma senha. Só tenha cuidado para não esquecê-la!',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
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
                              //campo de SENHA
                              StreamBuilder<String>(
                                  stream: _signupBloc.outSenha,
                                  builder: (context, snapshot) {
                                    return TextFormField(
                                      keyboardType: TextInputType.text,
                                      onChanged: _signupBloc.changeSenha,
                                      obscureText: invisible,
                                      decoration: InputDecoration(
                                        errorText: snapshot.hasError
                                            ? snapshot.error
                                            : null,
                                        hintText: 'Sua senha',
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.5),
                                            fontSize: 16),
                                        labelText: 'Senha',
                                        labelStyle: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white),
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            invisible
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            size: 20.0,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              invisible = !invisible;
                                            });
                                          },
                                        ),
                                      ),
                                    );
                                  }),

                              //campo de CONFIRMAR SENHA
                              /* TextFormField(
                                keyboardType: TextInputType.text,
                                obscureText: invisible,
                                decoration: InputDecoration(
                                  hintText: 'Repita sua senha',
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(255, 255, 255, 0.5),
                                      fontSize: 16),
                                  labelText: 'Confirmar senha',
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      invisible == true
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      size: 20.0,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        invisible = false;
                                      });
                                    },
                                  ),
                                ),
                                 validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Coloque um e-mail válido';
                                  }
                                  return null;
                                }, 
                              ), */
                            ],
                          ))),

                      //botão para a PROXIMA TELA
                      StreamBuilder<bool>(
                          stream: _signupBloc.outSubmitValidthree,
                          builder: (context, snapshot) {
                            return RaisedButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 100),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                child: Text(
                                  'PRÓXIMO',
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor,
                                      fontSize: 22),
                                ),
                                onPressed: snapshot.hasData
                                    ? () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignUpScreen5()));
                                      }
                                    : null);
                          })
                    ]),
                  );
              }
            }));
  }
}
