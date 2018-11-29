import 'package:flutter/material.dart';
import 'package:cookday/pages/home.dart';

class InitProfile extends StatefulWidget {
  final uid;
  InitProfile({Key key, this.uid}) : super(key : key);
  @override
  _InitProfileState createState() => _InitProfileState();
}

class _InitProfileState extends State<InitProfile> {
  String _eatTimes = "";
  List<Color> _buttonColor = [
    Colors.grey[200],
    Colors.grey[200],
    Colors.grey[200],
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 100.0),
                child: Image.asset("images/pancake.jpeg"),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text(
                    "얼마나 자주 요리 하나요?",
                    style: TextStyle(fontFamily: "Hanna", fontSize: 30.0),
                  )),
              Container(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: _buttonColor[0],
                    child: Text("주0~2회"),
                    onPressed: () {
                      setState(() {
                        _eatTimes = "주0~2회";
                        _buttonColor[0] = const Color(0xFFFF6347);
                        _buttonColor[1] = Colors.grey[200];
                        _buttonColor[2] = Colors.grey[200];
                      });
                    },
                  ),
                  RaisedButton(
                    color: _buttonColor[1],
                    child: Text("주3~5회"),
                    onPressed: () {
                      setState(() {
                        _eatTimes = "주3~5회";
                        _buttonColor[1] = const Color(0xFFFF6347);
                        _buttonColor[0] = Colors.grey[200];
                        _buttonColor[2] = Colors.grey[200];
                      });
                    },
                  ),
                  RaisedButton(
                    color: _buttonColor[2],
                    child: Text("주5회 이상"),
                    onPressed: () {
                      setState(() {
                        _eatTimes = "주5회 이상";
                        _buttonColor[2] = const Color(0xFFFF6347);
                        _buttonColor[0] = Colors.grey[200];
                        _buttonColor[1] = Colors.grey[200];
                      });
                    },
                  )
                ],
              )),
              SizedBox(
                height: 50.0,
              ),
              RaisedButton(
                color: Colors.grey[200],
                child: Text(">"),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (BuildContext context) => EatingType()));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Home(uid: widget.uid,)));
                },
              )
            ],
          )),
    );
  }
}

class EatingType extends StatefulWidget {
  @override
  _EatingTypeState createState() => _EatingTypeState();
}

class _EatingTypeState extends State<EatingType> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(child: Text("얼마나 자주 요리 하나요?")),
          Container(child: Text("주 2회")),
          RaisedButton(
            child: Text(">"),
            onPressed: () {},
          )
        ],
      )),
    );
  }
}
