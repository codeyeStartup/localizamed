import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localizamed_app/app/pages/onboard_page/button_onboard_page.dart';
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
      width: isActive ? 28.0 : 14.0,
      decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.grey,
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
            child: LayoutBuilder(
             builder: (context, constraints) {
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
                                 Container(
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: <Widget>[
                                         Image.asset('images/LocalizaMed_T1.png', width: size.width / 1,),
                                         Padding(
                                           padding: EdgeInsets.all(15),
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: <Widget>[
                                               Text(
                                           "Procurando por Clinícas ?",
                                           style: TextStyle(
                                               fontFamily: 'BreeSerif',
                                               fontSize: 30.0),
                                         ),
                                         SizedBox(
                                           height: 20,
                                         ),
                                         Text(
                                           "No LocalizaMed, irá encontrar a clinica mais perto de você",
                                           style: TextStyle(
                                               fontFamily: 'BreeSerif',
                                               fontSize: 20.0),
                                         )
                                             ],
                                           )
                                         )
                                       ],
                                     )),
                                 Container(
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: <Widget>[
                                         Image.asset('images/LocalizaMed_T2.png', width: size.width / 1.1,),
                                         Padding(
                                           padding: EdgeInsets.all(15),
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: <Widget>[
                                               Text(
                                           "Médicos",
                                           style: TextStyle(
                                               fontFamily: 'BreeSerif',
                                               fontSize: 30.0),
                                         ),
                                         SizedBox(
                                           height: 20,
                                         ),
                                         Text(
                                           "Sim, nós trazemos os melhores médicos para tratar da sua saúde",
                                           style: TextStyle(
                                               fontFamily: 'BreeSerif',
                                               fontSize: 20.0),
                                         )
                                             ],
                                           )
                                         )]
                                     )),
                                 Container(
                                   padding: EdgeInsets.all(15),
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: <Widget>[
                                         Image.asset('images/LocalizaMed_T3.png', width: size.width / 1.1,),
                                         Text(
                                           "Exames",
                                           style: TextStyle(
                                               fontFamily: 'BreeSerif',
                                               fontSize: 30.0),
                                           ),
                                           SizedBox(
                                           height: 20,
                                         ),
                                         Text(
                                           "",
                                           style: TextStyle(
                                               fontFamily: 'BreeSerif',
                                               fontSize: 20.0),
                                         )
                                           ],
                                     )),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),
                     _currentPage != _numPages - 1
                             ? Expanded(
                           child: Padding(
                             padding: EdgeInsets.all(15),
                             child: Row(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: <Widget>[
                                 Row(children: _buildPageIndicator()),
                                 SizedBox(width: size.width / 2,),
                                 FloatingActionButton(
                                  backgroundColor: Color.fromARGB(255, 23, 29, 255),
                                  onPressed: () {
                                   _pageController.nextPage(
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                  );
                               },
                               child: Icon(Icons.arrow_forward_ios, color: Colors.white,)
                             ),
                               ],
                             )
                           ),
                         )
                             : Text(''),
                   ],
                 );
             }
            ),
          )
        ),
        bottomSheet:
            _currentPage == _numPages - 1 ? AnimatedButton() : Text(""));
}
}