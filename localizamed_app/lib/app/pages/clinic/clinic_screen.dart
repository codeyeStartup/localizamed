import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localizamed_app/app/pages/clinic/clinica.bloc.dart';
import 'package:localizamed_app/app/utils/conexaoAPI.dart';
import 'package:localizamed_app/app/pages/clinic/clinic_page_view.dart';
import 'dart:core';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClinicScreen extends StatefulWidget {
  @override
  _clinicScreenState createState() => _clinicScreenState();
}

class _clinicScreenState extends State<ClinicScreen> {
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
                delegate: MySliverAppBar(
                  expandedHeight: appBarHeight,
                ),
              ),
              SliverList(
                  delegate: SliverChildListDelegate(<Widget>[ClinicPageView()]))
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.arrow_back,
          size: 30,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  @override
  void initState() {
    clinicaBloc.getClinica();
  }

  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;

    return StreamBuilder(
        stream: clinicaBloc.clinica,
        builder: (context, snapshot) {
          return Stack(
            fit: StackFit.expand,
            overflow: Overflow.visible,
            children: [
              Container(
                width: size.width,
                height: expandedHeight,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        width: size.width,
                        height: expandedHeight / 1.1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                            image: DecorationImage(
                              image: NetworkImage(ConexaoAPI().api +
                                  'imagensClinica/' +
                                  snapshot.data.caminhoFoto),
                              fit: BoxFit.fill,
                            ),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.black12,
                                  offset: Offset(1, 2))
                            ]),
                      ),
                    ),
                    Positioned(
                        top: expandedHeight / 1.58 - shrinkOffset,
                        child: Container(
                            width: size.height / 2.5,
                            height: size.height / 5.8,
                            margin: EdgeInsets.only(left: 45, right: 45),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.black38,
                                      offset: Offset(1, 2))
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  snapshot.data.nome,
                                  style: TextStyle(fontSize: 24),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.user,
                                        color: Colors.red),
                                    Text(snapshot.data.medicosClin.length
                                        .toString()),
                                    SizedBox(width: 40),
                                    Icon(Icons.content_paste),
                                    Text(
                                      snapshot.data.examConsultaClin.length
                                          .toString(),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(width: 40),
                                    Icon(
                                      FontAwesomeIcons.phoneAlt,
                                      color: Colors.green,
                                    ),
                                    Text('2'),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  snapshot.data.bairro,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ))),
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}