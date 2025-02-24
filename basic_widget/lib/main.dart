import 'package:basic_widget/exmaple/icon_widget.dart';
import 'package:basic_widget/exmaple/image_widget.dart';
import 'package:basic_widget/exmaple/safearea_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '기본 위젯',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("기본 위젯"),
        ),
        body: 
          // TextWidget()
          // ImageWidget()
          // IconWidget()
          SafeareaWidget()
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
