Future<String> fetchData() {
  return Future.delayed(Duration(seconds: 2), () {
    throw '강제 예외 발생';
    return '결과 데이터';
  });
}

void fetchDataAwait() async {
  try {
    String result = await fetchData();
    print(result);
  } catch (e) {
    print(e);
  }
}

void main(List<String> args) {
  fetchData().then((data) {
    print(data);
    print('추가 작업...');
  }).catchError((error) {
    print(error);
  });

  fetchDataAwait();
  print('요청 중...');
}
