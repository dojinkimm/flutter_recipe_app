import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:dots_indicator/dots_indicator.dart';

class TopWithDots extends StatefulWidget {
  final trashList;
  TopWithDots({Key key, this.trashList}) : super(key: key);

  @override
  State createState() => new TopWithDotsState();
}

class TopWithDotsState extends State<TopWithDots> {
  final _controller = new PageController(); //page view를 사용했다
  int _currentPage = 0;
  List<Widget> _pages = <Widget>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < widget.trashList.length; i++) {
      _pages.add(Container(child: Image.asset(widget.trashList[i].url, fit: BoxFit.cover,)));
    } //전달 받은 리스트에 있는 그림들을 _pages에 담는다
  }

  Widget _buildPageItem(BuildContext context, int index) { //page그림들을 display하게 한다
    return new Page(page: _pages[index], idx: index);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child: new Stack(
          children: <Widget>[
            new PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemCount: _pages.length,
              onPageChanged: (int index) {
                setState(() {
                  _currentPage = index; //페이지의 index를 변경해준다
                });
              },
              itemBuilder: (BuildContext context, int index) {
                return _buildPageItem(context, index % _pages.length);
              },
            ),
            Positioned( //그림 맨 밑에 dot indicator가 오게 한다
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                color: Colors.grey[800].withOpacity(0.5),
                padding: const EdgeInsets.all(20.0),
                child: new Center(
                    child: DotsIndicator(
                        numberOfDot: _pages.length,
                        position: _currentPage,
                        dotColor: Colors.black87,
                        dotActiveColor: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Page extends StatelessWidget {
  final page;
  final idx;

  Page({
    @required this.page,
    @required this.idx,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Card(
        child: new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            this.page,
            new Material(
              type: MaterialType.transparency,
            ),
          ],
        ),
      ),
    );
  }
}
