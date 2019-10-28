import 'package:flutter/material.dart';
import 'package:toyotaku/splash.dart';

void main() => runApp(ToyotaKU());

class ToyotaKU extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToyotaKU',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Bahnschrift',
      ),
      home: Splash(),
    );
  }
}
