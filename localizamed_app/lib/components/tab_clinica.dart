import 'package:flutter/material.dart';

class TabClinica extends StatefulWidget {
  @override
  _TabClinicaState createState() => _TabClinicaState();
}

class _TabClinicaState extends State<TabClinica> {
  @override
  Widget build(BuildContext context) {
    return Container( 
    child: Center(
      child: Card(
        shape: RoundedRectangleBorder(        
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: Colors.pink,
        elevation: 10,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ListTile(
              leading: Icon(Icons.album, size: 70),
              trailing: Icon(Icons.star),
              title: Text('Heart Shaker Sandrinho', style: TextStyle(color: Colors.white)),
              subtitle: Text('TWICE', style: TextStyle(color: Colors.white)),
            ),
            /* ButtonTheme.bar(
              child: ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: const Text('Edit', style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: const Text('Delete', style: TextStyle(color: Colors.white)),
                    onPressed: () {},
                  ),
                ],
              ),
            ), */
          ],
        ),
      ),
    ),
  );
  }
}