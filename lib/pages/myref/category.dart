import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cookday/pages/myref/deleted.dart';

class Category extends StatefulWidget {
  final uid;
  final category;
  Category({Key key, this.uid, this.category}) : super(key: key);
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  Widget _buildGridCards(BuildContext context, String foodDetail,
      String foodQuantity, String category) {
    return Container(
        child: InkWell(
      onLongPress: () {
        delete(context, foodDetail, foodQuantity,category);
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Image.asset(
                'images/ingredients/$category.png', width: 60.0,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    foodDetail,
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    foodQuantity,
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  Widget _buildGrid(List item, List quantity, String category) {
    return GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.5),
        padding: const EdgeInsets.all(20.0),
        itemCount: item.length,
        itemBuilder: (_, int index) {
          final String foodDetail = item[index];
          final String foodQuantity = quantity[index];
          return _buildGridCards(context, foodDetail, foodQuantity, category);
        });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('users')
            .document(widget.uid)
            .collection('ingredients')
            .where('uid', isEqualTo: widget.category)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.data.documents != null) {
              final DocumentSnapshot document = snapshot.data.documents[0];
              if (document['item'] == null || document['item'][0] == "") {
                return Center(
                  child: Text(
                    "재료를 추가해주세요",
                    style: TextStyle(fontSize: 20.0),
                  ),
                );
              } else {
                return Container(
                  child: _buildGrid(
                      document['item'], document['quantity'], widget.category),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        });
  }
}
