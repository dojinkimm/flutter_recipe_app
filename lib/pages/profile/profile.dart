import 'package:flutter/material.dart';
import 'package:cookday/pages/profile/setting.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookday/pages/recommend/detailed_info.dart';

class Profile extends StatefulWidget {
  final String uid;
  Profile({Key key, this.uid}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget _buildProfile(DocumentSnapshot user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Stack(
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
                    height: 30.0,
                  ),
                  Text(
                    user['displayName'],
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Divider(),
                ],
              ),
            )
          ],
        )),
        Container(
          margin: EdgeInsets.only(left: 20.0, top: 10.0),
          child: Text("저장된 레시피들", style: TextStyle(color: Colors.grey, fontSize: 17.0)),
        ),
        Expanded(
          child: _buildRecipe(user),
        )
      ],
    );
  }

  Widget _buildGridCards(BuildContext context, String recipeUid,
      String recipeName, String recipeURL) {
    //Card형식의 디테일한 코드
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                DetailedInfo(uid: recipeUid, userUid: widget.uid)));
      }, //테마별 리스트 나오게 구현해야함
      child: Card(
        child: Stack(
          children: <Widget>[
            Container(
              child: Image.network(recipeURL,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover),
            ),
            Container(
              color: Colors.black.withOpacity(0.3),
            ),
            Center(
              child: Text(recipeName,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18.0)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRecipe(DocumentSnapshot user) {
    return GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 5.0, crossAxisSpacing: 5.0),
        padding: const EdgeInsets.all(15.0),
        itemCount: user['saved'].length,
        itemBuilder: (_, int index) {
          final recipeUid = user['saved'][index];
          final recipeName = user['savedName'][index];
          final recipeURL = user['savedURL'][index];
          return Container(
            child: _buildGridCards(context, recipeUid, recipeName, recipeURL),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
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
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .where('uid', isEqualTo: widget.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
    path.lineTo(0.0, size.height / 1.4);
    path.lineTo(size.width + 150, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
