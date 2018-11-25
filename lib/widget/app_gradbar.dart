import 'package:flutter/material.dart';

class AppGradBar extends StatelessWidget {
  final double height;

  const AppGradBar({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        // new Container(
        //   decoration: new BoxDecoration(
        //     color: const Color(0xFF83DCB7),
        //     // gradient: new LinearGradient(
        //     //   begin: Alignment.topCenter,
        //     //   end: Alignment.bottomCenter,
        //     //   colors: [const Color(0xAAF0D1), const Color(0xFFE64C85)],
        //     // ),
        //   ),
        //   height: height,
        // ),
        new AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: new Text(
            "CookDay",
            style: TextStyle(fontFamily: 'Dancing', fontSize: 40.0,fontWeight: FontWeight.bold, color: const Color(0xFFFF6347),),
          ),
        ),
      ],
    );
  }
}