import 'package:dice_app/dice_roller.dart';
import 'package:dice_app/text_widget.dart';
import 'package:flutter/material.dart';

Alignment? startAlignment;

class GradientContainer extends StatefulWidget {
  final Color color1, color2;
  const GradientContainer(
      {super.key, required this.color1, required this.color2});
  const GradientContainer.purple({super.key})
      : color1 = Colors.deepPurple,
        color2 = Colors.indigo;

  @override
  State<GradientContainer> createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    startAlignment = Alignment.topLeft;
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          widget.color1,
          widget.color2,
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: const Center(
          child: DiceRoller(),
        ));
  }
}
