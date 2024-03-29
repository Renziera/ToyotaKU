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
      case 0:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return TambahAntrian();
            });
        break;
      case 1:
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return TambahSparePart();
            });
        break;
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
              decoration: BoxDecoration(color: Colors.red),
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

class TambahAntrian extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tambah Antrian Servis'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(hintText: 'PIN'),
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
          onPressed: () async {
            if (_controller.text.isEmpty) return;
            QuerySnapshot qs = await firestore()
                .collection('mobil')
                .where('pin', '==', _controller.text)
                .get();
            if (qs.empty) {
              _controller.clear();
              return;
            }

            var data = qs.docs.first.data();
            firestore()
                .collection('users')
                .doc(data['owner'])
                .update(data: {'servis': true});

            firestore().collection('antrian').add({
              'tipe': data['tipe'],
              'no_rangka': data['no_rangka'],
              'no_mesin': data['no_mesin'],
              'owner': data['owner'],
              'id_mobil': qs.docs.first.id,
              'created_at': FieldValue.serverTimestamp(),
            });

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class TambahSparePart extends StatelessWidget {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _mobilController = TextEditingController();
  final TextEditingController _partController = TextEditingController();
  final TextEditingController _kodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tambah Spare Parts'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            controller: _namaController,
            decoration: InputDecoration(hintText: 'Nama Part'),
          ),
          TextField(
            controller: _mobilController,
            decoration: InputDecoration(hintText: 'Tipe Mobil'),
          ),
          TextField(
            controller: _partController,
            decoration: InputDecoration(hintText: 'Parts Number'),
          ),
          TextField(
            controller: _kodeController,
            decoration: InputDecoration(hintText: 'Kode'),
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
            if (_namaController.text.isEmpty ||
                _mobilController.text.isEmpty ||
                _partController.text.isEmpty ||
                _kodeController.text.isEmpty) return;
            firestore().collection('spareparts').add({
              'nama': _namaController.text,
              'mobil': _mobilController.text,
              'parts_number': _partController.text,
              'kode': _kodeController.text,
              'new': true,
              'created_at': FieldValue.serverTimestamp(),
            });
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

class TambahMobil extends StatelessWidget {
  final TextEditingController _tipeController = TextEditingController();
  final TextEditingController _tahunController = TextEditingController();
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
            controller: _tahunController,
            decoration: InputDecoration(hintText: 'Tahun'),
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
                _mesinController.text.isEmpty ||
                _tahunController.text.isEmpty) return;
            firestore().collection('mobil').add({
              'tipe': _tipeController.text,
              'tahun': _tahunController.text,
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
