import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

import 'package:cookday/pages/login.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

class Setting extends StatefulWidget {
  @override
  SettingState createState() => new SettingState();
}

class SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: const Text('설정'),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.event_note),
                title: Text("공지사항"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Notice()));
                },
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: Text("버전정보"),
                subtitle: Text("1.0.0"),
              ),
              ListTile(
                leading: Icon(Icons.accessibility_new),
                title: Text("개인설정"),
                onTap: () {
                  print("개인설정페이지");
                },
              ),
              ListTile(
                leading: Icon(Icons.notifications_active),
                title: Text("알림설정"),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Notification()));
                },
              ),
              Divider(
                height: 30.0,
                color: Colors.grey,
              ),
              ListTile(
                leading: Icon(Icons.assignment),
                title: Text("서비스 이용약관"),
                onTap: () {
                  print("이용약관페이지");
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text("고객센터"),
                onTap: () {
                  print("고객센터페이지");
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("로그아웃"),
                onTap: () =>_logout(),
              ),
            ],
          ),
        ));
  }

    Future _logout() async {
    print("logout");
    await _auth.signOut();
    await _googleSignIn.signOut().whenComplete(() {
    
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Login()),
          ModalRoute.withName('/login'));
    });
  }
}

class Notification extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NotificationState();
}

class NotificationState extends State<Notification> {
  bool _notice = true;
  bool _event = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("알림설정"),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text("공지 알림"),
              trailing: Switch(
                  value: _notice,
                  onChanged: (bool value) {
                    setState(() {
                      _notice = value;
                    });
                  }),
            ),
            ListTile(
              title: Text("이벤트 알림"),
              trailing: Switch(
                  value: _event,
                  onChanged: (bool value) {
                    setState(() {
                      _event = value;
                    });
                  }),
            ),
          ],
        ),
      ),
    );
  }

}

class Notice extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NoticeState();
}

class NoticeState extends State<Notice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("공지사항"),
      ),
      body: Center(),
    );
  }
}

