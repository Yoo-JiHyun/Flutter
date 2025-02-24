void main(List<String> args) {
  List<int> list = [1, 2, 3, 4, 5];
  print("list : $list");

  // 리스트 요소 접근 및 수정
  list[0] = 100;
  print("list[0] : ${list[0]}");

  // 리스트 길이
  print("리스트 길이 : ${list.length}");

  // 리스트 요소 추가
  list.add(55);
  print("list : $list");

  // 리스트 요소 제거 - 값으로 제거
  list.remove(55);
  print("list : $list");

  // 리스트 요소 제거 - index 로 제거
  list.removeAt(3); // index : 3 인 요소 제거
  print("list : $list");

  // 리스트 반복
  list.forEach((item) {
    print(item);
  });

  // 첫번째 요소, 마지막 요소
  print("첫번째 : ${list.first}");
  print("마지막 : ${list.last}");

  List<String> wordList = ["A", "B", "C", "D", "E"];
  print("wordList : $wordList");

  // 역방향 정렬
  List<String> reversedWordList = wordList.reversed.toList();
  print("reversedWordList : $reversedWordList");

  // 정방향 정렬
  List<int> numList = [10, 6, 5, 7, 2];
  numList.sort();
  print("numList : $numList");
}
