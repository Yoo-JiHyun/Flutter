import 'package:flutter/material.dart';
import 'package:user_app/screens/home_screen.dart';
import 'package:user_app/screens/user/join_screen.dart';
import 'package:user_app/screens/user/login_screen.dart';
import 'package:user_app/screens/user/mypage_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'user app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/main',
      routes: {
        '/main' : (context) => const HomeScreen(),
        '/user/login' : (context) => const LoginScreen(),
        '/user/join' : (context) => const JoinScreen(),
        '/user/mypage' : (context) => const MypageScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
