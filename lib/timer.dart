/*
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class CompassWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Position>(
      future: Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final position = snapshot.data!;
          return Text('Current bearing: ${position.heading}°'); // Show bearing
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class CountdownTimer extends StatefulWidget {
  final DateTime targetDate;

  CountdownTimer({required this.targetDate});

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late Duration _remainingTime;

  @override
  void initState() {
    super.initState();
    _remainingTime = widget.targetDate.difference(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = widget.targetDate.difference(DateTime.now());
        if (_remainingTime.isNegative) {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Time remaining: ${_remainingTime.inHours}:${_remainingTime.inMinutes % 60}:${_remainingTime.inSeconds % 60}',
      style: TextStyle(fontSize: 16),
    );
  }
}
*/
