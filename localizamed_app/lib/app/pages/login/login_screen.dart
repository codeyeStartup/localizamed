import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localizamed_app/app/pages/login/login_bloc.dart';
import 'package:localizamed_app/app/utils/msg_sem_internet.dart';
import 'package:localizamed_app/app/pages/signup/signup_screen_home.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();

  final Stream<String> stream;

  LoginScreen({this.stream});
}

class LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();

  bool invisible;

  @override
  void initState() {
    super.initState();

    //estados de acordo com o que é retornado do Bloc -> API -> Banco
    _loginBloc.outState.listen((state) {
      switch (state) {
        case LoginState.SUCESSO:
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (BuildContext context) => MsgInt()),
              (Route<dynamic> route) => false);
          break;
        case LoginState.FALHA:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Erro"),
                    content: Text(
                        "Sinto muito, mas seu E-mail/Senha estão incorretos!"),
                  ));
          break;
        case LoginState.CARREGANDO:
        case LoginState.IDLE:
      }
    });

    invisible = true;
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
        body: StreamBuilder<LoginState>(
            stream: _loginBloc.outState,
            initialData: LoginState.IDLE,
            builder: (context, snapshot) {
              switch (snapshot.data) {
                case LoginState.CARREGANDO:
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                          Color.fromARGB(255, 23, 29, 255)),
                    ),
                  );
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
                              child: Column(
                                children: <Widget>[
                                  StreamBuilder<String>(
                                      stream: _loginBloc.outEmail,
                                      builder: (context, snapshot) {
                                        return TextFormField(
                                          onChanged: _loginBloc.changeEmail,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                              errorText: snapshot.hasError
                                                  ? snapshot.error
                                                  : null,
                                              labelText: "E-mail"),
                                        );
                                      }),

                                  //campo de SENHA
                                  StreamBuilder<String>(
                                      stream: _loginBloc.outSenha,
                                      builder: (context, snapshot) {
                                        return TextFormField(
                                          onChanged: _loginBloc.changePassword,
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
                                            color:
                                                Theme.of(context).primaryColor,
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
                                                horizontal: size.width / 3.29),
                                            color: Color.fromARGB(
                                                255, 23, 29, 255),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(23)),
                                            onPressed: snapshot.hasData
                                                ? _loginBloc.login
                                                : null,
                                            disabledColor: Colors.blue[300],
                                            child: Text("Login",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: size.width / 25,
                                                    fontWeight:
                                                        FontWeight.bold)));
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
                                      onPressed: () {},
                                      child: Row(
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
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          SignUpHome()));
                                            },
                                            child: Text("Cadastre-se",
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize: size.width / 25)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ));
              }
            }));
  }
}
