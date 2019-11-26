import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget card(double widthT, double heightT,@required IconData icon, @required Color icon_BorderColor,
    @required String title,@required String text){
  return Container(
    margin: EdgeInsets.all(8),
    padding: EdgeInsets.all(22),
    height: heightT,
    width: widthT,
    decoration: BoxDecoration(
        color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      boxShadow: [
        BoxShadow(
          color: Colors.black38,
          offset: new Offset(3.0, 5.0),
          blurRadius: 6.0,
        )
      ]
    ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(250)),
              border: Border.all(
               color: icon_BorderColor,
                width: 2
              )
            ),
            child: Icon(icon, size: 25,color: icon_BorderColor,),
          ),
          Text(title, style: TextStyle(
            fontSize: 25
          ),),
          Text(text, style: TextStyle(
            fontSize: 18
          ),)
        ],
      )
  );
}

