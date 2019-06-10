import 'package:flutter/material.dart';
import './pages/start-app.dart';
import './pages/splash_screen.dart';
import 'package:advanced_share/advanced_share.dart';


var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => MyApp(),

};

void main() => runApp(new MaterialApp(
  

    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: routes));