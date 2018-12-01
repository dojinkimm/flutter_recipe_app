import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookday/pages/recommend/detailed_info.dart';

class ResultSearch extends StatefulWidget {
  final category;
  final name;
  final userUid;
  ResultSearch({Key key, this.category, this.name, this.userUid})
      : super(key: key);
  @override
  _ResultSearchState createState() => _ResultSearchState();
}

class _ResultSearchState extends State<ResultSearch> {
  Widget _buildInfiniteList(DocumentSnapshot recipe) {
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailedInfo(uid:uid)) );
        Navigator.of(context).push(new PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                new DetailedInfo(uid: recipe['uid'], userUid: widget.userUid),
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
            transitionDuration: const Duration(milliseconds: 100)));
      },
      child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Image.network(
                recipe['imageURL'],
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              // Container(
              //   height: MediaQuery.of(context).size.height * 0.3,
              //   width: MediaQuery.of(context).size.width,
              //   child: DecoratedBox(
              //     decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         begin: FractionalOffset.center,
              //         end: FractionalOffset.bottomCenter,
              //         stops: [0.0, 0.85],
              //         colors: [
              //           Colors.black.withOpacity(0.0),
              //           Colors.black.withOpacity(0.6)
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                color: Colors.black.withOpacity(0.3),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    20.0, MediaQuery.of(context).size.height * 0.2, 20.0, 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 15.0),
                      child: Text(recipe['recipeName'],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(recipe['subtitle'],
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          Text("by ${recipe['author']}",
                              style: TextStyle(
                                color: Colors.white,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
    );
  }

  Widget _buildAppBar(BuildContext context, bool innerBoxIsScrolled) {
    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      child: SliverAppBar(
          pinned: true,
          forceElevated: innerBoxIsScrolled,
          expandedHeight: MediaQuery.of(context).size.height * 0.15,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.asset('images/suggest/${widget.category}.jpg',
                        fit: BoxFit.cover),
                    Container(
                      color: Colors.black.withOpacity(0.3),
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                )),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[_buildAppBar(context, innerBoxIsScrolled)];
      },
      body: FutureBuilder(
          future: Firestore.instance
              .collection('recipe')
              .where('category', isEqualTo: widget.category)
              .getDocuments(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            else {
              if (snapshot.data.documents != null) {
                List<DocumentSnapshot> doc = snapshot.data.documents;
                List<DocumentSnapshot> finalDoc = new List<DocumentSnapshot>();

                doc.forEach((d) {
                  finalDoc.add(d);
                });
                if (finalDoc.length != 0) {
                  return ListView.builder(
                    itemCount: doc.length,
                    itemBuilder: (context, int index) {
                      final DocumentSnapshot recipe = doc[index];

                      return _buildInfiniteList(recipe);
                    },
                  );
                } else {
                  return Center(
                      child: Text(
                    "등록된 레시피가 없습니다",
                    style: TextStyle(fontSize: 20.0),
                  ));
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }
          }),
    ));
  }
}
