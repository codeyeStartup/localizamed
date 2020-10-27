import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:localizamed_app/app/models/user_model.dart';
import 'package:localizamed_app/app/pages/user_profile/user_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:localizamed_app/app/pages/login/login_screen.dart';
import 'package:localizamed_app/app/pages/user_profile/update_user_screen.dart';
import 'package:localizamed_app/app/utils/slideRoutes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Future<Usuario> userData;
  var userBloc = UserBloc();
  var _state = 1;

  @override
  void initState() {
    super.initState();
    Future.delayed(
        Duration(milliseconds: 500),
        () => setState(() {
              _state = 2;
            }));
    userData = userBloc.getUser();
  }

  alertDialog(context) {
    AlertDialog logout = AlertDialog(
      title: Text('Sair'),
      content: Container(
        child: Text('Você quer mesmo sair?'),
      ),
      actions: [
        FlatButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs?.clear();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginScreen()),
                  (Route<dynamic> route) => false);
            },
            child: Text('Sim')),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Não')),
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return logout;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Perfil'),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.userEdit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context, SlideTopRoute(page: UpdateScreen()));
                  }),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () {
            alertDialog(context);
          },
          child: Icon(Icons.exit_to_app),
        ),
        body: FutureBuilder(
            future: userData,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done ||
                  _state == 1) {
                return Center(
                  child: LoadingBouncingLine.circle(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 200,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Fundo(600.0, 200.0,
                                  Theme.of(context).primaryColor)),
                          Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 10,
                                    top: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        snapshot.data.nome,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: snapshot.data.cidade == null &&
                                              snapshot.data.uf == null
                                          ? Text(
                                              'Cidade e estados não informados',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            )
                                          : Text(
                                              snapshot.data.cidade +
                                                  ',' +
                                                  snapshot.data.uf,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white),
                                            ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width /
                                          1.8,
                                      top: MediaQuery.of(context).size.height /
                                          14),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.black26,
                                              offset: new Offset(2, 3),
                                              blurRadius: 4)
                                        ]),
                                    child: CircleAvatar(
                                        radius: 70,
                                        backgroundImage: snapshot
                                                    .data.caminhoFoto ==
                                                null
                                            ? AssetImage('images/usuarioP.png')
                                            : NetworkImage(
                                                snapshot.data.caminhoFoto)),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 10,
                          top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Dados',
                            style: TextStyle(
                                fontSize: 22, fontFamily: 'Montserrat-Bold'),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 35,
                          ),
                          Card(Icons.email, 'Email:', snapshot.data.email),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 35,
                          ),
                          Card(Icons.phone, "Telefone:", snapshot.data.fone_1),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 35,
                          ),
                        ],
                      ),
                    )
                  ],
                );
              }
            }));
  }
}

Widget Card(@required IconData icons, @required String textOne,
    @required String textTwo) {
  return Container(
    child: Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: new Offset(2, 3), blurRadius: 4)
          ]),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: Icon(icons),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Flexible(
          child: ListTile(
            title: Text(textOne),
            subtitle: Text(textTwo),
          ),
        )
      ],
    ),
  );
}

Widget Fundo(double x, double y, Color color) {
  return Transform(
    transform: Matrix4(0.87462, -0.48481, 0.0, 0.0, 0.48481, 0.87462, 0.0, 0.0,
        0.0, 0.0, 1.0, 0.0, -30, -5.83, 0.0, 0.7),
    child: Container(
      width: x,
      height: y,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(39.0),
        gradient: LinearGradient(
          begin: Alignment(-0.48, -0.17),
          end: Alignment(-0.94, 0.93),
          colors: [color, const Color(0xff0075fb)],
          stops: [0.0, 1.0],
        ),
      ),
    ),
  );
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path p = Path();
    p.lineTo(size.width / 5.5, size.height - 100);
    p.quadraticBezierTo(
        size.width / 2.9, size.height, size.width / 2, size.height - 50);
    p.lineTo(size.width, 0);
    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
