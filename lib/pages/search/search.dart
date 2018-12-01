import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:cookday/pages/recommend/detailed_info.dart';

import 'package:cookday/model/backend.dart';
import 'package:cookday/model/suggest.dart';
import 'package:cookday/pages/search/result_search.dart';

class Search extends StatefulWidget {
  final uid; //user의 uid
  Search({Key key, this.uid}) :super (key : key);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Widget appBarTitle;
  Icon actionIcon;

  @override
  void initState() {
    super.initState();
    appBarTitle = new Text("검색하기");
    actionIcon = new Icon(Icons.search);
  }

  Widget _buildGridCards(BuildContext context, var document) {
    //Card형식의 디테일한 코드
    return InkWell(
      onTap: (){
         Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                ResultSearch(category: document.category, name:document.name, userUid: widget.uid)));
      },//테마별 리스트 나오게 구현해야함
      child: Card(
      child: Stack(
        children: <Widget>[
          Container(
            child: Image.asset(document.url,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          Center(
            child: Text(document.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 18.0)),
          )
        ],
      ),
    ),
    );
  }

  Widget _buildList(List<SuggestList> snapshot) {
    //card형식으로 만들 builder
    return GridView.builder(
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisSpacing: 5.0, crossAxisSpacing: 5.0),
        padding: const EdgeInsets.all(15.0),
        itemCount: snapshot.length,
        itemBuilder: (_, int index) {
          final document = snapshot[index];
          return Container(
            child: _buildGridCards(context, document),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(title: appBarTitle, actions: <Widget>[
            new IconButton(
              icon: actionIcon,
              onPressed: () {
                setState(() {
                  if (this.actionIcon.icon == Icons.search) {
                    //search icon 클릭시 글쓰는 칸으로 변한다
                    this.actionIcon = new Icon(Icons.close);
                    this.appBarTitle = TypeAheadField(
                      //글을 쓰면 미리보기 처럼 listtile이 내려온다
                      textFieldConfiguration: TextFieldConfiguration(
                        autofocus: true,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: '음식재료를 적어주세요'),
                      ),
                      suggestionsCallback: (pattern) async {
                        //어떤 데이터들이 나열될지 호출
                        return await BackendService.getSuggestions(pattern);
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          //불러온 데이터를 display
                          leading: Icon(Icons.restaurant_menu),
                          title: Text(suggestion['name']),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                DetailedInfo(uid: suggestion['uid'], userUid: widget.uid)));
                      },
                    );
                  } else {
                    this.actionIcon = new Icon(Icons.search);
                    this.appBarTitle = new Text("검색하기");
                  }
                });
              },
            ),
          ])
        ];
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20.0, top: 20.0),
            child: Text("테마별 요리", style: TextStyle(fontSize: 20.0))
          ),
          Expanded(child: _buildList(suggestList))
          ],
      ),
    );
  }
}