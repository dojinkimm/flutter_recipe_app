class Ingredients {
  final String category;
  final String url;
  final String documentID;
  bool selected;
  Ingredients(this.category, this.url, this.documentID, this.selected);
}

List<Ingredients> ingredList = [
 Ingredients("육류","images/ingredients/meat.png", "meat", false),
 Ingredients("해산물","images/ingredients/seafood.png", "seafood",false),
 Ingredients("채소/과일","images/ingredients/fruit.png", "fruit",false),
 Ingredients("유제품","images/ingredients/dairy.png", "dairy",false),
 Ingredients("양념및소스","images/ingredients/sauce.png", "sauce",false),
 Ingredients("음료","images/ingredients/beverage.png", "beverage", false),
];

class Others {
  final String category;
  final String url;
  final String documentID;
  bool selected;
  Others(this.category, this.url, this.documentID, this.selected);
}

List<Others> otherList = [
 Others("기타","images/ingredients/other.png", "other",false),
 Others("조리도구","images/ingredients/tools.png", "tools",false),
];

class TotalList{
  final String category;
  final String url;
  TotalList(this.category, this.url);
}

List<TotalList> totalList = [
 TotalList("육류","images/ingredients/meat.png"),
 TotalList("해산물","images/ingredients/seafood.png"),
 TotalList("채소/과일","images/ingredients/fruit.png"),
 TotalList("유제품","images/ingredients/dairy.png"),
 TotalList("양념및소스","images/ingredients/sauce.png"),
 TotalList("음료","images/ingredients/beverage.png"),
 TotalList("기타","images/ingredients/other.png"),
 TotalList("조리도구","images/ingredients/tools.png"),
];