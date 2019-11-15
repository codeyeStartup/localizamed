import 'package:flutter/material.dart';
import 'package:localizamed_app/components/tab_usuario.dart';

class UserColapsed extends StatefulWidget {

  @override
  _UserColapsedState createState() => _UserColapsedState();
}

class _UserColapsedState extends State<UserColapsed> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: MySliverAppBar(expandedHeight: 250),
          ),
         SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 130, left: 50),
                            child: Text("Informações", style: TextStyle(
                              fontSize: 30,
                             ),
                            ),
                          ),
                          SizedBox(height: 10,),
                          Container(
                            margin: EdgeInsets.only(left: 50),
                            padding: EdgeInsets.only(left: 10),
                            width: 300,
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              gradient: LinearGradient(colors: [Color.fromARGB(255, 255, 0, 0),
                              Color.fromARGB(255, 139, 0, 0)])
                            ),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.email, color: Colors.white,),
                                SizedBox(width: 10,),
                                Text("Exemplo@gmail.com", style: TextStyle(
                                  color: Colors.white
                                ),),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ]
            ),
         )
        ],
      )
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate{
  final double expandedHeight;

  MySliverAppBar({@required this.expandedHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: <Widget>[
        Image.asset('images/usuarioN.png',
          fit: BoxFit.cover,
        ),
        Container(
          color: Color.fromRGBO(255, 56, 46, 0.3),
        ),
        Positioned(
          top: expandedHeight / 200 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 80,
          child: UsuCard()
        ),
        Positioned(
            top: expandedHeight / 50 - shrinkOffset,
            right: MediaQuery.of(context).size.width / 80,
            child: Icon(
              Icons.more_horiz,
              color: Colors.white,
              size: 50,
            )
        ),
      ],
    );
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => expandedHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;

}