import 'package:flutter/material.dart';

class UsuCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 150.0,
        horizontal: 25.0,
      ),
      child: Stack(
        children: <Widget>[
          usuCard,
          usuThumbnail,
          usuCamera,
        ],
      ),
    );
  }
  final usuThumbnail = Container(
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
          )
      ),
    ),
  );
  final usuCamera = GestureDetector(
    child: Container(
      margin: EdgeInsets.only(
        left: 185,
      ),
      child: Container(
        height: 35,
        width: 35,
        margin: EdgeInsets.only(
          top: 75,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(350)),
            image: DecorationImage(
              image: AssetImage("images/camB.png"),
            )
        ),
      ),
    ),
  );
  final usuCard = Padding(
    padding: EdgeInsets.only(top: 0),
    child: Container(
      height: 150.0,
      width: 300,
      margin: new EdgeInsets.only(left: 20,top: 60,right: 20),
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
          ]
      ),
      child: Container(
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const ListTile(
              title: Text('Clara Marques', style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
              subtitle: Text('cidade e estado', style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),
            ),
          ],
        ),
      ),
    ),
  );
}
