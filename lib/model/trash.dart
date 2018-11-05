class Trash {
  //음식 사진들
  final String id;
  final String recipeName;
  final String subTitle;
  final String url;
  final String author;
  final String cookTime;
  final List<String> ingredients;
  final List<String> steps;
  final List<String> stepPic;
  final String date;

  Trash(this.id, this.recipeName, this.subTitle, this.url, this.author, this.cookTime,
      this.ingredients, this.steps, this.stepPic, this.date);
}

List<Trash> trashList = [
  Trash(
    "0",
      "베이컨 맛탕",
      "단짠단짠의 극치!",
      "images/foodpic/bacon.jpeg",
      "이멕남",
      "10분",
      [
        "통베이컨 250g",
        "올리고당 5 큰술",
        "설탕 1 큰술",
      ],
      [
        "베이컨은 먹기 좋게 짜른 다음 팬에 앞뒤양옆으로 노릇노릇하게 구워주세요!",
        "그런 다음 팬에 올리고당 5 큰술과 설탕 1 큰술을 넣어서 잘 섞어주세요",
        "그런 다음 베이컨을 넣고 1-2분 동안 요리조리 굴려가면서 입히면 끝입니다! 개인적으로 감자튀김이랑 곁들이면 아주 잘 어울려요!"
      ],
      [
        "images/foodpic/bacon1.jpeg",
        "images/foodpic/bacon2.jpeg",
        "images/foodpic/bacon3.jpeg"
      ],
      "2018-07-20"),
  Trash(
    "1",
      "치즈포테이토",
      "치즈 뿜뿜 부드러운 치즈포테이토",
      "images/foodpic/cheesepotato.jpeg",
      "마틸다",
      "30분",
      ["감자 2개", "샌드위치햄 1장", "체다치즈 1장", "견과류 약간", "연유 1큰술"],
      [
        "감자는 끓는 물에 폭 삶아 준비해요.",
        "삶은 감자는 반을 갈라 속을 파냅니다.",
        "파낸 감자속과 잘게 썬 햄과 치즈, 부순 견과류, 연유, 소금을 넣고 잘 섞어주세요.",
        "속을 파낸 감자에 봉긋하게 올린 뒤 치즈를 올려줍니다. 전자렌지에 1분정도 돌려주면 완성!"
      ],
      [
        "images/foodpic/cheesepotato1.jpeg",
        "images/foodpic/cheesepotato2.jpeg",
        "images/foodpic/cheesepotato3.gif",
        "images/foodpic/cheesepotato4.jpeg"
      ],
      "2018-06-16"),
  Trash(
    "2",
      "훈제오리또띠아쌈",
      "특별한 보양식이 필요한 날",
      "images/foodpic/duck.jpeg",
      "앨샘",
      "30분",
      [
        "훈제오리 200g",
        "쌈무 16장",
        "또띠아 4장",
        "대파 1대",
        "파프리카 1개",
        "고춧가루 1큰술",
        "설탕 2/3큰술",
        "식초 1큰술",
        "까나리액젓 1/3큰술",
        "간장 1큰술",
        "참기름 1큰술",
        "참깨 1/2큰술"
      ],
      [
        "대파와 파프리카는 채 썰어요. Tip - 대파는 직접 채 썰어도 되지만 마트에서 채 썬 것을 구입할 수 있어요. 찬물에 가볍게 헹궈 매운 맛을 제거한 뒤 사용해도 좋아요.",
        "양념(고춧가루 1큰술, 설탕 1큰술, 식초 1큰술, 까나리액젓 1/3큰술, 간장 1큰술, 참기름 1큰술, 부순 참깨 1/2큰술)에 버무려요.",
        "또띠아를 중약 불로 달군 마른 팬에서 앞뒤로 30초씩 구워 4등분으로 잘라요.",
        "같은 팬에 훈제오리를 올려 노릇하게 구워 건져요. Tip - (슬라이스)훈제오리는 마트, 백화점, 정육점에서 쉽게 구입할 수 있어요. 납작 썬 마늘과 함께 구워도 좋아요.",
        "그릇에 구운 훈제오리와 채소무침, 반으로 썬 쌈무를 돌려 담고 구운 또띠아를 곁들여 완성해요. 또띠아에 쌈무-훈제오리-파무침 순으로 올린 뒤 살짝 오므려 싸 먹어요! tip - 취향에 따라 머스터드소스를 더해도 돼요."
      ],
      [
        "images/foodpic/duck1.jpeg",
        "images/foodpic/duck2.jpeg",
        "images/foodpic/duck3.jpeg",
        "images/foodpic/duck4.jpeg",
        "images/foodpic/duck5.jpeg"
      ],
      "2018-06-16"),
  Trash(
    "3",
      "딸기 크림치즈 타르트",
      "오븐 필요없어! 딸기 크림치즈 타르트",
      "images/foodpic/cookie.jpeg",
      "눈떳게안떳게",
      "15분",
      [
        "다이제 1/2개",
        "계란 1개",
        "딸기 한줌",
        "블루베리 약간",
        "요거트 1개",
        "크림치즈 100g",
        "슈가파우더 약간"
      ],
      [
        "그리고 오늘은 재료도 재료지만, 무엇보다 지퍼팩과 종이컵이 필요해! ※필수※",
        "타르트 밑에 타르트지를 만들거야 일단, 지퍼팩에 다이제를 넣고",
        "부셔줘. 주먹쥐고 꾹꾹~",
        "가루가 되면 볼에 넣고, 계란을 톡",
        "반죽이 잘 섞이도록 꾹꾹 섞어줘",
        "이제 종이컵을 준비! 가위로 반을 잘라주고, 종이컵 안에다가 반죽을 넣어줘",
        "이제 전자렌지로 구워줄거야 2분 돌려주기! 돌아가는 동안 고소한 냄새가 난다",
        "종이컵은 구워지면서 자연스럽게 떨어져. 뜨거우니까 식혀주고.",
        "볼에 요거트 1개를 넣고 크림치즈 100g을 넣어줘!",
        "토핑으로 올릴 딸기를 예쁘게 썰어주고",
        "이제 타르트지에다가 크림치즈를 넣을테야. 한숟가락정도 넣으면 채워지더라고. 그 위에는 딸기를 올리고",
        "슈가 파우더를 휘리릭 뿌리면 끝-"
      ],
      [
        "images/foodpic/cookie1.jpeg",
        "images/foodpic/cookie2.jpeg",
        "images/foodpic/cookie3.gif",
        "images/foodpic/cookie4.gif",
        "images/foodpic/cookie5.jpeg",
        "images/foodpic/cookie6.jpeg",
        "images/foodpic/cookie7.jpeg",
        "images/foodpic/cookie8.jpeg",
        "images/foodpic/cookie9.jpeg",
        "images/foodpic/cookie10.gif",
        "images/foodpic/cookie11.gif",
        "images/foodpic/cookie12.jpeg"
      ],
      "2018-06-17"),
];
