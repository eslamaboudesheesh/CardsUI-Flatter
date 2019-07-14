import 'package:flutter/material.dart';
import 'package:startagain/pages/service_locator.dart';
import './pages/start-app.dart';
import './pages/splash_screen.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => MyApp(),
  '/Myauthenticate' : (BuildContext context) => Myauthenticate(),
  '/faild' : (BuildContext context) => Myauthenticate()

};

void main() { 

  runApp(new MaterialApp(
  

    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    
    routes: routes
  
    
    ));
}


