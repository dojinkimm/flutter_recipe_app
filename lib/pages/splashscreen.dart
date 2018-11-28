import 'package:cookday/pages/mynavigator.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _uid = "";

  void navigationPage() {
    MyNavigator.goToHome(context, _uid);
    // Navigator.pop(context, _uid);
    print("UID in splash $_uid");
  }

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.currentUser().then((user) {
      if (user == null)
        MyNavigator.goToLogin(context);
      else {
        Firestore.instance.document('users/${user.uid}').get().then((docSnap) {
          if (docSnap.data == null) {
            MyNavigator.goToInitProfile(context, user.uid);
          } else {
            setState(() {
              _uid = docSnap.data['uid'];
            });
            Timer(Duration(seconds: 2), navigationPage);

            // update the last Login Date when signed user start app.
            Firestore.instance.document('users/${user.uid}').updateData({
              'lastLoginDate': new DateTime.now(),
            });
          }
        }).catchError((error) {
          print("[SplashScreen] Firestore.instance.document().get()");
          print(error);
        });
      }
    }).catchError((error) {
      print("[SplashScreen] FirebaseAuth.instance.currentUser()");
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('images/cooksplash.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            height: MediaQuery.of(context).size.height * 0.4,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: FractionalOffset.center,
                  end: FractionalOffset.bottomCenter,
                  stops: [0.0, 0.85],
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.5)
                  ],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 50.0,
                        child: Icon(
                          Icons.restaurant_menu,
                          color: const Color(0xFFFF6347),
                          size: 50.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10.0),
                      ),
                      Text(
                        "CookDay",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Dancing',
                            fontSize: 40.0,
                            color: const Color(0xFFFF6347)),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "집에 있는 재료로 음식을 만들어봐요",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      fontFamily: "Hanna",
                      color: Colors.white),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
