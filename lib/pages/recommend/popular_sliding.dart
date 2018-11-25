import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cookday/pages/recommend/detailed_info.dart';

class PopularSliding extends StatefulWidget {
  @override
  _PopularSlidingState createState() => _PopularSlidingState();
}

class _PopularSlidingState extends State<PopularSliding> {
  String _fontFamily = "Hanna";
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firestore.instance
            .collection('recipe')
            .orderBy('recommend', descending: true)
            .getDocuments(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          else {
            final List<DocumentSnapshot> allList = snapshot.data.documents;
            List<DocumentSnapshot> popularList = new List<DocumentSnapshot>();
            int num = 0;
            for (final d in allList) {
              if (num < 5) {
                popularList.add(d); //첫 5개만 save
                num++;
              } else
                break;
            }
            return slider(popularList);
          }
        });
  }

  Widget slider(List<DocumentSnapshot> lis) {
    return CarouselSlider(
      height: MediaQuery.of(context).size.height * 0.4,
      aspectRatio: 16 / 9,
      viewportFraction: 0.7,
      autoPlay: true,
      items: [
        indivItems(lis[0]['uid'], lis[0]['imageURL'], lis[0]['recipeName'],
            lis[0]['recommend'], lis[0]['cookTime']),
        indivItems(lis[1]['uid'], lis[1]['imageURL'], lis[1]['recipeName'],
            lis[1]['recommend'], lis[1]['cookTime']),
        indivItems(lis[2]['uid'], lis[2]['imageURL'], lis[2]['recipeName'],
            lis[2]['recommend'], lis[2]['cookTime']),
      ],
    );
  }

  Widget indivItems(var uid, var url, var title, var recommend, var cookTime) {
    return InkWell(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailedInfo(uid:uid)) );
        Navigator.of(context).push(new PageRouteBuilder(
            pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) =>
                new DetailedInfo(uid: uid),
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
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: <Widget>[
                  Image.network(
                    url,
                    fit: BoxFit.fill,
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.height * 0.4,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    padding: EdgeInsets.fromLTRB(20.0,
                        MediaQuery.of(context).size.height * 0.25, 20.0, 20.0),
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(top: 15.0),
                              child: Text(title,
                                  style: TextStyle(
                                      fontFamily: _fontFamily, fontSize: 18.0)),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.timelapse,
                                  color: Colors.grey[600],
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text("$cookTime 분",
                                    style: TextStyle(
                                        fontFamily: _fontFamily,
                                        fontSize: 15.0,
                                        color: Colors.grey[600])),
                                SizedBox(
                                  width: 20.0,
                                ),
                                Icon(
                                  Icons.thumb_up,
                                  color: Colors.grey[600],
                                  size: 20.0,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Text("${recommend.toString()}",
                                    style: TextStyle(
                                        fontFamily: _fontFamily,
                                        fontSize: 15.0,
                                        color: Colors.grey[600])),
                              ],
                            )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
