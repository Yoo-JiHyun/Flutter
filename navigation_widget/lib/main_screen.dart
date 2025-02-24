import 'package:flutter/material.dart';
import 'package:navigation_widget/commnunity/community_screen.dart';
import 'package:navigation_widget/home_screen.dart';
import 'package:navigation_widget/user/user_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  // 선택된 화면
  Widget _selectedScreen = HomeScreen();
  // 선택된 화면 index
  int _selectIndex = 0;

  // bottomNavigation 탭 콜백함수
  void _onTab(int index) {
    print("화면을 이동합니다.");

    // ⭐setState()
    // : StatefulWidget 에서 변경된 state 를 반영하여 UI 업데이트
    setState(() {
      _selectIndex = index;
      switch (_selectIndex) {
        case 0 : _selectedScreen = HomeScreen(data : 'home'); break;
        case 1 : _selectedScreen = UserScreen(); break;
        case 2 : _selectedScreen = CommnunityScreen(); break;
      } 
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("메인 화면"),),
      body: _selectedScreen,
      bottomNavigationBar: BottomNavigationBar(
        items: const[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home"
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "User"
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Commnunity"
            ),
        ],
        currentIndex: _selectIndex,
        onTap: _onTab,  
      ),
    );
  }
}