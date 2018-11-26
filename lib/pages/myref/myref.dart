import 'package:flutter/material.dart';
import 'package:cookday/pages/myref/floating_menu.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Buttons extends StatefulWidget {
  final Icon icon;
  final Text name;
  Buttons(
      {Key key,
      this.icon = const Icon(Icons.border_outer),
      @required this.name})
      : super(key: key);

  @override
  _ButtonsState createState() => _ButtonsState(name: name, icon: icon);
}

class _ButtonsState extends State<Buttons> {
  final Icon icon;
  final Text name;

  _ButtonsState({Key key, @required this.icon, @required this.name});

  bool choice = false;

  void _choice() {
    setState(() {
      if (choice) {
        choice = false;
      } else {
        choice = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black87),
          borderRadius: BorderRadius.circular(5.0),
          color: (choice ? Colors.grey : Colors.white70),
        ),
        child: ListTile(
          title: name,
          trailing: icon,
          onTap: () => _choice(),
        ),
      ),
    );
  }
}

class MyRef extends StatelessWidget {
  /*
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot> (
      stream: Firestore.instance.collection('Ingredient').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {

    Item item;

    return MaterialApp(
        home: DefaultTabController(
            length: choices.length,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: Colors.black54),
                  leading: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {}
                  ),
                  title: Row(
                    children: <Widget>[
                      Text(
                        "Cook Day",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54
                        ),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.settings),
                        onPressed: () {}
                    ),
                  ],
                  bottom: TabBar(
                    labelColor: Color(0xFF4B3082),
                    indicatorColor: Color(0xFF4B3082),
                    unselectedLabelColor: Colors.grey,
                    isScrollable: true,
                    tabs: snapshot.map((DocumentSnapshot document) {
                      item = Item.fromSnapshot(document);

                      return Tab(
                        text: item.category,
                      );
                    }).toList(),
                  ),
                ),
                /*
                body: TabBarView(
                  children: snapshot.map((DocumentSnapshot document) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                      child: Buttons(name: document['item'].toList,),
                    );
                  }).toList(),
                ),
                */
            )
        )
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: choices.length,
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              title: new Text(
                "CookDay",
                style: TextStyle(
                  fontFamily: 'Dancing',
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFFFF6347),
                ),
              ),
              iconTheme: IconThemeData(color: Colors.black54),
              bottom: TabBar(
                labelColor: Color(0xFF4B3082),
                indicatorColor: Color(0xFF4B3082),
                unselectedLabelColor: Colors.grey,
                isScrollable: true,
                tabs: choices.map((Choice choice) {
                  return Tab(
                    text: choice.title,
                    icon: Icon(choice.icon),
                  );
                }).toList(),
              ),
            ),
            body: TabBarView(
              children: choices.map((Choice choice) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 10.0),
                  child: ChoiceCard(choice: choice),
                );
              }).toList(),
            )));
  }
}

class Item {
  final String category;
  final List<String> item;
  final DocumentReference reference;

  Item.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['category'] != null),
        assert(map['item'] != null),
        category = map['category'],
        item = map['item'];

  Item.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
}

class Choice {
  const Choice({Key key, this.title, this.icon, this.item});

  final String title;
  final IconData icon;
  final List<String> item;
}

const List<Choice> choices = const <Choice>[
  const Choice(
      title: '육류',
      icon: Icons.add,
      item: ["소고기", "돼지고기", "계란", "닭고기", "오리고기", "돈까스"]),
  const Choice(
      title: '해산물',
      icon: Icons.add,
      item: ["고등어", "갈치", "멸치", "조기", "연어", "새우", "꽃게", "바지락", "홍합"]),
  const Choice(title: '채소/과일', icon: Icons.add, item: [
    "대파",
    "양파",
    "무",
    "마늘",
    "양배추",
    "배추",
    "사과",
    "바나나",
    "복숭아",
    "귤",
    "오렌지",
    "수박"
  ]),
  const Choice(
      title: '조리도구',
      icon: Icons.add,
      item: ["전자레인지", "오븐", "가스레인지", "에어프라이기", "믹서", "토스트"]),
];

class ItemCard extends StatelessWidget {
  const ItemCard({Key key, this.item}) : super(key: key);

  final Item item;

  Widget list(List<String> item) {
    Buttons list(String data) {
      return Buttons(name: Text("$data"));
    }

    return Column(
      children: item.map((data) => list(data)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            list(item.item),
          ],
        ),
      ],
    );
  }
}

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  Widget list(List<String> item) {
    Buttons list(String data) {
      return Buttons(name: Text("$data"));
    }

    return Column(
      children: item.map((data) => list(data)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            list(choice.item),
          ],
        ),
      ],
    );
  }
}
