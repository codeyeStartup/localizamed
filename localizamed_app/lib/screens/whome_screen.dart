import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localizamed_app/components/home_onboard_page.dart';
import 'package:localizamed_app/screens/login_screen.dart';

class WHomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<WHomeScreen> {
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
        backgroundColor: Color.fromARGB(255, 23, 29, 255),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Container(
            height: size.height,
            width: size.width,
            color: Colors.transparent,
            child: LayoutBuilder(
             builder: (context, constraints) {
              return Padding(
                 padding: const EdgeInsets.all(0.0),
                 child: Column(
                   children: <Widget>[
                     Container(
                       height: size.height / 1.14,
                       decoration: BoxDecoration(
                           color: Colors.white,
                           borderRadius: BorderRadius.only(
                               bottomRight: Radius.circular(50.0),
                               bottomLeft: Radius.circular(50.0)
                           ),
                           boxShadow: [
                             BoxShadow(
                               color: Colors.black54,
                               offset: new Offset(5.0, 5.0),
                               blurRadius: 20.0,
                             )
                           ]
                       ),
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
                                       children: <Widget>[
                                         Text(
                                           "Hello 1",
                                           style: TextStyle(
                                               fontFamily: 'BreeSerif',
                                               fontSize: 30.0),
                                         )
                                       ],
                                     )),
                                 Container(
                                     child: Column(
                                       children: <Widget>[Text("Hello 2")],
                                     )),
                                 Container(
                                     child: Column(
                                       children: <Widget>[Text("Hello 3")],
                                     )),
                               ],
                             ),
                           ),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: _buildPageIndicator(),
                           ),
                         ],
                       ),
                     ),
                     SizedBox(height: size.height/ 25),
                     Row(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: <Widget>[
                         FlatButton(
                           onPressed: () {
                             Navigator.of(context).push(
                                 MaterialPageRoute(
                                     builder: (context) => LoginScreen())
                             );
                           },
                           child: Text(
                             "Skip",
                             style: TextStyle(
                                 color: Colors.white, fontSize: 18.0),
                           ),
                         ),
                         _currentPage != _numPages - 1
                             ? Expanded(
                           child: Align(
                             alignment: FractionalOffset.bottomRight,
                             child: FlatButton(
                               onPressed: () {
                                 _pageController.nextPage(
                                   duration: Duration(milliseconds: 500),
                                   curve: Curves.ease,
                                 );
                               },
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.end,
                                 mainAxisSize: MainAxisSize.max,
                                 children: <Widget>[
                                   Text(
                                     'Next',
                                     style: TextStyle(
                                       color: Colors.white,
                                       fontSize: 18.0,
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         )
                             : Text(''),
                       ],
                     )
                   ],
                 ),
               );
             }
            ),
          )
        ),
        bottomSheet:
            _currentPage == _numPages - 1 ? AnimatedButton() : Text(""));
}
}