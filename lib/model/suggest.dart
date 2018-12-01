class SuggestList {
  final String name;
  final String url;
  final String category;
  SuggestList(this.name, this.url, this.category);
}

List<SuggestList> suggestList = [
  SuggestList("육류", "images/suggest/meat.jpg","meat"),
  SuggestList("해산물", "images/suggest/seafood.jpg", "seafood"),
  SuggestList("밥류", "images/suggest/rice.jpg","rice"),
  SuggestList("면요리", "images/suggest/noodle.jpg","noodle"),
  SuggestList("찌개/찜류", "images/suggest/jigae.jpg","jigae"),
  SuggestList("샐러드", "images/suggest/salad.jpg","salad"),
  SuggestList("닭고기", "images/suggest/chicken.jpg","chicken"),
  SuggestList("베이커리", "images/suggest/bakery.jpg","bakery"),
  SuggestList("달걀/유제품", "images/suggest/egg.jpg","egg"),
  SuggestList("튀김", "images/suggest/fried.jpg","fried"),
  SuggestList("디저트", "images/suggest/dessert.jpg","dessert"),
  SuggestList("음료", "images/suggest/beverage.jpg","beverage"),
  SuggestList("아침용", "images/suggest/breakfast.jpg","breakfast"),
  SuggestList("간단하게 먹기", "images/suggest/time.jpg","time"),
];
