import 'package:flutter/material.dart';
import 'package:cookday/pages/home.dart';

void main() {
  runApp(new MaterialApp(
    theme:
      ThemeData(
          primaryColor: Colors.redAccent, 
          accentColor: Colors.orangeAccent, 
          fontFamily: 'NotoSansCJKkr',
      ),
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
