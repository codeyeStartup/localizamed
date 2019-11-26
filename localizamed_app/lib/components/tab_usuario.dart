import 'dart:async';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:localizamed_app/blocs/user_bloc.dart';
import 'package:localizamed_app/classes/user_class.dart';
import 'package:localizamed_app/models/user_get.dart';

class UsuCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    userBloc.getUser();
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 150.0,
          horizontal: 25.0,
        ),
        child: Stack(
          children: <Widget>[
            //USUCARD
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Container(
                height: 150.0,
                width: 300,
                margin: new EdgeInsets.only(left: 20, top: 60, right: 20),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: new BorderRadius.circular(8.0),
                    boxShadow: <BoxShadow>[
                      new BoxShadow(
                        color: Colors.black54,
                        blurRadius: 5.0,
                        offset: new Offset(2.0, 5.0),
                      )
                    ]),
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      StreamBuilder(
                          stream: userBloc.usuario,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      snapshot.data.nome, //snapshot.data.nome,
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      snapshot.data.cidade +
                                          ', ' +
                                          snapshot
                                              .data.uf, //snapshot.data.cidade
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                    Text(
                                      snapshot
                                          .data.fone_1, //snapshot.data.cidade
                                      style: TextStyle(fontSize: 16),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );

                              /* return ListTile(
                                title: Text(
                                  snapshot.data.nome, //snapshot.data.nome,
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                                subtitle: Text(
                                  snapshot.data.cidade + ', ' + snapshot.data.uf , //snapshot.data.cidade
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                                
                              ); */
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),

            //USU_ALGUMA_COISA
            Container(
              margin: EdgeInsets.only(
                left: 110,
              ),
              child: Container(
                height: 110.0,
                width: 110.0,
                margin: EdgeInsets.only(
                  bottom: 0,
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(280)),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("images/usuarioP.png"),
                    )),
              ),
            ),
          ],
        ));
  }
}

//------------------------------------------

/* import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:localizamed_app/models/user_get.dart';


class UsuCard extends StatefulWidget {
  @override
  _UsuCardState createState() => _UsuCardState();
}

class _UsuCardState extends State<UsuCard> with AutomaticKeepAliveClientMixin<UsuCard> {
  Future<Usuario> usuario;

  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() {    
    usuario = getUsuario();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    super.build(context);
    return Container(
        margin: const EdgeInsets.symmetric(
          vertical: 150.0,
          horizontal: 25.0,
        ),
        child: FutureBuilder<Usuario>(
           future: usuario,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              } else {
                return Stack(
                  children: <Widget>[
                    //USUCARD
                    Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Container(
                        height: 150.0,
                        width: 300,
                        margin:
                            new EdgeInsets.only(left: 20, top: 60, right: 20),
                        decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: new BorderRadius.circular(8.0),
                            boxShadow: <BoxShadow>[
                              new BoxShadow(
                                color: Colors.black54,
                                blurRadius: 5.0,
                                offset: new Offset(2.0, 5.0),
                              )
                            ]),
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  snapshot.data.nome,
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.center,
                                ),
                                subtitle: Text(
                                  snapshot.data.cidade +
                                      ', ' +
                                      snapshot.data.uf,
                                  style: TextStyle(fontSize: 16),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    //USU_ALGUMA_COISA
                    Container(
                      margin: EdgeInsets.only(
                        left: 110,
                      ),
                      child: Container(
                        height: 110.0,
                        width: 110.0,
                        margin: EdgeInsets.only(
                          bottom: 0,
                        ),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(280)),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("images/usuarioP.png"),
                            )),
                      ),
                    ),
                  ],
                );
              }
            }));
  }
}
 */
