import 'package:flutter/material.dart';
class TextWidget extends StatelessWidget {
  final String text;
  const TextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return   Text(
      text,
      style: TextStyle(fontSize: 28.5, color: Colors.white),
    );
  }
}
