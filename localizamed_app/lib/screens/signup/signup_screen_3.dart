import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:localizamed_app/data/user_class.dart';
import 'package:localizamed_app/screens/home_screen.dart';
import 'package:localizamed_app/screens/signup/signup_screen_2.dart';
import 'package:localizamed_app/screens/signup/signup_screen_4.dart';
import 'package:localizamed_app/blocs/signup_bloc.dart';

class SignUpScreen3 extends StatefulWidget {
  @override
  _SignUpScreen3State createState() => _SignUpScreen3State();

  final Stream<String> stream;

  SignUpScreen3({this.stream, Key key}) : super(key: key);
}

class _SignUpScreen3State extends State<SignUpScreen3>
    with AutomaticKeepAliveClientMixin<SignUpScreen3> {
  final _signupBloc = SingletonBloc();
  var _estados = [
    'Selecione seu estado',
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO'
  ];
  var _estadosItemSelected = 'Selecione seu estado';

  var phoneController = new MaskedTextController(mask: '(00) 0 0000-0000');

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    _signupBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
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
                                builder: (context) => SignUpScreen2()));
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
                              'Um belo nome você tem! Agora vou precisar saber o seu Estado, sua Cidade e seu Telefone:',
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
                              //campo de ESTADO
                              DropdownButton<String>(
                                items:
                                    _estados.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                      value: dropDownStringItem,
                                      child: Container(
                                          padding: EdgeInsets.only(
                                              left: 5, bottom: 5),
                                          width: size.width / 1.45,
                                          child: Text(
                                            dropDownStringItem,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                decorationColor: Colors.white),
                                          )));
                                }).toList(),
                                isExpanded: true,
                                hint: Text('Select'),
                                disabledHint: Text('Select'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'BreeSerif'),
                                iconSize: 35,
                                iconEnabledColor: Colors.white,
                                onChanged: (String newValueSelected) {
                                  //your code to execute, when a menu item is selected from drop down
                                  setState(() {
                                    this._estadosItemSelected =
                                        newValueSelected;
                                    _signupBloc.changeUf(_estadosItemSelected);
                                  });
                                },
                                value: _estadosItemSelected,
                              ),

                              SizedBox(
                                height: size.height / 200,
                              ),

                              //campo de CIDADE
                              StreamBuilder<String>(
                                  stream: _signupBloc.outCidade,
                                  builder: (context, snapshot) {
                                    return TextFormField(
                                      onChanged: _signupBloc.changeCidade,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        errorText: snapshot.hasError
                                            ? snapshot.error
                                            : null,
                                        hintText: 'Exemplo Limoeiro',
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.5),
                                            fontSize: 16),
                                        labelText: 'Cidade',
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
                                      ),
                                    );
                                  }),

                              SizedBox(
                                height: size.height / 100,
                              ),

                              //campo de TELEFONE
                              StreamBuilder<String>(
                                  stream: _signupBloc.outTelefone,
                                  builder: (context, snapshot) {
                                    return TextFormField(
                                      onChanged: _signupBloc.changeTelefone,
                                      controller: phoneController,
                                      maxLength: 16,
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        counter: SizedBox.shrink(),
                                        errorText: snapshot.hasError
                                            ? snapshot.error
                                            : null,
                                        hintText: 'Seu número',
                                        hintStyle: TextStyle(
                                            color: Color.fromRGBO(
                                                255, 255, 255, 0.5),
                                            fontSize: 16),
                                        labelText: 'Telefone',
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
                                      ),
                                    );
                                  }),
                            ],
                          ))),

                      //botão para a PROXIMA TELA
                      StreamBuilder<bool>(
                          stream: _signupBloc.outSubmitValidTwo,
                          builder: (context, snapshot) {
                            return RaisedButton(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 100),
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                                disabledColor: Colors.blueGrey,
                                disabledTextColor: Colors.white,
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
                                                    SignUpScreen4()));
                                      }
                                    : null);
                          })
                    ]),
                  );
              }
            }));
  }
}
