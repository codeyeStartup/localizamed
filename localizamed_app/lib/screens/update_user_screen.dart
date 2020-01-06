import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:localizamed_app/screens/bottom_menu_screen.dart';
import 'package:localizamed_app/screens/usuario_screen.dart';
import 'package:localizamed_app/blocs/user_bloc.dart';
import 'package:localizamed_app/blocs/signup_bloc.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final _formKey = GlobalKey<FormState>();

  final _signupBloc = SingletonBloc();

  var phoneController = new MaskedTextController(mask: '(00) 0 0000-0000');

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

  @override
  Widget build(BuildContext context) {
    userBloc.getUser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context)
                .pop();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: Color.fromARGB(255, 32, 32, 255),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Alterar Dados",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: userBloc.usuario,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              //_signupBloc.changeNome(snapshot.data.nome);
              /* _signupBloc.changeEmail(snapshot.data.email);
              _signupBloc.changeCidade(snapshot.data.cidade);
              _signupBloc.changeUf(snapshot.data.uf);
              _signupBloc.changeTelefone(snapshot.data.fone_1); */

              return Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 50.0, horizontal: 50.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        //NOME
                        TextFormField(
                          initialValue: snapshot.data.nome,
                          onChanged: _signupBloc.changeNome,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person_outline),
                            labelText: "Nome",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Esse campo não pode ficar vazio!';
                            } else if (value.length <= 5) {
                              return 'Seu nome é muito curto!';
                            } else if (value.length > 100) {
                              return 'Seu nome é grande demais!';
                            }
                            return null;
                          },
                        ),

                        //EMAIL
                        TextFormField(
                          initialValue: snapshot.data.email,
                          onChanged: _signupBloc.changeEmail,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            errorText:
                                snapshot.hasError ? snapshot.error : null,
                            prefixIcon: Icon(Icons.email),
                            labelText: "E-mail",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Esse campo não pode ficar vazio!';
                            } else if (!value.contains('@')) {
                              return 'Digite um e-mail válido!';
                            }
                            return null;
                          },
                        ),

                        //CIDADE
                        TextFormField(
                          initialValue: snapshot.data.cidade,
                          onChanged: _signupBloc.changeCidade,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_city),
                            labelText: "Cidade",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Esse campo não pode ficar vazio!';
                            } else if (value.length > 100) {
                              return 'Nome da cidade grande demais!';
                            }
                            return null;
                          },
                        ),

                        //DATA
                        DropdownButton<String>(
                          items: _estados.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Container(
                                    padding:
                                        EdgeInsets.only(left: 47, bottom: 1),
                                    //width: 0.6, //size.width / 1.45,
                                    child: Text(
                                      dropDownStringItem,
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.black,
                                          decorationColor: Colors.black),
                                    )));
                          }).toList(),
                          isExpanded: true,
                          hint: Text('Select'),
                          disabledHint: Text('Select'),
                          style: TextStyle(color: Colors.black),
                          iconSize: 35,
                          iconEnabledColor: Colors.black,
                          onChanged: (String newValueSelected) {
                            //your code to execute, when a menu item is selected from drop down
                            setState(() {
                              this._estadosItemSelected = newValueSelected;
                              _signupBloc.changeUfUpdate(_estadosItemSelected);
                            });
                          },
                          value: _estadosItemSelected,
                        ),
                        //ESTADO
                        /* TextFormField(
                          initialValue: snapshot.data.uf,
                          onChanged: _signupBloc.changeUf,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            labelText: "Estado",
                          ),
                        ), */

                        //TELEFONE
                        TextFormField(
                          //initialValue: snapshot.data.fone_1,
                          onChanged: _signupBloc.changeTelefone,
                          controller: MaskedTextController(
                              text: snapshot.data.fone_1,
                              mask: '(00) 0 0000-0000'),
                          maxLength: 16,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            counter: SizedBox.shrink(),
                            prefixIcon: Icon(Icons.phone),
                            labelText: "Telefone",
                          ),
                        ),

                        //botão de ATUALIZAR
                        Container(
                          height: 60,
                          margin: EdgeInsets.only(left: 35, right: 35, top: 40),
                          child: RaisedButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Tem certeza?"),
                                      content: Text(
                                          "Vai mesmo querer atualizar os seus dados?"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Sim, eu quero"),
                                          onPressed: () {
                                            if (_formKey.currentState
                                                .validate()) {
                                              _signupBloc.updateUser();
                                               Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          UserColapsed()));
                                            }
                                          },
                                        ),
                                        FlatButton(
                                          child: Text("Não"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Text("Alterar"),
                            textColor: Colors.white,
                            color: Color.fromARGB(255, 32, 32, 255),
                            splashColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ));
            }),
      ),
    );
  }
}
