import 'package:flutter/material.dart';
import 'package:toyotaku/splash.dart';

void main() => runApp(ToyotaKU());

class ToyotaKU extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToyotaKU',
      theme: ThemeData(
        primarySwatch: MERAH,
        fontFamily: 'Bahnschrift',
      ),
      home: Splash(),
    );
  }
}

const MaterialColor MERAH = const MaterialColor(0xFFE64743, {
  50: Color.fromRGBO(230, 71, 67, .1),
  100: Color.fromRGBO(230, 71, 67, .2),
  200: Color.fromRGBO(230, 71, 67, .3),
  300: Color.fromRGBO(230, 71, 67, .4),
  400: Color.fromRGBO(230, 71, 67, .5),
  500: Color.fromRGBO(230, 71, 67, .6),
  600: Color.fromRGBO(230, 71, 67, .7),
  700: Color.fromRGBO(230, 71, 67, .8),
  800: Color.fromRGBO(230, 71, 67, .9),
  900: Color.fromRGBO(230, 71, 67, 1),
});
