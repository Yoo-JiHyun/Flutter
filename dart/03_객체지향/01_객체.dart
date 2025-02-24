class Person {
  // 변수
  String name;
  int age;

  // 생성자
  Person(this.name, this.age);

  // 메서드
  void test() {
    print("나는 $name($age) 입니다.");
  }
}

void main() {
  // 객체 생성
  var person1 = Person("김조은", 25);
  var person2 = Person("더조은", 30);

  person1.test();
  person2.test();

  person1.name = "박조은";
  person1.age = 24;

  person1.test();
}
