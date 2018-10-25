import 'package:flutter/material.dart';

class Recipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cookday")
      ),
      body: Container(
        child: Center(
          child: Icon(Icons.add)
        )
      ),
    );
  }
}