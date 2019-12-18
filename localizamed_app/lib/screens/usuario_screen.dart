import 'package:flutter/material.dart';
import 'package:localizamed_app/blocs/user_bloc.dart';
import 'package:localizamed_app/components/tab_usuario.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:localizamed_app/screens/login_screen.dart';
import 'package:localizamed_app/screens/update_user_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserColapsed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}
