import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localizamed_app/components/initial_card.dart';
import 'package:localizamed_app/components/initial_page_view.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {

  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
         flexibleSpace: SafeArea(
           child: Container(
               height: MediaQuery.of(context).size.height,
               child:  Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   Padding(
                       padding: EdgeInsets.only(right: MediaQuery.of(context).size.width / 10,
                           top: MediaQuery.of(context).size.height / 30
                       ),
                       child: Row(
                         children: <Widget>[
                           Image(image: AssetImage('images/Icon.png'),width: 40,height: 40,),
                           Text('Explore',style: TextStyle(color: Colors.black, fontFamily: 'Montserrat'),),
                         ],
                       )
                   ),
                   Container(
                     margin: EdgeInsets.only(left: 6,right: 6,top: MediaQuery.of(context).size.height / 30),
                     padding: EdgeInsets.only(left: 10),
                     width: MediaQuery.of(context).size.width / 1.7,
                     height: MediaQuery.of(context).size.height / 16,
                     decoration: BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.all(Radius.circular(10)),
                         boxShadow: [
                           BoxShadow(
                               blurRadius: 5,
                               color: Colors.black38,
                               offset: Offset(1,2)
                           )
                         ]
                     ),
                     child: TextField(
                         decoration: InputDecoration(
                           contentPadding: EdgeInsets.all(4),
                             hintStyle: TextStyle(fontSize: 14),
                             hintText: 'Pesquisar',
                             suffixIcon: Icon(FontAwesomeIcons.search,size: 18,
                               color: isActive == true ? Theme.of(context).primaryColor : Colors.black87,
                             ),
                             enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
                             focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.transparent))
                         )
                     ),
                   )
                 ],
               )
           ),
         ),
         backgroundColor: Colors.white,
         elevation: 0.0,
         ),
      body: LayoutBuilder(
        builder: (context, constrains){
          return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 8,
                        top: MediaQuery.of(context).size.height / 10
                    ),
                    padding: EdgeInsets.only(left: 4),
                    decoration: BoxDecoration(
                        border: Border(
                            left: BorderSide(
                                width: 4,
                                color: Theme.of(context).primaryColor
                            )
                        )
                    ),
                    child: Text('Ultimas Clínicas', style: TextStyle(
                        fontSize: 26,
                        fontFamily: 'Montserrat'
                    ),),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: InitialPageView()
                  )
                ],
              )
          );
        },
      )
    );
  }
}
