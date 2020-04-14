import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:localizamed_app/app/pages/home/home_page.dart';
import 'package:localizamed_app/app/pages/splash_screen/splash_screen.dart';

class MsgInt extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (BuildContext context){
          return OfflineBuilder(
            connectivityBuilder: (
              BuildContext context,
              ConnectivityResult connectivity,
              Widget child
            ){
              final bool connected = connectivity != ConnectivityResult.none;
              return Stack(
                fit: StackFit.expand,
                children: [
                  child,
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    height: 32.0,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 3000),
                      color: connected ? null : Color(0xFFEE4400),
                      child: connected ? null :
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("SEM CONEXAO", style: TextStyle(color: Colors.white),),
                          SizedBox(width: 8.0,),
                          SizedBox(width: 12.0, height: 12.0,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.0,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),)
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
            child: SplashScreen(),
          );
        },
        ),
    );
  }
}