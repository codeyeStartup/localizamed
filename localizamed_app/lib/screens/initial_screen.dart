import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localizamed_app/components/initial_card.dart';
import 'package:localizamed_app/screens/bottom_menu_screen.dart';
import 'package:localizamed_app/screens/search_screen.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: Container(
                height: MediaQuery.of(context).size.height,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 10,
                            top: MediaQuery.of(context).size.height / 30),
                        child: Row(
                          children: <Widget>[
                            Image(
                              image: AssetImage('images/icon.png'),
                              width: 40,
                              height: 40,
                            ),
                            Text(
                              'Explore',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'Montserrat'),
                            ),
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.only(
                          left: 6,
                          right: 6,
                          top: MediaQuery.of(context).size.height / 30),
                      padding: EdgeInsets.only(left: 10),
                      width: MediaQuery.of(context).size.width / 1.7,
                      height: MediaQuery.of(context).size.height / 16,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                color: Colors.black38,
                                offset: Offset(1, 2))
                          ]),
                      child: FlatButton(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Pesquisar'),
                            SizedBox(width: MediaQuery.of(context).size.width / 4,),
                            Icon(Icons.search),
                          ],
                        ),
                        onPressed: (){
                          Navigator.of(context).push( MaterialPageRoute(
                                                          builder: (context) =>
                                                              SearchScreen())); },
                      )
                    )
                  ],
                )),
          ),
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: LayoutBuilder(
          builder: (context, constrains) {
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 8,
                        top: MediaQuery.of(context).size.height / 10),
                    padding: EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                width: 4,
                                color: Theme.of(context).primaryColor))),
                    child: Text(
                      'Ultimas Clínicas',
                      style: TextStyle(fontSize: 26, fontFamily: 'Montserrat'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),                  
                  InitialCard()
                ],
              ),
            );
          },
        ));
  }
}
