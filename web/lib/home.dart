import 'package:dashboard/entertainment.dart';
import 'package:dashboard/mobil.dart';
import 'package:dashboard/sparepart.dart';
import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Firestore db = firestore();

  final List<Widget> _pages = [
    SparePart(),
    Mobil(),
    Entertainment(),
  ];

  int _index = 0;

  void _addData() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Tambah Mobil'),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard ToyotaKU'),
      ),
      body: _pages[_index],
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        onPressed: _addData,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'Admin ToyotaKU',
                style: TextStyle(color: Colors.white, fontSize: 48),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              title: Text('Spare Parts'),
              leading: Icon(Icons.settings),
              onTap: () {
                setState(() {
                  _index = 0;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Mobil'),
              leading: Icon(Icons.directions_car),
              onTap: () {
                setState(() {
                  _index = 1;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Entertainment'),
              leading: Icon(Icons.movie),
              onTap: () {
                setState(() {
                  _index = 2;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
