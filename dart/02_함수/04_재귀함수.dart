import 'dart:io';

int factorial(int n) {
  if (n == 0 || n == 1) {
    return 1;
  } else {
    return n * factorial(n - 1);
  }
}

void main() {
  stdout.write("N! : ");
  String? input = stdin.readLineSync();
  int N = int.parse(input!);

  print(factorial(N)); // 출력: 120
}
