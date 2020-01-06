import 'package:flutter/material.dart';
import 'package:localizamed_app/screens/medico_painel.dart';

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
            CardMedicoScreen(),
            Container(color: Colors.red),
          ],
        ),
      ),
    );
  }
} 