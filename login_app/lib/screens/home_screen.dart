import 'package:flutter/material.dart';
import 'package:login_app/widgets/commom_bottom_navigation_bar.dart';
import 'package:login_app/widgets/custom_button.dart';
import 'package:login_app/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("홈"),
      ),
      body: Center(
        child:
        const Text("홈 화면"),
        // CustomButton(
        //   text: "로그인",
        //   onPressed: () {},
        // )
      ),
      // 왼쪽 Drawer
      // drawer: Drawer(),
      //오른쪽 Drawer
      endDrawer: CustomDrawer(),
      bottomNavigationBar: CommomBottomNavigationBar(currentIndex: 0),
    );
  }
}
