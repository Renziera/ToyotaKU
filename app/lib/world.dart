import 'package:flutter/material.dart';

class ToyotaWorld extends StatefulWidget {
  @override
  _ToyotaWorldState createState() => _ToyotaWorldState();
}

class _ToyotaWorldState extends State<ToyotaWorld> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toyota World'),
      ),
    );
  }
}
