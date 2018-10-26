import 'package:flutter/material.dart';

import 'package:cookday/pages/recommend/recommend.dart';
import 'package:cookday/pages/search/search.dart';
import 'package:cookday/pages/myref/myref.dart';
import 'package:cookday/pages/profile/profile.dart';
import 'package:cookday/pages/myrecipe/myrecipe.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex;
  List<Color> _colorOfApp = [
    Colors.black54,
    Colors.black54,
    Colors.black54,
    Colors.black54,
    Colors.black54
  ];
  //color of navigation item text & icon

  final Color _colorOfAppBack =
      Colors.white; //backgroundcolor of navigation bar
  final double _fontSize = 15.0;

  @override
  void initState() {
    super.initState();
    _currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      new Recommend(),
      new Search(),
      new MyRecipe(),
      new MyRef(),
      new Profile()
    ];

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _currentIndex = index; //아이템 누르면 index지정한다
              _colorOfApp[_currentIndex] = Color(0xFF4B3082); //현재 누른 아이콘 색깔 변경
              for (int i = 0; i < _colorOfApp.length; i++) {
                //나머지 아이콘들 색깔 원위치
                if (i == _currentIndex) continue;
                _colorOfApp[i] = Colors.black54;
              }
            });
          },
          currentIndex: _currentIndex,
          items: [
            BottomNavigationBarItem(
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
                icon: Icon(Icons.book, color: _colorOfApp[2]),
                title: Text("내 레시피",
                    style:
                        TextStyle(color: _colorOfApp[2], fontSize: _fontSize)),
                backgroundColor: _colorOfAppBack),
            BottomNavigationBarItem(
                icon: Icon(Icons.kitchen, color: _colorOfApp[3]),
                title: Text("마이냉장고",
                    style:
                        TextStyle(color: _colorOfApp[3], fontSize: _fontSize)),
                backgroundColor: _colorOfAppBack),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle, color: _colorOfApp[4]),
                title: Text("프로필",
                    style:
                        TextStyle(color: _colorOfApp[4], fontSize: _fontSize)),
                backgroundColor: _colorOfAppBack),
          ]),
    );
  }
}
