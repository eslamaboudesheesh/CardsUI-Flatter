import 'package:flutter/material.dart';

class MyNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  static void goToAuth(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/Myauthenticate");
  }

  static void goToAuthFaild(BuildContext context) {
    Navigator.pushNamed(context, "/faild");
  }
}