import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:cookday/pages/myref/savedata.dart';
import 'package:cookday/model/ingredients.dart';

class FloatingMenu extends StatefulWidget {
  @override
  _FloatingMenuState createState() => _FloatingMenuState();
}

class _FloatingMenuState extends State<FloatingMenu> {
  ScrollController _scrollController;
  bool _dialVisible = true;
  final TextEditingController _controllerIngred = new TextEditingController();
  final TextEditingController _controllerQuantity = new TextEditingController();

  List<String> category;

  bool selected = false;

  @override
  initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        _setDialVisible(_scrollController.position.userScrollDirection ==
            ScrollDirection.forward);
      });

    category = []; //처음에 category 설정하는 부분 다 선택 안 된걸로 한다.
    reset();
  }

  @override
  void dispose() {
    super.dispose();
    reset();
    _controllerIngred.clear();
    _controllerQuantity.clear();
  }

  _setDialVisible(bool value) {
    setState(() {
      _dialVisible = value;
    });
  }

  Future<Null> updated(StateSetter updateState, var item) async {
    updateState(() {
      item.selected = !item.selected;
    });
  }

  Widget _buildRow(var item, BuildContext context, StateSetter state) {
    //가로로 되어있는 item들 하나씩 generate
    return InkWell(
        onTap: () {
          updated(state, item);
        },
        child: item.selected == true //선택된 것들은 따로 표시
            ? Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              item.url,
                              width: 50.0,
                              height: 50.0,
                            ),
                            Text(
                              item.category,
                              style: TextStyle(
                                  color: item.selected
                                      ? Colors.red
                                      : Colors.black),
                            )
                          ],
                        )),
                    Icon(
                      Icons.check,
                      color: Colors.red,
                    )
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      item.url,
                      width: 50.0,
                      height: 50.0,
                    ),
                    Text(
                      item.category,
                      style: TextStyle(
                          color: item.selected ? Colors.red : Colors.black),
                    )
                  ],
                )));
  }

  Widget _buildList(List ingredOther, BuildContext context, StateSetter state) {
    return Flex(
        mainAxisAlignment: MainAxisAlignment.center,
        direction: Axis.horizontal,
        children: List.generate(ingredOther.length, (int index) {
          //item을 하나씩 가로로 정렬한다
          final item = ingredOther[index];
          return _buildRow(item, context, state);
        }));
  }

  void reset() {
    for (int i = 0; i < ingredList.length; i++) ingredList[i].selected = false;
    for (int i = 0; i < otherList.length; i++) otherList[i].selected = false;
  }

  void _modalBottomSheetMenu() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, state) {
            return Container(
              height: 500.0,
              color: Colors.transparent,
              child: new Container(
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(10.0),
                          topRight: const Radius.circular(10.0))),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 30.0, bottom: 20.0),
                        child: Text(
                          "냉장고에 있는 재료와 양을 적어주세요",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              child: Card(
                                  elevation: 6.0,
                                  margin: const EdgeInsets.all(10.0),
                                  child: new Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: new TextField(
                                      decoration: InputDecoration(
                                        hintText: "ex. 등심"
                                      ),
                                      controller: _controllerIngred,
                                    ),
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Card(
                                  elevation: 6.0,
                                  margin: const EdgeInsets.all(10.0),
                                  child: new Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: new TextField(
                                      decoration: InputDecoration(
                                        hintText: "ex. 200g"
                                      ),
                                      controller: _controllerQuantity,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: Text("카테고리를 정해주세요",
                              style: TextStyle(fontSize: 20.0))),
                      Container(
                          margin: EdgeInsets.only(top: 20.0),
                          child: _buildList(ingredList, context, state)),
                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: _buildList(otherList, context, state),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    _controllerIngred.clear();
                                    _controllerQuantity.clear();
                                    reset();
                                  });
                                },
                                child: Text(
                                  "취소하기",
                                  style:
                                      TextStyle(color: Colors.grey),
                                ),
                              ),
                              RaisedButton(
                                  color: Colors.grey,
                                  child: Text(
                                    "저장하기",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    ingredList.forEach((item) {
                                      if (item.selected)
                                        category.add(item.documentID);
                                    });

                                    otherList.forEach((item) {
                                      if (item.selected)
                                        category.add(item.documentID);
                                    });

                                    if (category.length == 1 &&
                                        _controllerIngred.text != null && _controllerQuantity !=null) {
                                      saveData(context, category[0],
                                          _controllerIngred.text, _controllerQuantity.text);
                                      Navigator.pop(context);

                                      _controllerIngred.clear();
                                      _controllerQuantity.clear();
                                      reset();
                                    } else {
                                      print("하나만 선택해주세요");
                                      category = [];
                                      reset();
                                    }
                                  }),
                            ],
                          )),
                    ],
                  )),
            );
          });
        });
  }

  _renderSpeedDial() {
    return SpeedDial(
      elevation: 3.0,
      backgroundColor: Colors.white,
      child: Icon(Icons.add,color: Colors.black,),
      // animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      visible: _dialVisible,
      tooltip: '냉장고 안 재료 및 도구 추가히���',
      curve: Curves.bounceIn,
      children: [
        SpeedDialChild(
          child: Icon(Icons.camera_alt, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () => print('사진 찍어서 머신러닝'),
          label: '사진 찍기',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
        ),
        SpeedDialChild(
          child: Icon(Icons.text_fields, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => _modalBottomSheetMenu(), //수기로 작성하는 팝업창 뜸
          label: '수기 작성',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
        ),
        SpeedDialChild(
          child: Icon(Icons.code, color: Colors.white),
          backgroundColor: Colors.blue,
          onTap: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => Barcode()));
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
