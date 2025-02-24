import 'package:flutter/material.dart';
import 'package:sqlite_board_app/screens/board/insert_screen.dart';
import 'package:sqlite_board_app/screens/board/list_screen.dart';
import 'package:sqlite_board_app/screens/board/read_screen.dart';
import 'package:sqlite_board_app/screens/board/update_screen.dart';
import 'package:sqlite_board_app/screens/main_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'sqlite board app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/main',
      routes: {
        '/main' : (context) => const MainScreen(),
        '/board/list' : (context) => const ListScreen(),
        '/board/read' : (context) => const ReadScreen(),
        '/board/insert' : (context) => const InsertScreen(),
        '/board/update' : (context) => const UpdateScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
