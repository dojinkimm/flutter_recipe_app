import 'package:flutter/material.dart';

class DetailedInfo extends StatefulWidget {
  final item;
  DetailedInfo({Key key, this.item}) : super(key: key);
  @override
  _DetailedInfoState createState() => _DetailedInfoState();
}

class _DetailedInfoState extends State<DetailedInfo> {
  Widget _buildHeader() { //헤더 부분: 레시피 이름, 요리시간을 표시
    return Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              widget.item.recipeName,
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
                  widget.item.cookTime,
                  style: TextStyle(fontSize: 20.0),
                )
              ]),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  widget.item.subTitle,
                  style: TextStyle(color: Colors.grey, fontSize: 15.0),
                ))
          ],
        ));
  }

  Widget _buildIngredients() {//필요한 재료들 표시
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
                  children: new List.generate(widget.item.ingredients.length,
                      (index) {
                final ingredients = widget.item.ingredients[index];
                return Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(ingredients),
                        Divider(height: 10.0)
                      ],
                    ));
              }))
            ]));
  }

  Widget _buildSteps() {//요리 하기에 필요한 step들 표시
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
              children: List.generate(widget.item.steps.length, (index) {
            final steps = widget.item.steps[index];
            final stepPics = widget.item.stepPic[index];

            return Container(
                padding: EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 10.0),
                        child: Text(
                          "단계 ${index + 1}/${widget.item.steps.length}",
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.w400),
                        )),
                    Container(
                      child: Image.asset(
                        stepPics,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      child: Text(
                        steps,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    Divider(
                      height: 10.0,
                      color: Colors.grey[400],
                    )
                  ],
                ));
          }))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: true,
                  expandedHeight: MediaQuery.of(context).size.height * 0.7,
                  floating: true,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                      background: Hero(
                          tag: widget.item.id,
                          child: Container(
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: Image.asset(widget.item.url,
                                      fit: BoxFit.cover),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.bottomCenter,
                                        stops: [0.0, 0.85],
                                        colors: [
                                          Colors.black.withOpacity(0.1),
                                          Colors.black.withOpacity(0.4)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))),
                ),
              ];
            },
            body: ListView(
              children: <Widget>[
                _buildHeader(), //제목이랑 subtitle, 시간을 포함한 부분
                _buildIngredients(), //재료들을 정리한 부분
                _buildSteps() //음식 만드는데 필요한 스텝들을 정리한 부분
              ],
            )));
  }
}
