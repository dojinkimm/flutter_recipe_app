import 'package:flutter/material.dart';
import 'package:cookday/pages/recommend/detailed_info.dart';

class RecommendHorizontal extends StatefulWidget {
  final trashList;
  RecommendHorizontal({Key key, this.trashList}) : super(key: key);
  @override
  _RecommendHorizontalState createState() => _RecommendHorizontalState();
}

class _RecommendHorizontalState extends State<RecommendHorizontal> {
  Widget _buildRow(var item) {
    //가로로 되어있는 item들 하나씩 generate
    return InkWell(
        onTap: () {
          //클릭하면 디테일 페이지로 넘어간다 + animation 추가
          Navigator.of(context).push(new PageRouteBuilder(
              pageBuilder: (BuildContext context, Animation<double> animation,
                      Animation<double> secondaryAnimation) =>
                  new DetailedInfo(uid: item),
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
              transitionDuration: const Duration(milliseconds: 500)));
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => DetailedInfo(
          //               item: item,
          //             )));
        },
        // child: new Container(
        //     decoration: new BoxDecoration(
        //         borderRadius: new BorderRadius.circular(10.0),
        //         boxShadow: [
        //           new BoxShadow(
        //               color: Colors.black.withAlpha(70),
        //               offset: const Offset(3.0, 10.0),
        //               blurRadius: 15.0)
        //         ]),
        //     height: MediaQuery.of(context).size.height * 0.5,
        //     width: MediaQuery.of(context).size.width * 0.85,
        //     child: new Column(children: <Widget>[
        //       new Hero(
        //         tag: item.id,
        //         child: Image.asset(item.url, fit: BoxFit.cover),
                    
                    
        //       ),
              
        //     ]))
        child:
        ConstrainedBox(
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
                child:
                Hero(
                    //이미지 부분에 hero를 적용해서 디테일 페이지로 넘어갈때 애니메이션이 적용되게 했다
                    tag: item.id,
                    child:
                    Image.asset(item.url, fit: BoxFit.fitWidth)),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Container(
              //     // padding:  EdgeInsets.fromLTRB(10.0, 20.0, 0.0, 0.0),
              //     child: Text(
              //       item.recipeName,
              //       style: TextStyle(
              //           color: Colors.black,
              //           fontSize: 15.0,
              //           fontWeight: FontWeight.bold),
              //     ),
              //   ),
              // ),

              // Container(
              //   padding: EdgeInsets.only(left: 10.0),
              //   child: Text(
              //     item.subTitle,
              //     style: TextStyle(
              //       color: Colors.grey,
              //       fontSize: 10.0,
              //     ),
              //   ),
              // ),
            ],
          )),
        )
        );
  }

  @override
  Widget build(BuildContext context) {
    //가로로 정렬한 item들 generator
    return ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(widget.trashList.length, (int index) {
          //item을 하나씩 가로로 정렬한다
          final item = widget.trashList[index];
          return _buildRow(item);
        }));
  }
}
