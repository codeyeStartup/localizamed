import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localizamed_app/components/initial_card.dart';

class InitialPageView extends StatefulWidget {
  @override
  _InitialPageViewState createState() => _InitialPageViewState();
}

class _InitialPageViewState extends State<InitialPageView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.8,
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: makeOriginals(),
        ),
    );
  }

  int counter = 0;

  List<Widget> makeOriginals() {
    List<Container> cardList = [];
    for (int i = 0; i < 3; i++) {
      counter++;
      cardList.add(Container(
        child: InitialCard()
      ));
      if (counter == 3) {
        counter = 0;
      }
    }
    return cardList;
  }
}

/* import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localizamed_app/components/initial_card.dart';

class InitialPageView extends StatefulWidget {
  @override
  _InitialPageViewState createState() => _InitialPageViewState();
}

class _InitialPageViewState extends State<InitialPageView> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.8,
        child: ListView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: makeOriginals(),
        ),
    );
  }

  int counter = 0;

  List<Widget> makeOriginals() {
    List<Container> cardList = [];
    for (int i = 0; i < 3; i++) {
      counter++;
      cardList.add(Container(
        child: InitialCard()
      ));
      if (counter == 3) {
        counter = 0;
      }
    }
    return cardList;
  }
} */
