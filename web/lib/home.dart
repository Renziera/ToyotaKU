import 'package:dashboard/antrian.dart';
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
    Antrian(),
    SparePart(),
    Mobil(),
  ];

  final List<String> _titles = [
    'Antrian',
    'Spare Parts',
    'Mobil',
  ];

  int _index = 0;

  void _addData() async {
    switch (_index) {
      case 2:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return TambahMobil();
            });
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_index]),
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
              title: Text('Antrian'),
              leading: Icon(Icons.av_timer),
              onTap: () {
                setState(() {
                  _index = 0;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Spare Parts'),
              leading: Icon(Icons.settings),
              onTap: () {
                setState(() {
                  _index = 1;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text('Mobil'),
              leading: Icon(Icons.directions_car),
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

class TambahMobil extends StatelessWidget {
  final TextEditingController _tipeController = TextEditingController();
  final TextEditingController _rangkaController = TextEditingController();
  final TextEditingController _mesinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tambah Mobil'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _tipeController,
            decoration: InputDecoration(hintText: 'Tipe mobil'),
          ),
          TextField(
            controller: _rangkaController,
            decoration: InputDecoration(hintText: 'Nomor rangka'),
          ),
          TextField(
            controller: _mesinController,
            decoration: InputDecoration(hintText: 'Nomor mesin'),
          ),
        ],
      ),
      actions: <Widget>[
        RaisedButton(
          color: Colors.red,
          child: Text('Batal'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        RaisedButton(
          color: Colors.blue,
          child: Text('Tambah'),
          onPressed: () {
            if (_tipeController.text.isEmpty ||
                _rangkaController.text.isEmpty ||
                _mesinController.text.isEmpty) return;
            firestore().collection('mobil').add({
              'tipe': _tipeController.text,
              'no_rangka': _rangkaController.text,
              'no_mesin': _mesinController.text,
              'owned': false,
              'created_at': FieldValue.serverTimestamp(),
            });
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
