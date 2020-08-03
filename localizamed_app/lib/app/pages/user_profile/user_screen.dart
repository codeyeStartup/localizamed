import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localizamed_app/app/models/user_model.dart';
import 'package:localizamed_app/app/pages/user_profile/user_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:localizamed_app/app/pages/login/login_screen.dart';
import 'package:localizamed_app/app/pages/user_profile/update_user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  Future<Usuario> userData;
  var userBloc = UserBloc();

  @override
  void initState(){
    super.initState();
    userData = userBloc.getUser();
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
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext ctx) => UpdateScreen()));
                  }),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('email');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext ctx) => LoginScreen()));
          },
          child: Icon(Icons.exit_to_app),
        ),
        body: FutureBuilder(
            future: userData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
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
                            child: Fundo(600.0,200.0,Theme.of(context).primaryColor)
                          ),
                          Stack(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    left: MediaQuery.of(context).size.width / 10,
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
                                      child: Text(
                                        snapshot.data.cidade +
                                            ',' +
                                            snapshot.data.uf,
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.white),
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
                          left: MediaQuery.of(context).size.width / 10, top: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Dados',
                            style: TextStyle(fontSize: 22,fontFamily: 'Montserrat-Bold'),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 35,
                          ),
                          Card(Icons.email, 'Email:', snapshot.data.email),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 35,
                          ),
                          Card(FontAwesomeIcons.addressCard, "Telefone:",
                              snapshot.data.fone_1),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 35,
                          ),
                          Card(
                              FontAwesomeIcons.addressCard,
                              "CPF:",
                              snapshot.data.cpf == ''
                                  ? 'CPF não informado'
                                  : snapshot.data.cpf),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 35,
                          ),
                          Card(
                              FontAwesomeIcons.addressCard,
                              'RG:',
                              snapshot.data.rg == ''
                                  ? 'RG não informado'
                                  : snapshot.data.rg)
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

Widget Fundo(double x,double y, Color color){
  return Transform(
            transform: Matrix4(0.87462, -0.48481, 0.0, 0.0, 0.48481, 0.87462,
                0.0, 0.0, 0.0, 0.0, 1.0, 0.0, -30, -5.83, 0.0, 0.7),
            child: Container(
              width: x ,
              height: y ,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(39.0),
                gradient: LinearGradient(
                  begin: Alignment(-0.48,-0.17),
                  end: Alignment(-0.94,0.93),
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

//Anterior
/*     return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: MySliverAppBar(expandedHeight: 250),
          ),
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 130, left: 50),
                          child: Text(
                            "Informações",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 50),
                          padding: EdgeInsets.only(left: 10),
                          width: 300,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 255, 0, 0),
                                Color.fromARGB(255, 139, 0, 0)
                              ])),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.email,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              StreamBuilder(
                                  stream: userBloc.usuario,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    } else {
                                      return Text(
                                        snapshot.data.email,
                                        style: TextStyle(color: Colors.white),
                                      );
                                    }
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ]),
          )
        ],
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Theme.of(context).primaryColor,
        overlayColor: Colors.transparent,
        overlayOpacity: 0.1,
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
              child: Icon(Icons.settings),
              label: "Alterar dados",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext ctx) => UpdateScreen()));
              }),
          SpeedDialChild(
              child: Icon(Icons.panorama),
              label: "Alterar foto de capa",
              onTap: () => print("primeiro")),
          SpeedDialChild(
              child: Icon(Icons.camera_alt),
              label: "Alterar foto de perfil",
              backgroundColor: Theme.of(context).primaryColor,
              onTap: () => print("segundo")),
          SpeedDialChild(
            child: Icon(Icons.exit_to_app),
            label: "Sair da conta",
            backgroundColor: Colors.redAccent,
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('email');
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext ctx) => LoginScreen()));
            },
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: <Widget>[
        Image.asset(
          'images/usuarioN.png',
          fit: BoxFit.cover,
        ),
        Container(
          color: Color.fromRGBO(255, 56, 46, 0.3),
        ),
        Positioned(
            top: expandedHeight / 200 - shrinkOffset,
            left: MediaQuery.of(context).size.width / 80,
            child: UsuCard()),
        Scaffold(
          backgroundColor: Colors.transparent,
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
} */
