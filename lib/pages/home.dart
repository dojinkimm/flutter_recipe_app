import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cook Day"),
        automaticallyImplyLeading: false
      ),
      body: Center(),
      bottomNavigationBar: BottomNavigationBar(
        items:[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_to_home_screen),
            title: Text("Home")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart),
            title: Text("Home")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text("Home")
          ),
        ]
      ),
    );
  }
}