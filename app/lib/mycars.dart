import 'package:flutter/material.dart';

class MyCars extends StatefulWidget {
  @override
  _MyCarsState createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cars'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

String carImage(String s) {
  s = s.toLowerCase();
  if (s.contains('tundra')) {
    return 'img/tundra.png';
  } else if (s.contains('camry')) {
    return 'img/camry.png';
  } else if (s.contains('fj')) {
    return 'img/fj.png';
  } else if (s.contains('gt86')) {
    return 'img/gt86.png';
  } else if (s.contains('supra')) {
    return 'img/supra.png';
  } else if (s.contains('cruiser')) {
    return 'img/cruiser.png';
  } else {
    return 'img/camry.png';
  }
}
