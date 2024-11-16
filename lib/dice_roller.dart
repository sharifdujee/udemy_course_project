import 'dart:math';

import 'package:flutter/material.dart';

final randomNumber = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({super.key});

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  var currentDiceRoll = 2;
  rollDice() {
    setState(() {
      currentDiceRoll = randomNumber.nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/images/dice_$currentDiceRoll.png',
          width: 200,
        ),
        const SizedBox(
          height: 20,
        ),
        TextButton(
            onPressed: () {
              rollDice();
            },
            style: TextButton.styleFrom(
                padding: const EdgeInsets.only(top: 20),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 28, color: Colors.white)),
            child: const Text(
              'Roll Dice',
              style: TextStyle(color: Colors.white),
            ))
      ],
    );
  }
}
