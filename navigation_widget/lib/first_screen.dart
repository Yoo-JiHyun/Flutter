import 'package:flutter/material.dart';
import 'second_screen.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondScreen()),
            );

            // pop + push 동시
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => SecondScreen()));
          },
          child: Text('Go to Second Screen'),
        ),
      ),
    );
  }
}