import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localizamed_app/app/pages/initial/initial_card.dart';
import 'package:localizamed_app/app/pages/home/home_page.dart';
import 'package:localizamed_app/app/pages/search/search_screen.dart';

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
                                  fontFamily: 'Montserrat-ExtraBold'),
                            ),
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 40),
                        width: MediaQuery.of(context).size.width / 1.8,
                        height: MediaQuery.of(context).size.height / 16,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.black26,
                                  offset: Offset(1, 2))
                            ]),
                        child: FlatButton(
                          padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 20
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('Pesquisar', style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Montserrat-Bold',
                                fontSize: 12
                              ),),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 3.4,
                              ),
                              Icon(FontAwesomeIcons.search, size: 16,),
                            ],
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchScreen()));
                          },
                        ))
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
                        left: MediaQuery.of(context).size.width / 9,
                        top: MediaQuery.of(context).size.height / 8),
                    padding: EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                width: 4,
                                color: Theme.of(context).primaryColor))),
                    child: Text(
                      'Ultimas Clínicas',
                      style: TextStyle(fontSize: 26, fontFamily: 'Montserrat-ExtraBold'),
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
