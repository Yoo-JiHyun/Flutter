import 'package:flutter/material.dart';
import 'package:login_app/widgets/commom_bottom_navigation_bar.dart';
import 'package:login_app/widgets/custom_drawer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("검색"),
      ),
      body: Center(
        child:
        const Text("검색 화면"),
      ),
      endDrawer: CustomDrawer(),
      bottomNavigationBar: CommomBottomNavigationBar(currentIndex: 1),
    );
  }
}