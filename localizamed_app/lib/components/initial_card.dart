import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localizamed_app/screens/clinic_screen.dart';

class InitialCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return CupertinoButton(
        padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 8,right: MediaQuery.of(context).size.width / 50),
        child: Container(
            width: MediaQuery.of(context).size.width / 1.4,
            height: MediaQuery.of(context).size.height / 1.9,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/icon.png"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black38,
                    offset: new Offset(4.0, 4.0),
                    blurRadius: 5,
                  )
                ]
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                     borderRadius: BorderRadius.only(
                       topLeft: Radius.circular(300),
                       bottomLeft: Radius.circular(12),
                       bottomRight: Radius.circular(12)
                     ),
                       child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 250,
                        color: Theme.of(context).primaryColor,
                  ),
                )
               ),
                Align(
                  alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(500),
                          bottomLeft: Radius.circular(12),
                          bottomRight: Radius.circular(12)
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 3.4,
                        color: Colors.white,
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/ 3.2, left: MediaQuery.of(context).size.width / 4),
                  child: Text('Clinica Arruda', style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Breeserif',
                        fontSize: 25
                      ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/ 2.85, left: MediaQuery.of(context).size.width / 2.05),
                  width: MediaQuery.of(context).size.width / 5.3,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.green,
                        width: 2
                      )
                    )
                  ),
                  child: Text('Limoeiro', style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Breeserif',
                      fontSize: 18
                    ),
                  )
                ),

              ],
            )
        ),
      onPressed: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>ClinicScreen())
        );
      },
    );
  }
}
