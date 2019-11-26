import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:core';
import 'package:localizamed_app/components/clinic_grid_view.dart';

class ClinicScreen extends StatefulWidget {
  @override
  _ClinicScreenState createState() => _ClinicScreenState();
}

class _ClinicScreenState extends State<ClinicScreen> {

  double appBarHeight = 400;

  @override

  Widget build(BuildContext context) {

    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            //controller: controller,
            slivers: <Widget>[
              SliverPersistentHeader(
                 delegate: MySliverAppBar(expandedHeight: appBarHeight,),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(
                      <Widget>[
                        Stack(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: size.height/ 5),
                              child: card(190, size.height / 3.4, Icons.content_paste, Colors.yellow, 'Exames', 'Algum ai'),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: size.width / 2, top: size.height/ 6),
                                child:card(190, size.height / 3.4,Icons.web ,Colors.black, 'Site', 'aquelela.com')
                            )
                          ],
                        )
                      ]
                  )
              )
            ],
          ),
        ],
      )
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {

  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {

    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Image.asset(
          "images/teste.jpg",
          fit: BoxFit.cover,
        ),
        Container(
          padding: EdgeInsets.only(top: expandedHeight / 1.7 - shrinkOffset),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
            stops: [0.3, 1],
            colors: [Colors.transparent, Colors.white])
         ),
          child: Padding(
              padding: EdgeInsets.only(left: size.width / 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('Clinica Show', style: TextStyle(fontSize: 40),),
                  Container(
                      width: size.width / 2,
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 4,
                                  color: Colors.green
                              )
                          )
                      )
                  )
                ],
              )
          ),
        ),
        Positioned(
          top: expandedHeight / 1.3 - shrinkOffset,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 0),
                child: card(190, size.height / 3.4,FontAwesomeIcons.locationArrow , Theme.of(context).primaryColor,
                    'Localização', 'Rua da laranja,nº28, Limoeiro,Pernambuco-PE'),
              ),
              Padding(
                  padding: EdgeInsets.only(left: 0),
                  child:card(190, size.height / 3.8,Icons.phone ,Colors.green, 'Contato', 'devotos do show')
              ),
            ],
          )
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