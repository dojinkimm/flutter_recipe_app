import 'package:flutter/material.dart';
import 'package:cookday/pages/home.dart';
import 'package:cookday/pages/splashscreen.dart';
import 'package:cookday/pages/login.dart';
import 'package:cookday/pages/initprofile.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => Home(),
  '/login': (BuildContext context) => Login(),
  '/profile': (BuildContext context) => InitProfile(),
  "/splash": (BuildContext context) => SplashScreen(),
};
void main() {
  runApp(new MaterialApp(
    theme:
      ThemeData(
          primaryColor: Colors.white,
          primarySwatch: Colors.deepPurple,
          fontFamily: 'NotoSansCJKkr',
      ),
    debugShowCheckedModeBanner: false,
    home: Home(),
    initialRoute: "/splash",
    routes: routes,
  ));
}
