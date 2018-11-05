import 'package:flutter/material.dart';
import 'package:cookday/pages/profile/setting.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          icon: Icon(Icons.settings),
          onPressed:(){
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) =>
                Setting()));
          }
        )
      ),
    );
  }
}