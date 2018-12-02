import 'package:flutter/material.dart';
import 'package:cookday/pages/recommend/detailed_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RecommendHorizontal extends StatefulWidget {
  final userUid;
  RecommendHorizontal({Key key, this.userUid}) : super(key : key);
  @override
  _RecommendHorizontalState createState() => _RecommendHorizontalState();
}

class _RecommendHorizontalState extends State<RecommendHorizontal> {
  Widget _buildRow(DocumentSnapshot item) {
    //가로로 되어있는 item들 하나씩 generate
    return InkWell(
        onTap: () {
          //클릭하면 디테일 페이지로 넘어간다 + animation 추가
          Navigator.of(context).push(new PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) =>
                  new DetailedInfo(uid: item['uid'], userUid: widget.userUid),
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) {
                return new SlideTransition(
                  position: new Tween<Offset>(
                    begin: const Offset(0.0, 1.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: new SlideTransition(
                    position: new Tween<Offset>(
                      begin: Offset.zero,
                      end: const Offset(0.0, 1.0),
                    ).animate(secondaryAnimation),
                    child: child,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 200)));
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => DetailedInfo(
          //               item: item,
          //             )));
        },
        child: ConstrainedBox(
          constraints: new BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          child: Card(
              child: Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Expanded(
                  flex: 5,
                  child: Image.network(item['imageURL'], fit: BoxFit.fitWidth)),
            ],
          )),
        ));
  }

  Widget _buildList(List<DocumentSnapshot> recipe) {
    return ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(recipe.length, (int index) {
          //item을 하나씩 가로로 정렬한다
          final item = recipe[index];
          return _buildRow(item);
        }));
  }

  @override
  Widget build(BuildContext context) {
    //가로로 정렬한 item들 generator
    return StreamBuilder(
        stream: Firestore.instance.collection('recipe').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          else {
            if (snapshot.data.documents != null) {
              final List<DocumentSnapshot> allRecipes = snapshot.data.documents;
              List<DocumentSnapshot> recipeForYou =
                  new List<DocumentSnapshot>();

              int num = 0;
              for (final i in allRecipes) {
                if (num < 5) {
                  recipeForYou.add(i);
                  num++;
                } else
                  break;
              }

              return _buildList(recipeForYou);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }
        });
  }

  
}
