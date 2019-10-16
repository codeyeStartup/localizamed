 import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var checkSelected = ['blue', 'green'];
    bool ind = false;
    var i;
    //bool checkSelected = true;

          return new MaterialApp(
            color: Colors.yellow,
            home: DefaultTabController(
              length: 5,
              child: new Scaffold(
                body: TabBarView(
                  children: [
                    new Container(
                      color: Colors.yellow,
                    ),
                    new Container(
                      color: Colors.white,
                    ),
                    new Container(
                      color: Colors.orange,),
                    new Container(  
                      color: Colors.lightGreen,
                    ),
                    new Container(
                      color: Colors.red,
                    ),
                  ],
                ),
                bottomNavigationBar: new TabBar(
                  tabs: [
                    Tab(
                      icon: new Icon(Icons.home,size: 33,) 
                    ),              
                    Tab(
                      icon: new Icon(FontAwesomeIcons.search,),
                    ),              
                    Tab(
                      icon: new Icon(FontAwesomeIcons.userCircle)
                    ),
                    Tab(
                      icon: new Icon(FontAwesomeIcons.briefcaseMedical),
                    ),
                    Tab(icon: new Icon(FontAwesomeIcons.clinicMedical)
                    ,)
          ],
      labelColor: Colors.blue[900],
      unselectedLabelColor:  Colors.grey[500],
      indicatorSize: TabBarIndicatorSize.label,
      //indicatorPadding: EdgeInsets.all(5),
      indicatorColor: Colors.white,
    ),
    backgroundColor: Colors.white,
  ),
),
);
}
} 

//Color _color = Colors.red;

//----------------------------------------------

/* import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  PageController _pageController;
  int _pagina = 0;
  

  @override
  void initState(){
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.pinkAccent,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(color: Colors.white)
          )
        ),
        child: BottomNavigationBar(
            currentIndex: _pagina,
            onTap: (p){
              _pageController.animateToPage(
                p,
                duration: Duration(milliseconds: 500),
                curve: Curves.ease
              );
            },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text("")                  
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text("")
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text("")
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  title: Text("")
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.local_hospital),
                  title: Text("")
                )
              ]            
          ),
      ),

      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (p){
            setState(() {
             _pagina = p; 
            });
          },
          children: <Widget>[
            Container(color: Colors.blue,),
            Container(color: Colors.pink),
            Container(color: Colors.orange),
            Container(color: Colors.yellow),
            Container(color: Colors.red),
          ],
        ),
      ),
    );
  }
}  */