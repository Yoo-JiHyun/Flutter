import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;            // 버튼 텍스트
  final VoidCallback onPressed; // 버튼 클릭 시 호출할 함수
  final isFullWidth;            // 버튼을 꽉 채울지 여부

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth
    });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth == true ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(fontSize: 16),
        ),
        child: Text(text),
      ),
    );
  }
}