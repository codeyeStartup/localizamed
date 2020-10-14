import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localizamed_app/app/pages/login/login_bloc.dart';
import 'package:localizamed_app/app/utils/msg_sem_internet.dart';
import 'package:localizamed_app/app/pages/signup/signup_screen_home.dart';
import 'package:localizamed_app/app/utils/slideRoutes.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();

  final Stream<String> stream;

  LoginScreen({this.stream});
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final _loginBloc = LoginBloc();

  bool invisible;
  var _state = 0;

  @override
  void initState() {
    super.initState();

    //estados de acordo com o que é retornado do Bloc -> API -> Banco
    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCESSO:
          Navigator.pushReplacement(context, SlideLeftRoute(page: MsgInt()));
          break;
        case LoginState.FALHA:
          this.setState(() {
            _state = 3;
          });
          _scaffoldkey.currentState.showSnackBar(SnackBar(
            content: Text('Usuario e/ou senha incorretos. Tente novamente'),
            backgroundColor: Colors.red,
          ));
          break;
        case LoginState.CARREGANDO:
          Future.delayed(Duration(seconds: 3), () {
            this.setState(() {
              _state = 2;
            });
          });
          break;
        case LoginState.IDLE:
      }
    });

    invisible = true;
  }

  showAlert(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text('Login pelo Facebook'),
      content: Container(
        child: Text('Estamos trabalhando para resolver este problema'),
      ),
    );

    return showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  @override
  void dispose() {
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    return Scaffold(
        key: _scaffoldkey,
        body: StreamBuilder<LoginState>(
            stream: _loginBloc.outState,
            initialData: LoginState.IDLE,
            builder: (context, snapshot) {
              switch (snapshot.data) {
                case LoginState.CARREGANDO:
                case LoginState.FALHA:
                case LoginState.SUCESSO:
                case LoginState.IDLE:
                  return SafeArea(
                      child: Container(
                    width: size.width,
                    height: size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                left: size.width / 3.1, top: size.height / 60),
                            child: Row(
                              children: <Widget>[
                                Text("LocalizaMed",
                                    style: TextStyle(
                                      fontSize: size.width / 20,
                                    )),
                                Image(
                                  image: AssetImage('images/pin.png'),
                                  width: size.width / 20,
                                  height: size.height / 20,
                                ),
                              ],
                            ),
                          ),

                          SizedBox(
                            height: size.height / 15,
                          ),
                          //label de BEM-VINDO
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: size.height / 30,
                                  top: size.height / 30,
                                  right: size.width / 2,
                                  left: size.width / 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "Bem",
                                    style: TextStyle(
                                      fontSize: size.width / 8,
                                    ),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Text(
                                        "Vindo",
                                        style: TextStyle(
                                          fontSize: size.width / 8,
                                        ),
                                      ),
                                      Text(
                                        ".",
                                        style: TextStyle(
                                            fontSize: size.width / 8,
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    ],
                                  )
                                ],
                              )),

                          //campo de email
                          Padding(
                              padding: EdgeInsets.only(
                                  left: size.width / 12,
                                  right: size.width / 20,
                                  top: 0),
                              child: Form(
                                autovalidate: false,
                                child: Column(
                                  children: <Widget>[
                                    StreamBuilder<String>(
                                        stream: _loginBloc.outEmail,
                                        builder: (context, snapshot) {
                                          return TextFormField(
                                              textInputAction:
                                                  TextInputAction.next,
                                              onChanged: _loginBloc.changeEmail,
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              decoration: InputDecoration(
                                                  errorText: snapshot.hasError
                                                      ? snapshot.error
                                                      : null,
                                                  labelText: "E-mail"),
                                              onEditingComplete: () {
                                                FocusScope.of(context)
                                                    .nextFocus();
                                              });
                                        }),

                                    //campo de SENHA
                                    StreamBuilder<String>(
                                        stream: _loginBloc.outSenha,
                                        builder: (context, snapshot) {
                                          return TextFormField(
                                            textInputAction:
                                                TextInputAction.done,
                                            onChanged:
                                                _loginBloc.changePassword,
                                            obscureText: invisible,
                                            decoration: InputDecoration(
                                                errorText: snapshot.hasError
                                                    ? snapshot.error
                                                    : null,
                                                labelText: 'Senha',
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
                                          );
                                        }),

                                    //botão de ESQUECER A SENHA
                                    Container(
                                      alignment: Alignment.centerRight,
                                      child: FlatButton(
                                        onPressed: () {},
                                        child: Text(
                                          "Esqueceu a senha?",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: size.width / 25),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height / 50,
                                    ),
                                    //botão de LOGIN
                                    StreamBuilder<bool>(
                                        stream: _loginBloc.outSubmitValid,
                                        builder: (context, snapshot) {
                                          return RaisedButton(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: size.height / 55,
                                                  horizontal:
                                                      size.width / 3.29),
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          23)),
                                              onPressed: snapshot.hasData
                                                  ? () {
                                                      AnimatedButton();
                                                      _loginBloc.login();
                                                    }
                                                  : null,
                                              disabledColor: Colors.blue[300],
                                              child: setUpButtonChild());
                                        }),

                                    SizedBox(
                                      height: size.height / 50,
                                    ),
                                    //botão de LOGAR PELO FACEBOOK
                                    Container(
                                      width: size.width / 1.4,
                                      child: RaisedButton(
                                        padding: EdgeInsets.symmetric(
                                            vertical: size.height / 55,
                                            horizontal: size.width / 8.4),
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(23),
                                            side: BorderSide(
                                                color: Colors.black, width: 2)),
                                        onPressed: () {
                                          showAlert(context);
                                        },
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image(
                                              image: AssetImage(
                                                  'images/facebook_logo1.png'),
                                              width: 15,
                                              height: 15,
                                            ),
                                            Text(
                                              "Logar pelo Facebook",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: size.width / 28,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: size.height / 20,
                                    ),
                                    //Botão de se CADASTRAR
                                    Container(
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Não tem uma conta?",
                                              style: TextStyle(
                                                  fontSize: size.width / 25),
                                            ),
                                            SizedBox(
                                              width: 1,
                                            ),
                                            FlatButton(
                                              padding: EdgeInsets.all(0),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    SlideLeftRoute(
                                                        page: SignUpHome()));
                                              },
                                              child: Text("Cadastre-se",
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontSize:
                                                          size.width / 25)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ));
              }
            }));
  }

  Widget setUpButtonChild() {
    if (_state == 0) {
      return new Text("Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width / 25,
              fontWeight: FontWeight.bold));
    } else if (_state == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else if (_state == 3) {
      return Text("Login",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width / 25,
              fontWeight: FontWeight.bold));
    } else {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    }
  }

  void AnimatedButton() {
    setState(() {
      _state = 1;
    });
  }
}
