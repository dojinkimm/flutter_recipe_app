import 'package:flutter/material.dart';
import 'package:cookday/pages/myref/floating_menu.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

import 'package:cookday/model/ingredients.dart';
import 'package:cookday/pages/myref/category.dart';

class MyRef extends StatefulWidget {
  final uid;
  MyRef({Key key, this.uid}) : super(key: key);
  @override
  _MyRefState createState() => _MyRefState();
}

class _MyRefState extends State<MyRef> with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool selected;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: totalList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: totalList.length,
        child: Scaffold(
          body: NestedScrollView(
            body: TabBarView(
              children: <Widget>[
                new Category(uid: widget.uid, category: "meat"),
                new Category(uid: widget.uid, category: "seafood"),
                new Category(uid: widget.uid, category: "fruit"),
                new Category(uid: widget.uid, category: "dairy"),
                new Category(uid: widget.uid, category: "sauce"),
                new Category(uid: widget.uid, category: "beverage"),
                new Category(uid: widget.uid, category: "other"),
                new Category(uid: widget.uid, category: "tools"),
              ],
            ),
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) =>
                    [_buildAppBar(context)],
          ),
          floatingActionButton: FloatingMenu(),
        ));
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: MediaQuery.of(context).size.height * 0.22,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.22,
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset('images/appbar.png', fit: BoxFit.fill),
                Container(
                  color: Colors.black.withOpacity(0.3),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 50.0),
                  child: Center(
                    child: Text(
                      "나만의 냉장고",
                      style: TextStyle(color: Colors.white, fontSize: 40.0),
                    ),
                  ),
                )
              ],
            )),
      ),
      bottom: TabBar(
        isScrollable: true,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.white,
        tabs: <Widget>[
          Tab(text: totalList[0].category, icon: Image.asset(totalList[0].url)),
          Tab(text: totalList[1].category, icon: Image.asset(totalList[1].url)),
          Tab(text: totalList[2].category, icon: Image.asset(totalList[2].url)),
          Tab(text: totalList[3].category, icon: Image.asset(totalList[3].url)),
          Tab(text: totalList[4].category, icon: Image.asset(totalList[4].url)),
          Tab(text: totalList[5].category, icon: Image.asset(totalList[5].url)),
          Tab(text: totalList[6].category, icon: Image.asset(totalList[6].url)),
          Tab(text: totalList[7].category, icon: Image.asset(totalList[7].url)),
        ],
        indicatorColor: Colors.yellow,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: new BubbleTabIndicator(
          indicatorHeight: 60.0,
          indicatorColor: Colors.white,
          tabBarIndicatorSize: TabBarIndicatorSize.tab,
        ),
      ),
    );
  }
}

// return DefaultTabController(
//     length: totalList.length,d
//     child: Scaffold(
//         appBar: AppBar(
//             elevation: 3.0,
//             automaticallyImplyLeading: false,
//             backgroundColor: Colors.white,
// title: new Text(
//   "마이 냉장고",
//   style: TextStyle(
//     fontSize: 40.0,
//     fontWeight: FontWeight.bold,
//     color: const Color(0xFFFF6347),
//   ),
// ),
//             iconTheme: IconThemeData(color: Colors.black54),
//             bottom: new TabBar(
//               isScrollable: true,
//               tabs: [
// Tab(
//     text: totalList[0].category,
//     icon: Image.asset(totalList[0].url)),
// Tab(
//     text: totalList[1].category,
//     icon: Image.asset(totalList[1].url)),
// Tab(
//     text: totalList[2].category,
//     icon: Image.asset(totalList[2].url)),
// Tab(
//     text: totalList[3].category,
//     icon: Image.asset(totalList[3].url)),
// Tab(
//     text: totalList[4].category,
//     icon: Image.asset(totalList[4].url)),
// Tab(
//     text: totalList[5].category,
//     icon: Image.asset(totalList[5].url)),
// Tab(
//     text: totalList[6].category,
//     icon: Image.asset(totalList[6].url)),
// Tab(
//     text: totalList[7].category,
//     icon: Image.asset(totalList[7].url)),
//               ],
//               indicatorSize: TabBarIndicatorSize.tab,
//               indicator: new BubbleTabIndicator(
//                 indicatorHeight: 60.0,
//                 indicatorColor: const Color(0xFFFF6347),
//                 tabBarIndicatorSize: TabBarIndicatorSize.tab,
//               ),
//             )),
//         body: TabBarView(controller: _tabController, children: _children),
//         floatingActionButton: FloatingMenu()));
