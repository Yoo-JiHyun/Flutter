import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // 데이터 전달 받기
    String? data = ModalRoute.of(context)!.settings.arguments as String?;

    return Scaffold(
      appBar: AppBar(title: const Text("마이페이지"),),
      body: Center(
        child: Column(
          children: [
            Text(
              "마이페이지",
              style: TextStyle(fontSize: 30.0),
            ),
            Text(
              "data : $data",
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 30.0,),
            Text(
              "id : aloha, name : 알로하",
              style: TextStyle(fontSize: 30.0),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                // 1. 스택에 새 화면을 추가
                // Navigator.pushNamed(context, "/home");
                // 2. 현재 화면 제거 후, 새 화면을 추가
                // Navigator.pop(context);
                // Navigator.pushNamed(context, "/home");
                // 3. 현재 화면을 새 화면으로 대체
                Navigator.pushReplacementNamed(context, "/home");
              },
              child: const Text("홈 화면")
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/commnunity",
                arguments: 'commnunity');
              },
              child: const Text("커뮤니티")
            ),
          ],
        ),
      ),
    );
  }
}