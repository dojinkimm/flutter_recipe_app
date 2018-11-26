import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:cookday/pages/myref/barcode.dart';

class FloatingMenu extends StatefulWidget {
  @override
  _FloatingMenuState createState() => _FloatingMenuState();
}

class _FloatingMenuState extends State<FloatingMenu> {
  ScrollController _scrollController;
  bool _dialVisible = true;

  initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        _setDialVisible(_scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });
  }

  _setDialVisible(bool value) {
    setState(() {
      _dialVisible = value;
    });
  }

  _renderSpeedDial() {
    return SpeedDial(
      child: Icon(Icons.add),
      // animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: _dialVisible,
      tooltip: '냉장고 안 재료 및 도구 추가히기',
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.camera_alt, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () => print('FIRST CHILD'),
          label: '사진 찍기',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
        ),
        SpeedDialChild(
          child: Icon(Icons.text_fields, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => print('SECOND CHILD'),
          label: '수기 작성',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
        ),
        SpeedDialChild(
          child: Icon(Icons.code, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Barcode()));
          },
          label: '바코드',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _renderSpeedDial();
  }
}
