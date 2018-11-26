import 'package:flutter/material.dart';
import 'package:cookday/pages/profile/setting.dart';

class Profile extends StatefulWidget {
  final String uid;
  Profile({Key key, this.uid}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Column buildStatColumn(String label, int number) {
      return new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Text(
            number.toString(),
            style: new TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          new Container(
              margin: const EdgeInsets.only(top: 4.0),
              child: new Text(
                label,
                style: new TextStyle(
                    color: Colors.grey,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400),
              ))
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: new Text("Profile",
            style: new TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.settings,
              semanticLabel: 'settings',
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Setting()),
              );
            },
          ),
        ],
      ),
      body: new ListView(
        children: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(16.0),
            child: new Column(
              children: <Widget>[
                new Row(
                  children: <Widget>[
                    // new CircleAvatar(
                    //   radius: 40.0,
                    //   backgroundColor: Colors.grey,
                    //   backgroundImage: new NetworkImage("https://www.google.co.kr/url?sa=i&source=images&cd=&cad=rja&uact=8&ved=2ahUKEwjdnpvv6_DeAhWMebwKHX8BBy0QjRx6BAgBEAU&url=https%3A%2F%2Fwww.pexels.com%2Fsearch%2Fbeauty%2F&psig=AOvVaw2-b6HMIGFFTkg5aYsSQO4J&ust=1543279922515873"),
                    // ),
                    new Expanded(
                      flex: 1,
                      child: new Column(
                        children: <Widget>[
                          new Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              buildStatColumn("posts", 3),
                              buildStatColumn("followers", 4),
                              buildStatColumn("following", 5),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                new Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(top: 15.0),
                    child: new Text(
                      "email", //email
                      style: new TextStyle(fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
          new Divider(),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.camera_alt,
              semanticLabel: 'camera',
            ),
          ),
        ],
      ),
    );
  }
}
