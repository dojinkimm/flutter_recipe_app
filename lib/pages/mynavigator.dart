import 'package:flutter/material.dart';
import 'package:cookday/pages/home.dart';
import 'package:cookday/pages/login.dart';
import 'package:cookday/pages/initprofile.dart';
import 'package:cookday/pages/splashscreen.dart';

class MyNavigator {
  static void goToHome(BuildContext context, String uid) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => Home(uid:uid)), ModalRoute.withName('/home'));
  }
  static void goToLogin(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => Login()), ModalRoute.withName('/login'));
  }
   static void goToInitProfile(BuildContext context, String uid) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => InitProfile(uid: uid)), ModalRoute.withName('/profile'));
  }
  static void goToSplash(BuildContext context) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context) => SplashScreen()), ModalRoute.withName('/splash'));
  }
}