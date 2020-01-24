import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:localizamed_app/screens/bottom_menu_screen.dart';
import 'package:localizamed_app/screens/signup/signup_screen_4.dart';
import 'package:localizamed_app/blocs/signup_bloc.dart';

class SignUpScreen5 extends StatefulWidget {
  @override
  _SignUpScreen5State createState() => _SignUpScreen5State();

  final Stream<String> stream;

  SignUpScreen5({this.stream, Key key}) : super(key: key);
}

class _SignUpScreen5State extends State<SignUpScreen5>
    with AutomaticKeepAliveClientMixin<SignUpScreen5> {
  final _signupBloc = SingletonBloc();

  @override
  void initState() {
    super.initState();

    //estados de acordo com o que é retornado do Bloc -> API -> Banco
    _signupBloc.outState.listen((state) {
      switch (state) {
        case SignupState.SUCESSO:
          print("CADASTRADO COM SUCESSO");
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Cadastrado com sucesso"),
                    content: Text(
                        "Você está pronto para usar o nosso aplicativo?"),
                    actions: <Widget>[
                      FlatButton(child: Text("Estou Pronto!",
                        style: TextStyle(
                          fontSize: 22 
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => BottomMenu()));
                      },
                      )
                    ],    
                  ));
          break;
        case SignupState.FALHA:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Erro"),
                    content: Text("ENTROU NO STATE FALHA"),
                  ));
          break;
        case SignupState.CATCH_ERRO:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text("Erro"),
                    content: Text("ENTROU NO CATCH DE ERRO!"),
                  ));
          break;
        case SignupState.CARREGANDO:
        case SignupState.IDLE:
      }
    });
  }

  var phoneController = MaskedTextController(mask: '(00) 0 0000-0000');
  var cpfController = MaskedTextController(mask: '000.000.000-00');
  var rgController = MaskedTextController(mask: '0.000.000');

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
                            Navigator.of(context).pop(MaterialPageRoute(
                                builder: (context) => SignUpScreen4()));
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
                              'Bom, esses dados são opcionais, mas seria legal se você me informasse isso também :)',
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
                              //campo de CPF
                              StreamBuilder<String>(                                  
                                  stream: _signupBloc.outCpf,
                                  initialData: 'a',
                                  builder: (context, snapshot) {
                                    return TextFormField(
                                      maxLength: 14,
                                      controller: cpfController,
                                      keyboardType: TextInputType.number,
                                      onChanged: _signupBloc.changeCpf,
                                      decoration: InputDecoration(
                                        counter: SizedBox.shrink(),
                                        hintText: 'Sem pontuação',
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.5),
                                            fontSize: 16),
                                        labelText: 'CPF',
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

                              //campo de RG
                              StreamBuilder<String>(
                                  stream: _signupBloc.outRg,
                                  initialData: ' ',
                                  builder: (context, snapshot) {
                                    return TextFormField(
                                      controller: rgController,
                                      maxLength: 10,
                                      keyboardType: TextInputType.number,
                                      onChanged: _signupBloc.changeRg,
                                      decoration: InputDecoration(
                                        counter: SizedBox.shrink(),
                                        hintText: 'Sem pontuação',
                                        hintStyle: TextStyle(
                                            fontSize: 16),
                                        labelText: 'RG',
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

                              //campo de TELEFONE 2
                              StreamBuilder<String>(
                                  stream: _signupBloc.outExtraTel,
                                  initialData: 'a',
                                  builder: (context, snapshot) {
                                    return TextFormField(
                                      controller: phoneController,
                                      keyboardType: TextInputType.phone,
                                      maxLength: 16,
                                      onChanged: _signupBloc.changeExtraTel,
                                      decoration: InputDecoration(
                                        counter: SizedBox.shrink(),
                                        hintText: 'Seu numero',
                                        hintStyle: TextStyle(
                                            fontSize: 16),
                                        labelText: 'Telefone 2',
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

                      //botão de FINALIZAR CADASTRO
                      RaisedButton(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 100),
                          color: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                          child: Text(
                            'FINALIZAR',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22),
                          ),
                          onPressed: () {
                            _signupBloc.signUp();
                          })
                    ]),
                  );
              }
            }));
  }
}
