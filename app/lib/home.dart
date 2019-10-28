import 'package:flutter/material.dart';
import 'package:toyotaku/world.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: RaisedButton(
        child: Text('Toyota World'),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ToyotaWorld()));
        },
      ),
    );
  }
}
