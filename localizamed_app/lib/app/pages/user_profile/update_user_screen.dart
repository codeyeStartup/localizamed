import 'dart:async';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:localizamed_app/app/models/user_model.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:io';
import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';
import 'package:localizamed_app/app/pages/user_profile/user_bloc.dart';
import 'package:localizamed_app/app/pages/signup/signup_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  Future<Usuario> userData;
  var bloc = UserBloc();

  io.File imagemAvatar;
  io.File imagemPerfil;
  final picker = ImagePicker();

  _getImageFromGallery(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      imagemAvatar = File(pickedFile.path);
      imagemPerfil = imagemAvatar;
    });
    Navigator.of(context).pop();
    bloc.changeImage(imagemPerfil);
  }

  _getImageFromCamera(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      imagemAvatar = File(pickedFile.path);
      imagemPerfil = imagemAvatar;
    });
    Navigator.of(context).pop();
    bloc.changeImage(imagemPerfil);
  }

  doChangeImage() async {
    var change = await bloc.changeUserImage(imagemPerfil);
    if (change['code'] == 200) {
      bloc.changeImage(imagemAvatar);
      return print('imagem alterada');
    } else {
      return print('error');
    }
  }

  @override
  void initState() {
    userData = bloc.getUser();
    super.initState();
  }

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

  showOptions(BuildContext context) {
    AlertDialog showOption = AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Alterar Foto de Perfil',
              style: TextStyle(fontSize: 18),
            ),
            Divider(
              color: Colors.black45,
            )
          ],
        ),
        content: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 12,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text('Camera'),
                ),
                onTap: () {
                  _getImageFromCamera(context);
                },
              ),
              SizedBox(
                height: 18,
              ),
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text('Galeria'),
                ),
                onTap: () {
                  _getImageFromGallery(context);
                },
              )
            ],
          ),
        ));

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return showOption;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Container(
        child: FutureBuilder(
            future: userData,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: LoadingBouncingLine.circle(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                );
              }

              _signupBloc.changeNome(snapshot.data.nome);
              _signupBloc.changeBairro(snapshot.data.bairro);
              _signupBloc.changeLogradouro(snapshot.data.logradouro);
              _signupBloc.changeEmail(snapshot.data.email);
              _signupBloc.changeCidade(snapshot.data.cidade);
              _signupBloc.changeUf(snapshot.data.uf);
              _signupBloc.changeTelefone(snapshot.data.fone_1);
        
              return SingleChildScrollView(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 40.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Alterar Dados',
                                style: TextStyle(
                                    fontFamily: 'Montserrat-ExtraBold',
                                    fontWeight: FontWeight.w800,
                                    fontSize: 22),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 15,
                                    bottom: 0),
                                child: Stack(
                                  children: <Widget>[
                                    StreamBuilder<File>(
                                        stream: bloc.imageUser,
                                        builder: (context, snapshotImagem) {
                                          if (snapshotImagem.data == null) {
                                            return CircleAvatar(
                                                radius: 70,
                                                backgroundImage: snapshot
                                                            .data.caminhoFoto ==
                                                        null
                                                    ? AssetImage(
                                                        'images/usuarioP.png')
                                                    : NetworkImage(snapshot
                                                        .data.caminhoFoto));
                                          } else {
                                            return CircleAvatar(
                                              radius: 70,
                                              backgroundImage: FileImage(
                                                snapshotImagem.data,
                                              ),
                                            );
                                          }
                                        }),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              8,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5),
                                      child: GestureDetector(
                                          child: CircleAvatar(
                                            radius: 20,
                                            child: Icon(Icons.camera_alt),
                                          ),
                                          onTap: () {
                                            showOptions(context);
                                          }),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
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
                              } else if (value.endsWith('  ') ||
                                  value.startsWith('  ')) {
                                return 'Seu nome é inválido!';
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
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 18, left: 4, bottom: 8),
                            child: Text(
                              'Seu atual Estado: ' + snapshot.data.uf,
                              style: TextStyle(fontSize: 17),
                            ),
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
                                _signupBloc
                                    .changeUfUpdate(_estadosItemSelected);
                              });
                            },
                            value: _estadosItemSelected,
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
                          
                          TextFormField(
                            initialValue: snapshot.data.logradouro,
                            onChanged: _signupBloc.changeLogradouro,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_city),
                              labelText: "Logradouro",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Esse campo não pode ficar vazio!';
                              } else if (value.length > 100) {
                                return 'Logradouro grande demais!';
                              }
                              return null;
                            },
                          ),

                          TextFormField(
                            initialValue: snapshot.data.bairro,
                            onChanged: _signupBloc.changeBairro,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.location_city),
                              labelText: "Bairro",
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Esse campo não pode ficar vazio!';
                              } else if (value.length > 100) {
                                return 'Nome do bairrocidade grande demais!';
                              }
                              return null;
                            },
                          ),

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
                            margin:
                                EdgeInsets.only(left: 35, right: 35, top: 40),
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
                                            onPressed: () async {
                                              if (_formKey.currentState
                                                  .validate()) {
                                                imagemAvatar == null
                                                    ? ''
                                                    : doChangeImage();
                                                _signupBloc.updateUser();
                                                Navigator.of(context).pop();
                                              } else {
                                                Navigator.of(context).pop();
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
                              color: Theme.of(context).primaryColor,
                              splashColor: Colors.white,
                            ),
                          )
                        ],
                      ),
                    )),
              );
            }),
      ),
    );
  }
}
