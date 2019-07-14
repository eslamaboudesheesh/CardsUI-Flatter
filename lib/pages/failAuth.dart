import 'dart:async';

import 'package:flutter/material.dart';
import '../router/my_navigator.dart';

class FailAuth extends StatefulWidget {
  @override
  _FailAuthState createState() => _FailAuthState();
}

class _FailAuthState extends State<FailAuth> {
  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            actions: <Widget>[],
            title: Padding(
              padding: EdgeInsets.only(top: 0, bottom: 0),
              child: Image.asset("assets/logo.png", width: 62.0, height: 43.0),
            )),
            body:  Center(child: Text("faild to auth "),),
            );
  
  }
}