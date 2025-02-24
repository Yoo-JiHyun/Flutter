import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:user_app/widgets/custom_button.dart';
import 'package:user_app/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          children: [
            const Text("홈 화면"),
            CustomButton(
              isFullWidth: true,
              text: "로그인",
              onPressed: () {
                // Drawer 열기
              //  ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(content: Row(
              //     children: [
              //       Icon(Icons.check_circle, color: Colors.white),
              //       SizedBox(width: 8),
              //       Text("성공적으로 업로드되었습니다."),
              //     ],
              //   ),
              //   duration: const Duration(seconds: 5),
              //   backgroundColor: Colors.blueAccent,
              //   behavior: SnackBarBehavior.floating,
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              //   ),
              //  ); 
              }
            )
          ],
        ) 
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        _scaffoldKey.currentState?.openDrawer();
      },
      ),
        bottomNavigationBar: BottomNavigationBar(items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home),
          label: "home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.category),
          label: "category",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person),
          label: "person",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz),
          label: "more",
          ),
        ],
      ),
    );
  }
}