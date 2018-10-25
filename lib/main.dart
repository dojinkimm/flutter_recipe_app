import 'package:flutter/material.dart';
import 'package:cookday/pages/home.dart';
import 'package:cookday/pages/splashscreen.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => Home(),
};
void main() {
  runApp(new MaterialApp(
    theme:
      ThemeData(
          primaryColor: Color(0xFF4B3082),
          primarySwatch: Colors.purple,
          fontFamily: 'NotoSansCJKkr',
      ),
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
    routes: routes,
  ));
}

