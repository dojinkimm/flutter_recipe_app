import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cookday/pages/recommend/add_delete.dart';

class DetailedInfo extends StatefulWidget {
  final uid;
  final userUid;
  DetailedInfo({Key key, this.uid, this.userUid}) : super(key: key);
  @override
  _DetailedInfoState createState() => _DetailedInfoState();
}

class _DetailedInfoState extends State<DetailedInfo> {
  Widget scrollView(DocumentSnapshot recipe) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              //밑으로 scroll하면 appbar가 사라지는 기능
              leading: IconButton(
                color: Colors.white,
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () => Navigator.pop(context),
              ),
              automaticallyImplyLeading: true,
              expandedHeight: MediaQuery.of(context).size.height,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      child:
                          Image.network(recipe['imageURL'], fit: BoxFit.cover),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: FractionalOffset.center,
                            end: FractionalOffset.bottomCenter,
                            stops: [0.0, 0.85],
                            colors: [
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.55)
                            ],
                          ),
                        ),
                      ),
                    ),
                    _buildHeader(
                        recipe['recipeName'],
                        recipe['subtitle'],
                        recipe['cookTime'],
                        recipe['uid'],
                        recipe['saved']), //제목이랑 subtitle, 시간을 포함한 부분
                  ],
                ),
              )),
            ),
          ];
        },
        body: Container(
          color: Colors.grey[200],
          child: ListView(
            children: <Widget>[
              _buildIngredients(recipe['ingredients']), //재료들을 정리한 부분
              _buildSteps(
                  recipe['steps'], recipe['stepPic']) //음식 만드는데 필요한 스텝들을 정리한 부분
            ],
          ),
        ));
  }

  Widget _buildHeader(
      var recipeName, var subtitle, var cookTime, var recipeUid, var uidSaved) {
    //헤더 부분: 레시피 이름, 요리시간을 표시
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
          child: Row(children: <Widget>[
            Icon(
              Icons.timelapse,
              size: 15.0,
              color: Colors.white,
            ),
            SizedBox(width: 10.0),
            Text(
              "$cookTime\분",
              style: TextStyle(fontSize: 15.0, color: Colors.white),
            )
          ]),
        ),
        Container(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 10.0),
            child: Text(
              subtitle,
              style: TextStyle(color: Colors.white, fontSize: 25.0),
            )),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  recipeName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                padding: EdgeInsets.only(right: 30.0),
                icon: Icon(
                  uidSaved.contains(widget.userUid)
                      ? Icons.bookmark
                      : Icons.bookmark_border,
                  size: 30.0,
                  color: Colors.yellow,
                ),
                onPressed: () async {
                  if (uidSaved
                      .contains(widget.userUid)) //저장을 했으면 DB에 저장, 지우면 지우기
                    deleteData(recipeUid);
                  else
                    saveData(recipeUid);
                },
              )
            ],
          ),
        ),
        Container(
            padding: EdgeInsets.only(bottom: 40.0),
            child: Center(
              child: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
                size: 50.0,
              ),
            ))
      ],
    ));
  }

  Widget _buildIngredients(List ingredients) {
    //필요한 재료들 표시
    return Container(
        padding: EdgeInsets.all(10.0),
        child: Card(
            child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text("필요한 재료들",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold)),
                ),
                Column(
                    children: new List.generate(ingredients.length, (index) {
                  return Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            ingredients[index],
                            style: TextStyle(fontSize: 16.0),
                          ),
                          Divider(height: 10.0)
                        ],
                      ));
                }))
              ]),
        )));
  }

  Widget _buildSteps(List steps, List stepPics) {
    //요리 하기에 필요한 step들 표시
    return Container(
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
            child: Text("Steps",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold)),
          ),
          Column(
              children: List.generate(steps.length, (index) {
            return Container(
                padding: EdgeInsets.all(10.0),
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Image.network(
                          stepPics[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Container(
                          padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 10.0),
                          child: Text(
                            "단계 ${index + 1}/${steps.length}",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        child: Text(
                          steps[index],
                          softWrap: true,
                          style: TextStyle(fontSize: 15.0),
                        ),
                      ),
                    ],
                  ),
                ));
          }))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Firestore에서 데이터를 불러온다
    return Scaffold(
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('recipe')
                .where('uid', isEqualTo: widget.uid)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              else {
                final DocumentSnapshot recipe = snapshot.data.documents[0];

                return scrollView(recipe); //scroll할 수 있는 view를 만든다
              }
            }));
  }
}
