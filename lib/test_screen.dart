import 'package:dice_app/gradient_container.dart';
import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      /*backgroundColor: Color.fromARGB(255, 63, 5, 120),*/
      body:GradientContainer.purple()
    );
  }
}



