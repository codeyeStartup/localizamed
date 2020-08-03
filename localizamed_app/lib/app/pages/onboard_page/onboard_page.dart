import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localizamed_app/app/pages/login/login_screen.dart';

class OnboardPage extends StatefulWidget {
  @override
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      alignment: Alignment.centerLeft,
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 6.0),
      height: 8.0,
      width: isActive ? 8.0 : 8.0,
      decoration: BoxDecoration(
          color: isActive ? Theme.of(context).primaryColor : Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
    );
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Container(
              height: size.height,
              width: size.width,
              color: Colors.transparent,
              child: LayoutBuilder(builder: (context, constraints) {
                return Column(
                  children: <Widget>[
                    Container(
                      height: size.height / 1.2,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 100.0),
                            height: size.height / 1.2,
                            alignment: Alignment.center,
                            child: PageView(
                              physics: ClampingScrollPhysics(),
                              controller: _pageController,
                              onPageChanged: (int page) {
                                setState(() {
                                  _currentPage = page;
                                });
                              },
                              children: <Widget>[
                                page_one(context),
                                page_two(context),
                                page_three(context)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    _currentPage != _numPages - 1
                        ? Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 10,
                                    top: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Row(children: _buildPageIndicator()),
                                    SizedBox(
                                      width: size.width / 1.9,
                                    ),
                                    FloatingActionButton(
                                        backgroundColor: Colors.black87,
                                        onPressed: () {
                                          _pageController.nextPage(
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.ease,
                                          );
                                        },
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        )),
                                  ],
                                )),
                          )
                        : Text(''),
                  ],
                );
              }),
            )),
        bottomSheet:
            _currentPage == _numPages - 1 ? animatedButton(context) : Text(""));
  }
}

Widget page_one(BuildContext context) {
  return Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Image.asset(
        'images/LocalizaMed_T1.png',
        width: MediaQuery.of(context).size.width,
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height / 16,
      ),
      Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width / 10,
            top: MediaQuery.of(context).size.width / 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Procurando por\nClinícas ?",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "No LocalizaMed, irá encontrar a \nclinica mais perto de você",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            )
          ],
        ),
      )
    ],
  ));
}

Widget page_two(BuildContext context) {
  return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
        Image.asset(
          'images/LocalizaMed_T2.png',
          width: MediaQuery.of(context).size.width / 1.1,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 16,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 10,
              top: MediaQuery.of(context).size.width / 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Médicos",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                  "Sim, nós trazemos os melhores \nmédicos para tratar da sua saúde",
                  style: TextStyle(fontSize: 18, color: Colors.black54))
            ],
          ),
        )
      ]));
}

Widget page_three(BuildContext context) {
  return Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Image.asset(
        'images/LocalizaMed_T3.png',
        width: MediaQuery.of(context).size.width / 1.1,
      ),
      SizedBox(
        height: MediaQuery.of(context).size.height / 16,
      ),
      Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width / 10,
              top: MediaQuery.of(context).size.width / 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Exames",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Aqui você encontrará o exame que tanto procura",
                style: TextStyle(fontSize: 18, color: Colors.black54),
              )
            ],
          ))
    ],
  ));
}

Widget animatedButton(BuildContext context){
  return AnimatedContainer(
        duration: Duration(milliseconds: 150),
        height: MediaQuery.of(context).size.height / 8,
        curve: Curves.bounceIn,
        width: MediaQuery.of(context).size.width,
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 8, 
          right: MediaQuery.of(context).size.width / 8,
          bottom: 40,
          ),
          child: RaisedButton(
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40)
            ),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context)=>LoginScreen())
              );
            },
            child: Text(
              "INICIAR",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
        ));
}