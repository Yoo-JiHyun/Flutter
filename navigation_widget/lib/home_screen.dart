import 'package:flutter/material.dart';
import 'package:navigation_widget/models/commnunity.dart';

class HomeScreen extends StatelessWidget {
  final data;
  const HomeScreen({super.key, this.data = 'default'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("홈 화면"),),
      body: Center(
        child: Text(
          "홈 화면 : $data",
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      bottomSheet: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(onPressed: () {
              // 라우티 경로로 화면 이동
              // * arguments : 화면 이동 시, 전달할 데이터 저장
              Navigator.pushNamed(context, "/user", arguments: 'user');
            },
             child: const Text("마이페이지")
          ),
            ElevatedButton(onPressed: () {
              Navigator.pushNamed(context, "/commnunity",
                                  // arguments: Commnunity(
                                  //   id: 1001,
                                  //   name: 'aloha',
                                  //   content: 'content')
                                  arguments: {
                                    'id'      : 1001,
                                    'name'    : 'aloha',
                                    'content' : 'content',
                                  }
                                );
            },
             child: const Text("커뮤니티")
          ),
          ],
        ),
      ),
    );
  }
}