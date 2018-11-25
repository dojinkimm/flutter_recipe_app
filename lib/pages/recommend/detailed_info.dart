import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailedInfo extends StatefulWidget {
  final uid;
  DetailedInfo({Key key, this.uid}) : super(key: key);
  @override
  _DetailedInfoState createState() => _DetailedInfoState();
}

class _DetailedInfoState extends State<DetailedInfo> {
  Widget _buildHeader(var recipeName, var subtitle, var cookTime) {
    //헤더 부분: 레시피 이름, 요리시간을 표시
    return Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              recipeName,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Row(children: <Widget>[
                Icon(
                  Icons.timelapse,
                  size: 25.0,
                ),
                SizedBox(width: 10.0),
                Text(
                  cookTime,
                  style: TextStyle(fontSize: 20.0),
                )
              ]),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  subtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 15.0),
                ))
          ],
        ));
  }

  Widget _buildIngredients(List ingredients) {
    //필요한 재료들 표시
    return Container(
        color: Colors.grey[200],
        padding: EdgeInsets.all(20.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
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
                        Text(ingredients[index]),
                        Divider(height: 10.0)
                      ],
                    ));
              }))
            ]));
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
                                fontSize: 18.0, fontWeight: FontWeight.w400, fontFamily: 'Hanna'),
                          )),
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                        child: Text(
                          steps[index],
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 15.0, fontFamily: 'Hanna'
                          ),
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
    return Scaffold(
        body: FutureBuilder(
            future: Firestore.instance
                .collection('recipe')
                .where('uid', isEqualTo: widget.uid)
                .getDocuments(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              else {
                final DocumentSnapshot recipe = snapshot.data.documents[0];

                return scrollView(recipe);
              }
            }));
  }

  Widget scrollView(DocumentSnapshot recipe) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.7,
              floating: true,
              flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child:
                          Image.network(recipe['imageURL'], fit: BoxFit.cover),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: FractionalOffset.center,
                            end: FractionalOffset.bottomCenter,
                            stops: [0.0, 0.85],
                            colors: [
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.5)
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                  ],
                ),
              )),
            ),
          ];
        },
        body: ListView(
          children: <Widget>[
            _buildHeader(recipe['recipeName'], recipe['subtitle'],
                recipe['cookTime']), //제목이랑 subtitle, 시간을 포함한 부분
            _buildIngredients(recipe['ingredients']), //재료들을 정리한 부분
            _buildSteps(
                recipe['steps'], recipe['stepPic']) //음식 만드는데 필요한 스텝들을 정리한 부분
          ],
        ));
  }
}
