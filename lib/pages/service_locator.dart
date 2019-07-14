
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:startagain/router/my_navigator.dart';



class Myauthenticate extends StatefulWidget {
  @override
  _MyauthenticateState createState() => _MyauthenticateState();
}

class _MyauthenticateState extends State<Myauthenticate> {
  final LocalAuthentication auth = LocalAuthentication();

  String _authorized = 'Not Authorized';




  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _authorized = authenticated ? 'Authorized' : 'Not Authorized';
    });

    if(authenticated) {
      MyNavigator.goToHome(context);
    }
    else {
      MyNavigator.goToAuthFaild(context);
    }
  }
    
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
            body:   Center(
      child: Column(
        children: <Widget>[ 
                RaisedButton(
                  child: const Text('Authenticate'),
                  onPressed: _authenticate,
                )],
      ),
    ),
            );
    
    
   
  }
}