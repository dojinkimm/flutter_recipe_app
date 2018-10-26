import 'package:flutter/material.dart';
import 'package:cookday/pages/home.dart';
import 'package:cookday/pages/splashscreen.dart';

var routes = <String, WidgetBuilder>{
  "/home": (BuildContext context) => Home(),
  "/splash": (BuildContext context) => SplashScreen(),
};
void main() {
  runApp(new MaterialApp(
    theme:
      ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'NotoSansCJKkr',
      ),
    debugShowCheckedModeBanner: false,
    home: Home(),
    initialRoute: "/splash",
    routes: routes,
  ));
}

