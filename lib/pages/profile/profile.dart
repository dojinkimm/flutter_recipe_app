import 'package:flutter/material.dart';
import 'package:cookday/pages/profile/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Profile extends StatefulWidget {
  final String uid;
  Profile({Key key, this.uid}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    // Column buildStatColumn(String label, int number) {
    //   return new Column(
    //     mainAxisSize: MainAxisSize.min,
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[
    //       new Text(
    //         number.toString(),
    //         style: new TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
    //       ),
    //       new Container(
    //           margin: const EdgeInsets.only(top: 4.0),
    //           child: new Text(
    //             label,
    //             style: new TextStyle(
    //                 color: Colors.grey,
    //                 fontSize: 15.0,
    //                 fontWeight: FontWeight.w400),
    //           ))
    //     ],
    //   );
    // }

    Widget _buildProfile(DocumentSnapshot user) {
      return Stack(
        children: <Widget>[
          ClipPath(
            child: Container(
              color: Colors.black.withOpacity(0.7),
            ),
            clipper: getClipper(),
          ),
          Positioned(
            width: 350.0,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Column(
              children: <Widget>[
                Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage(user['photoURL']),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.black)
                      ]),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  user['displayName'],
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Divider()
              ],
            ),
          )
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: new Text("프로필",
              style: new TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold)),
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
        body: FutureBuilder(
            future: Firestore.instance
                .collection('users')
                .where('uid', isEqualTo: widget.uid)
                .getDocuments(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              else {
                if (snapshot.data.documents != null) {
                  final DocumentSnapshot user = snapshot.data.documents[0];

                  return _buildProfile(user);
                }
              }
            }));
  }
}

class getClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height / 2.7);
    path.lineTo(size.width + 150, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
