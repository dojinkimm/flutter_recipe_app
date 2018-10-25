import 'package:flutter/material.dart';
import 'package:cookday/pages/home.dart';

class MyNavigator {
  static void goToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => Home()), ModalRoute.withName('/home'));
  }
}