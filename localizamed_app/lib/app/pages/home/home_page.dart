import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localizamed_app/app/pages/user_profile/user_bloc.dart';
import 'package:localizamed_app/app/pages/clinic/clinica_painel.dart';
import 'package:localizamed_app/app/pages/initial/initial_screen.dart';
import 'package:localizamed_app/app/pages/medic/medic_screen.dart';
import 'package:localizamed_app/app/pages/search/search_screen.dart';
import 'package:localizamed_app/app/pages/user_profile/user_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:localizamed_app/app/utils/conexaoAPI.dart';

class BottomMenu extends StatefulWidget {
  BottomMenu({Key key}) : super(key: key);

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  int _selectedIndex = 0;
  static TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    InitialScreen(),
    SearchScreen(),
    CardMedicoScreen(),
    ClinicaCardScreen(),
    UserProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void initState() {
    userBloc.getUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    return Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
              height: size.height / 12,
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                    color: Colors.black54,
                    offset: new Offset(5, 5),
                    blurRadius: 20)
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(left: 10, right: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: _selectedIndex == 0 ? 2 : 0.1,
                                  color: _selectedIndex == 0
                                      ? Theme.of(context).primaryColor
                                      : Colors.white))),
                      height: size.height,
                      child: Icon(
                        MdiIcons.home,
                        size: 30,
                        color: _selectedIndex == 0
                            ? Theme.of(context).primaryColor
                            : Colors.grey[500],
                      ),
                    ),
                    onTap: () {
                      _onItemTapped(0);
                    },
                  ),
                  GestureDetector(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 10, right: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: _selectedIndex == 1 ? 2 : 0.1,
                                  color: _selectedIndex == 1
                                      ? Color.fromARGB(255, 255, 215, 0)
                                      : Colors.white))),
                      height: size.height,
                      child: Icon(Icons.search,
                          size: 30,
                          color: _selectedIndex == 1
                              ? Color.fromARGB(255, 255, 215, 0)
                              : Colors.grey[500]),
                    ),
                    onTap: () {
                      _onItemTapped(1);
                    },
                  ),
                  GestureDetector(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 10, right: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: _selectedIndex == 2 ? 2 : 0.1,
                                  color: _selectedIndex == 2
                                      ? Colors.red
                                      : Colors.white))),
                      height: size.height,
                      child: Icon(MdiIcons.medicalBag,
                          size: 30,
                          color: _selectedIndex == 2
                              ? Colors.red
                              : Colors.grey[500]),
                    ),
                    onTap: () {
                      _onItemTapped(2);
                    },
                  ),
                  GestureDetector(
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(
                                  width: _selectedIndex == 3 ? 2 : 0.1,
                                  color: _selectedIndex == 3
                                      ? Colors.green
                                      : Colors.white))),
                      height: size.height,
                      child: Icon(FontAwesomeIcons.clinicMedical,
                          size: 24,
                          color: _selectedIndex == 3
                              ? Colors.green
                              : Colors.grey[500]),
                    ),
                    onTap: () {
                      _onItemTapped(3);
                    },
                  ),
                  GestureDetector(
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 10, right: 20),
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: _selectedIndex == 4 ? 2 : 0.1,
                                    color: _selectedIndex == 4
                                        ? Colors.cyanAccent
                                        : Colors.white))),
                        height: size.height,
                        child: StreamBuilder(
                          stream: userBloc.usuario,
                          builder: (context, snapshot) {
                            return Container(
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: snapshot.data.caminhoFoto == null
                                    ? Image.asset(
                                        'images/usuarioP.png',
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(ConexaoAPI().api +
                                        'imagensUsarios/' +
                                        snapshot.data.caminhoFoto));
                          },
                        )),
                    onTap: () {
                      _onItemTapped(4);
                    },
                  ),
                ],
              )),
        ));
  }
}
