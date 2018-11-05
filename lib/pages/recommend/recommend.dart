import 'package:flutter/material.dart';
import 'package:cookday/model/trash.dart';
import 'package:cookday/model/trash1.dart';
import 'package:cookday/pages/recommend/top_with_dots.dart';
import 'package:cookday/pages/recommend/recommend_horizontal.dart';

class Recommend extends StatefulWidget {
  @override
  _RecommendState createState() => _RecommendState();
}

class _RecommendState extends State<Recommend> {
  // Widget _buildList(BuildContext context, var item) {
  //   return Container(
  //     width: MediaQuery.of(context).size.width,
  //     height: MediaQuery.of(context).size.height * 0.3,
  //     child: Stack(
  //       children: <Widget>[
  //         Container(
  //           width: MediaQuery.of(context).size.width,
  //           height: MediaQuery.of(context).size.height * 0.3,
  //           child: Image.asset(item.url, fit: BoxFit.cover),
  //         ),
  //         Container(
  //           width: MediaQuery.of(context).size.width,
  //           height: MediaQuery.of(context).size.height * 0.3,
  //           child: DecoratedBox(
  //             decoration: BoxDecoration(
  //               gradient: LinearGradient(
  //                 begin: FractionalOffset.topCenter,
  //                 end: FractionalOffset.bottomCenter,
  //                 stops: [0.0, 0.85],
  //                 colors: [
  //                   Colors.black.withOpacity(0.1),
  //                   Colors.black.withOpacity(0.6)
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         Container(
  //           alignment: Alignment.bottomLeft,
  //           child: Text(
  //             item.recipeName,
  //             style: TextStyle(color: Colors.white, fontSize: 20.0),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Container(
          height:
              MediaQuery.of(context).size.height * 0.5, //전체 높이의 50%를 차지하게 한다
          child: TopWithDots(
              trashList: trashList), //맨 위에 dot indicator와 함께 있는 그림들을 generate
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15.0, 20.0, 0.0, 0.0),
          child: Text("신 메뉴", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)
        ),
        Container(
          padding: EdgeInsets.only(left: 9.0, right: 9.0, top: 9.0),
          height:
              MediaQuery.of(context).size.height * 0.3, //전체 높이의 30%를 차지하게 한다
          child: RecommendHorizontal(
            //가로로 scroll 가능한 item들 generate
            trashList: trashList,
          ),
        ),
         Container(
          padding: EdgeInsets.fromLTRB(15.0, 20.0, 0.0, 0.0),
          child: Text("SNS 핫한 음식들", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)
        ),
        Container(
          padding: EdgeInsets.only(left: 9.0, right: 9.0, top: 9.0),
          height:
              MediaQuery.of(context).size.height * 0.3, //전체 높이의 30%를 차지하게 한다
          child: RecommendHorizontal(
            //가로로 scroll 가능한 item들 generate
            trashList: trashList1,
          ),
        ),
        
        // Container(
        //   padding: EdgeInsets.only(left: 9.0, right: 9.0, top: 9.0),
        //   height:
        //       MediaQuery.of(context).size.height * 0.3, //전체 높이의 30%를 차지하게 한다
        //   child: ListView.builder(
        //       itemCount: trashList.length,
        //       itemBuilder: (BuildContext context, int index) {
        //         final item = trashList[index];
        //         return _buildList(context, item);
        //       }),
        // ),
      ],
    ));
  }
}
