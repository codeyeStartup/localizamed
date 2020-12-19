import 'dart:async';
import 'package:connectivity/connectivity.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:localizamed_app/app/models/user_model.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'dart:io';
import 'dart:io' as io;
import 'package:image_picker/image_picker.dart';
import 'package:localizamed_app/app/pages/user_profile/user_bloc.dart';

class UpdateScreen extends StatefulWidget {
  @override
  _UpdateScreenState createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String _connectionStatus = 'unknown';
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<Usuario> userData;
  var bloc = UserBloc();

  io.File imagemAvatar;
  io.File imagemPerfil;
  final picker = ImagePicker();

  TextEditingController nomeController;
  TextEditingController emailController;
  String ufController;
  TextEditingController cidadeController;
  TextEditingController bairroController;
  TextEditingController logradouroController;
  TextEditingController telefoneController;
  TextEditingController phoneController;

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
      Flushbar(
          duration: Duration(seconds: 3),
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          borderRadius: 8,
          backgroundColor: Theme.of(context).primaryColor,
          boxShadows: [
            BoxShadow(
                color: Colors.black12, offset: Offset(3, 3), blurRadius: 5)
          ],
          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
          message: 'Imagem alterada com sucesso!',
        )..show(context);
      return print('imagem alterada');
    } else {
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
          message: 'Ocorreu um erro ao alterar sua imagem!',
        )..show(context);
      return print('error');
    }
  }

  doChangeData() async {
    String nome = nomeController.text ??= '';
    String email = emailController.text ??= '';
    String uf = ufController ??= '';
    String cidade = cidadeController.text ??= '';
    String bairro = bairroController.text ??= '';
    String logradouro = logradouroController.text ??= '';
    String phone = phoneController.text ??= '';

    var change = await bloc.changeUser(
        nome, email, uf, cidade, bairro, logradouro, phone);

    switch (change['code']) {
      case 201:
        setState(() {
          userData = bloc.getUser();
        });
        Flushbar(
          duration: Duration(seconds: 3),
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
          borderRadius: 8,
          backgroundColor: Colors.greenAccent,
          boxShadows: [
            BoxShadow(
                color: Colors.black12, offset: Offset(3, 3), blurRadius: 5)
          ],
          dismissDirection: FlushbarDismissDirection.HORIZONTAL,
          forwardAnimationCurve: Curves.fastLinearToSlowEaseIn,
          message: 'Dados alterados com sucesso!',
        )..show(context);
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
  void initState() {
    _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    userData = bloc.getUser();
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

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
      key: _scaffoldkey,
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
          child: _connectionStatus == 'ConnectivityResult.none'
              ? Center(
                  child: Text(
                'Não foi possível se conectar. Tente novamente.',
                textAlign: TextAlign.center,
              ))
              : FutureBuilder(
                  future: userData,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: LoadingBouncingLine.circle(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      );
                    }

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
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                          bottom: 0),
                                      child: Stack(
                                        children: <Widget>[
                                          StreamBuilder<File>(
                                              stream: bloc.imageUser,
                                              builder:
                                                  (context, snapshotImagem) {
                                                if (snapshotImagem.data ==
                                                    null) {
                                                  return CircleAvatar(
                                                      radius: 70,
                                                      backgroundImage: snapshot
                                                                  .data
                                                                  .caminhoFoto ==
                                                              null
                                                          ? AssetImage(
                                                              'images/usuarioP.png')
                                                          : NetworkImage(snapshot
                                                              .data
                                                              .caminhoFoto));
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
                                  controller: nomeController =
                                      TextEditingController(
                                          text: snapshot.data.nome),
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
                                  controller: emailController =
                                      TextEditingController(
                                          text: snapshot.data.email),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    errorText: snapshot.hasError
                                        ? snapshot.error
                                        : null,
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
                                    snapshot.data.uf == null
                                        ? 'Estado não informado'
                                        : 'Seu atual Estado: ' +
                                            snapshot.data.uf,
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ),
                                //DATA
                                DropdownButton<String>(
                                  items:
                                      _estados.map((String dropDownStringItem) {
                                    return DropdownMenuItem<String>(
                                        value: dropDownStringItem,
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: 47, bottom: 1),
                                            //width: 0.6, //size.width / 1.45,
                                            child: Text(
                                              dropDownStringItem,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.black,
                                                  decorationColor:
                                                      Colors.black),
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
                                      this._estadosItemSelected =
                                          newValueSelected;
                                      ufController = _estadosItemSelected;
                                    });
                                  },
                                  value: _estadosItemSelected,
                                ),

                                //CIDADE
                                TextFormField(
                                    controller: cidadeController =
                                        TextEditingController(
                                            text: snapshot.data.cidade),
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.location_city),
                                      labelText: "Cidade",
                                    ),
                                    validator: (value) {
                                      if (value.length > 100) {
                                        return 'Nome da cidade grande demais!';
                                      }
                                    }),

                                TextFormField(
                                  controller: logradouroController =
                                      TextEditingController(
                                          text: snapshot.data.logradouro),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.location_city),
                                    labelText: "Logradouro",
                                  ),
                                  validator: (value) {
                                    if (value.length > 100) {
                                      return 'Logradouro grande demais!';
                                    }
                                  },
                                ),

                                TextFormField(
                                  controller: bairroController =
                                      TextEditingController(
                                          text: snapshot.data.bairro),
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.location_city),
                                    labelText: "Bairro",
                                  ),
                                  validator: (value) {
                                    if (value.length > 100) {
                                      return 'Nome do bairro grande demais!';
                                    }
                                  },
                                ),

                                //TELEFONE
                                TextFormField(
                                  controller: phoneController =
                                      MaskedTextController(
                                          text: snapshot.data.fone_1,
                                          mask: '(00) 0 0000-0000'),
                                  maxLength: 16,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    counter: SizedBox.shrink(),
                                    prefixIcon: Icon(Icons.phone),
                                    labelText: "Telefone",
                                  ),
                                  validator: (value) {
                                    if (value.length < 11) {
                                      return 'Preencha seu telefone corretamente';
                                    }
                                  }
                                ),

                                //botão de ATUALIZAR
                                Container(
                                  height: 60,
                                  margin: EdgeInsets.only(
                                      left: 35, right: 35, top: 40),
                                  child: RaisedButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: Text(
                                                  "Deseja atualizar os seus dados?"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("Sim, eu quero"),
                                                  onPressed: () async {
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      imagemAvatar == null
                                                          ? ''
                                                          : doChangeImage();
                                                      doChangeData();
                                                      Navigator.of(context)
                                                          .pop();
                                                    } else {
                                                      Navigator.of(context)
                                                          .pop();
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
                  })),
    );
  }

  Future<void> _initConnectivity() async {
    ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      print(e.toString());
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = result.toString());
        break;
    }
  }
}
