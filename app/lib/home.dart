import 'package:flutter/material.dart';
import 'package:toyotaku/cek_part.dart';
import 'package:toyotaku/main.dart';
import 'package:toyotaku/mycars.dart';
import 'package:toyotaku/page_home.dart';
import 'package:toyotaku/profile.dart';
import 'package:toyotaku/world.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> _pages;

  @override
  void initState() {
    _pages = [
      HomePage(setPage: _setPage),
      MyCars(),
      CekPart(),
      ToyotaWorld(),
      Profile(),
    ];
    super.initState();
  }

  int _index = 0;

  void _setPage(int x) {
    setState(() {
      _index = x;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      floatingActionButton: FloatingActionButton(
        child: Image.asset('img/qr_code.png', height: 24, width: 24),
        backgroundColor: MERAH,
        onPressed: () {
          setState(() {
            _index = 2;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: MERAH,
        unselectedItemColor: Colors.grey,
        currentIndex: _index,
        onTap: _setPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            title: Text('My Cars'),
          ),
          BottomNavigationBarItem(
            icon: SizedBox.shrink(),
            title: Text(''),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ondemand_video),
            title: Text('Toyota World'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}
