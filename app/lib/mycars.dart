import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toyotaku/main.dart';

class MyCars extends StatefulWidget {
  @override
  _MyCarsState createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  String _uid;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        _uid = user.uid;
      });
    });
  }

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
      body: _uid == null
          ? Center(child: CircularProgressIndicator())
          : StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('users')
                  .document(_uid)
                  .collection('mobil')
                  .orderBy('created_at', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text(snapshot.error);
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                return ListView(
                  children: snapshot.data.documents.map((doc) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  CarDetail(id: doc.documentID)));
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: <Widget>[
                                Image.asset(carImage(doc['tipe'])),
                                Text(
                                  doc['tipe'],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
    );
  }
}

class AddCar extends StatelessWidget {
  final TextEditingController _rangkaController = TextEditingController();
  final TextEditingController _mesinController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();

  void _tambahBaru(BuildContext context) async {
    if (_rangkaController.text.isEmpty) return;
    if (_mesinController.text.isEmpty) return;

    QuerySnapshot qs = await Firestore.instance
        .collection('mobil')
        .where('no_rangka', isEqualTo: _rangkaController.text)
        .where('no_mesin', isEqualTo: _mesinController.text)
        .getDocuments();

    if (qs.documents.isEmpty) {
      Fluttertoast.showToast(msg: 'Mobil tidak ditemukan');
      return;
    }

    DocumentSnapshot ds = qs.documents.first;

    if (ds['owned']) {
      Fluttertoast.showToast(msg: 'Mobil sudah dimiliki');
      return;
    }

    String pin = (Random().nextInt(89999) + 10000).toString();

    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    Firestore.instance
        .collection('users')
        .document(user.uid)
        .collection('mobil')
        .document(ds.documentID)
        .setData({
      'no_rangka': ds['no_rangka'],
      'no_mesin': ds['no_mesin'],
      'tipe': ds['tipe'],
      'tahun': ds['tahun'],
      'owned': true,
      'pin': pin,
      'created_at': FieldValue.serverTimestamp(),
    });

    ds.reference.updateData({
      'owned': true,
      'owner': user.uid,
      'pin': pin,
    });

    Navigator.of(context).pop();
  }

  void _tambahBekas(BuildContext context) async {
    if (_rangkaController.text.isEmpty) return;
    if (_mesinController.text.isEmpty) return;
    if (_pinController.text.isEmpty) return;

    QuerySnapshot qs = await Firestore.instance
        .collection('mobil')
        .where('no_rangka', isEqualTo: _rangkaController.text)
        .where('no_mesin', isEqualTo: _mesinController.text)
        .getDocuments();

    if (qs.documents.isEmpty) {
      Fluttertoast.showToast(msg: 'Mobil tidak ditemukan');
      return;
    }

    DocumentSnapshot ds = qs.documents.first;

    if (!ds['owned']) {
      Fluttertoast.showToast(msg: 'Mobil belum dimiliki');
      return;
    }

    if (ds['pin'] != _pinController.text) {
      Fluttertoast.showToast(msg: 'PIN Salah');
      return;
    }

    String pin = (Random().nextInt(89999) + 10000).toString();

    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    Firestore.instance
        .collection('users')
        .document(ds['owner'])
        .collection('mobil')
        .document(ds.documentID)
        .delete();

    Firestore.instance
        .collection('users')
        .document(user.uid)
        .collection('mobil')
        .document(ds.documentID)
        .setData({
      'no_rangka': ds['no_rangka'],
      'no_mesin': ds['no_mesin'],
      'tipe': ds['tipe'],
      'tahun': ds['tahun'],
      'owned': true,
      'pin': pin,
      'created_at': FieldValue.serverTimestamp(),
    });

    ds.reference.updateData({
      'owned': true,
      'owner': user.uid,
      'pin': pin,
    });

    Navigator.of(context).pop();
  }

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
                        onPressed: () => _tambahBaru(context),
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
                        controller: _pinController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(hintText: 'PIN'),
                        keyboardType: TextInputType.number,
                      ),
                      RaisedButton(
                        color: MERAH,
                        textColor: Colors.white,
                        child: Text('ADD'),
                        onPressed: () => _tambahBekas(context),
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
  final String id;
  const CarDetail({Key key, @required this.id}) : super(key: key);
  @override
  _CarDetailState createState() => _CarDetailState();
}

class _CarDetailState extends State<CarDetail> {
  DocumentSnapshot _ds;

  @override
  void initState() {
    super.initState();
    Firestore.instance.collection('mobil').document(widget.id).get().then((ds) {
      setState(() {
        _ds = ds;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car Detail'),
      ),
      body: _ds == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      _ds['tipe'],
                      style: TextStyle(
                        color: MERAH,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _ds['tahun'],
                      style: TextStyle(
                        color: MERAH,
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text('Nomor Rangka'),
                    Text(
                      _ds['no_rangka'],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 8),
                    Text('Nomor Mesin'),
                    Text(
                      _ds['no_mesin'],
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 8),
                    Text('PIN'),
                    Text(
                      _ds['pin'],
                      style: TextStyle(color: MERAH, fontSize: 20),
                    ),
                    SizedBox(height: 16),
                    Image.asset(carImage(_ds['tipe'])),
                    SizedBox(height: 16),
                    Text(
                      'LATEST MAINTENANCE',
                      style: TextStyle(color: MERAH, fontSize: 20),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'REGISTERED PARTS',
                      style: TextStyle(color: MERAH, fontSize: 20),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: _ds.reference
                          .collection('spareparts')
                          .orderBy('nama')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) return Text(snapshot.error);
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return Center(child: CircularProgressIndicator());
                        return ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: snapshot.data.documents.map((doc) {
                            return ListTile(
                              title: Text(doc['nama']),
                              subtitle: Text(doc['parts_number']),
                              isThreeLine: true,
                              leading: Icon(Icons.settings),
                              onTap: () {},
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
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
