import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toyotaku/main.dart';

class MyCars extends StatefulWidget {
  @override
  _MyCarsState createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  void _addCar() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AddCar(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Cars'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addCar,
          ),
        ],
      ),
    );
  }
}

class AddCar extends StatelessWidget {
  final TextEditingController _rangkaController = TextEditingController();
  final TextEditingController _mesinController = TextEditingController();
  final TextEditingController _kodeController = TextEditingController();

  void _tambahBaru() async {
    if (_rangkaController.text.isEmpty) return;
    if (_mesinController.text.isEmpty) return;
    
    QuerySnapshot qs = await Firestore.instance
        .collection('mobil')
        .where('no_rangka', isEqualTo: _rangkaController.text)
        .where('no_mesin', isEqualTo: _mesinController.text)
        .getDocuments();
    
    
  }

  void _tambahBekas() {}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Car', textAlign: TextAlign.center),
      titleTextStyle: TextStyle(color: MERAH, fontWeight: FontWeight.bold),
      content: DefaultTabController(
        length: 2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TabBar(
              labelColor: MERAH,
              tabs: <Widget>[
                Tab(
                  text: 'New',
                ),
                Tab(
                  text: 'Old',
                ),
              ],
            ),
            SizedBox(
              height: 256,
              child: TabBarView(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TextField(
                        controller: _rangkaController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(hintText: 'Nomor Rangka'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: _mesinController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(hintText: 'Nomor Mesin'),
                        keyboardType: TextInputType.number,
                      ),
                      RaisedButton(
                        color: MERAH,
                        textColor: Colors.white,
                        child: Text('ADD'),
                        onPressed: _tambahBaru,
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      TextField(
                        controller: _rangkaController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(hintText: 'Nomor Rangka'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: _mesinController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(hintText: 'Nomor Mesin'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: _kodeController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(hintText: 'Kode'),
                        keyboardType: TextInputType.text,
                      ),
                      RaisedButton(
                        color: MERAH,
                        textColor: Colors.white,
                        child: Text('ADD'),
                        onPressed: _tambahBekas,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CarDetail extends StatefulWidget {
  @override
  _CarDetailState createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
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
