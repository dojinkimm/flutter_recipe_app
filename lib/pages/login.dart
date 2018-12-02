import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:cookday/pages/home.dart';
import 'package:cookday/pages/mynavigator.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Future _signGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    assert(user.email != null);
    assert(user.displayName != null);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    print("signed in " + user.displayName);

    Firestore.instance.document('users/${user.uid}').get().then((docSnap) {
      if (docSnap.data == null) {
        _newUserSaveDB();
        MyNavigator.goToInitProfile(context, user.uid);
      } else {
        Firestore.instance.document('users/${user.uid}').updateData({
          'lastLoginDate': new DateTime.now(),
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      uid: user.uid,
                    )));
      }
    }).catchError((error) {
      print(error);
    });
  }

  Future _newUserSaveDB() async {
    FirebaseAuth.instance.currentUser().then((user) {
      Firestore.instance.collection('users').document(user.uid).setData({
        'displayName': user.displayName,
        'uid': user.uid,
        'photoURL': user.photoUrl,
        'email': user.email,
        'lastLoginDate': new DateTime.now(),
        'saved': [], //나의 레시피 저장용도
        'savedName': [],
        'savedURL': [],
      }).then((d) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Home(uid: user.uid)));
      }).catchError((e) => print(e));
    });
    //여기에서 저장된 데이터들을 DB로 올림
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
                    image: AssetImage('images/refrige.jpg'),
                    fit: BoxFit.cover)),
          ),
          Container(
            color: Colors.black.withOpacity(0.55),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Container(
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
                ),
                SizedBox(
                  height: 50.0,
                ),
                FlatButton(
                  child: Image.asset("images/glogin.png", width: 180.0),
                  onPressed: () => _signGoogle(),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
