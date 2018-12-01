import 'package:flutter/material.dart';

import 'package:cookday/pages/recommend/recommend.dart';
import 'package:cookday/pages/search/search.dart';
import 'package:cookday/pages/myref/myref.dart';
import 'package:cookday/pages/profile/profile.dart';

class Home extends StatefulWidget {
  final uid;
  Home({Key key, this.uid}) : super(key:key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex;
  List<Color> _colorOfApp = [
    Colors.grey,
    Colors.grey,
    Colors.grey,
    Colors.grey,
  ];
  //color of navigation item text & icon

  final Color _colorOfAppBack =
      Colors.white; //backgroundcolor of navigation bar
  final double _fontSize = 15.0;

  @override
  void initState() {
    super.initState();
    print("HOME에서 ${widget.uid}");
    _currentIndex = 0;
    _colorOfApp[_currentIndex] =  Colors.black; //홈화면 아이콘과 글자 색깔 보라로 변경
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      //각각 page들
      new Recommend(),
      new Search(),
      new MyRef(uid: widget.uid),
      new Profile(uid: widget.uid)
    ];

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _currentIndex = index; //아이템 누르면 index지정한다
              _colorOfApp[_currentIndex] =   Colors.black; //현재 누른 아이콘 색깔 변경
              for (int i = 0; i < _colorOfApp.length; i++) {
                //나머지 아이콘들 색깔 원위치
                if (i == _currentIndex) continue;
                _colorOfApp[i] = Colors.grey;
              }
            });
          },
          currentIndex: _currentIndex, //현재 몇번쨰 index에 있는지 알려준다
          items: [
            BottomNavigationBarItem(
                //안눌렸을 떄는 grey 색이지만, 눌렸을 때는 보라색이 된다
                icon: Icon(Icons.restaurant_menu, color: _colorOfApp[0]),
                title: Text("홈",
                    style:
                        TextStyle(color: _colorOfApp[0], fontSize: _fontSize)),
                backgroundColor: _colorOfAppBack),
            BottomNavigationBarItem(
                icon: Icon(Icons.search, color: _colorOfApp[1]),
                title: Text("찾기",
                    style:
                        TextStyle(color: _colorOfApp[1], fontSize: _fontSize)),
                backgroundColor: _colorOfAppBack),
            BottomNavigationBarItem(
                icon: Icon(Icons.kitchen, color: _colorOfApp[2]),
                title: Text("나만의 냉장고",
                    style:
                        TextStyle(color: _colorOfApp[2], fontSize: _fontSize)),
                backgroundColor: _colorOfAppBack),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, color: _colorOfApp[3]),
                title: Text("프로필",
                    style:
                        TextStyle(color: _colorOfApp[3], fontSize: _fontSize)),
                backgroundColor: _colorOfAppBack),
          ]),
    );
  }
}
