import 'package:flutter/material.dart';

class MedCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 24.0,
      ),
      child: new Stack(
        children: <Widget>[
          medCard,
          medThumbnail,
        ],
      ),
    );
  }
  final medThumbnail = new Container(
    margin: new EdgeInsets.symmetric(
        vertical: 16.0
    ),
    alignment: FractionalOffset.centerLeft,
    child: new Container(
      height: 95.0,
      width: 95.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(270)),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("images/medico.jpg"),
        )
      ),
    ),
  );
  final medCard = new Container(
    height: 124.0,
    width: 300.0,
    margin: new EdgeInsets.only(left: 46.0),
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
      padding: EdgeInsets.only(left: 50,),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.redAccent, width: 3.0))
      ),
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const ListTile(
            title: Text('Dr. Pedro', style: TextStyle(fontSize: 20),),
            subtitle: Text('Limoeiro', style: TextStyle(fontSize: 16),),
          ),
        ],
      ),
    )
  );
}
