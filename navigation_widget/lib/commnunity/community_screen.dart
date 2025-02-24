import 'package:flutter/material.dart';
import 'package:navigation_widget/models/commnunity.dart';

class CommnunityScreen extends StatelessWidget {
  const CommnunityScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Commnunity 객체
    // Commnunity? commnunity = ModalRoute.of(context)!.settings.arguments as Commnunity;

    // Map 컬랙션
    final commnunity = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(title: const Text("커뮤니티"),),
      body: Center(
        child: Text(
          "커뮤니티\n "
          // + "id: ${commnunity.id}\n "
          // + "name: ${commnunity.name}\n "
          // + "content: ${commnunity.content}",
          + "id: ${commnunity?['id']}\n "
          + "name: ${commnunity?['name']}\n "
          + "content: ${commnunity?['content']}",
          style: TextStyle(fontSize: 30.0),
        ),
      ),
      bottomSheet: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/home");
              },
              child: const Text("홈 화면")
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/user",
                arguments: 'user');
              },
              child: const Text("마이페이지")
            ),
          ],
        ),
      ),
    );
  }
}