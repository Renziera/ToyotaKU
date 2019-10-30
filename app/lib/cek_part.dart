import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:toyotaku/main.dart';

class CekPart extends StatefulWidget {
  @override
  _CekPartState createState() => _CekPartState();
}

class _CekPartState extends State<CekPart> {
  QRViewController _controller;

  void _onQRViewCreated(QRViewController controller) {
    this._controller = controller;
    controller.scannedDataStream.listen((data) async {
      controller.pauseCamera();
      Fluttertoast.showToast(msg: 'Checking code...');
      QuerySnapshot qs = await Firestore.instance
          .collection('spareparts')
          .where('kode', isEqualTo: data)
          .getDocuments();
      if (qs.documents.isEmpty) {
        Fluttertoast.showToast(msg: 'Kode tidak valid');
        controller.resumeCamera();
        return;
      }
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PartDetail(
            ds: qs.documents.first,
          ),
        ),
      );
      controller.resumeCamera();
    });
  }

  void _inputKode() async {
    _controller.pauseCamera();
    String kode = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: TextField(
            decoration: InputDecoration(hintText: 'Kode Unik'),
            onSubmitted: (s) => Navigator.of(context).pop(s),
          ),
        );
      },
    );

    if (kode == null) {
      _controller.resumeCamera();
      return;
    }

    Fluttertoast.showToast(msg: 'Checking code...');
    QuerySnapshot qs = await Firestore.instance
        .collection('spareparts')
        .where('kode', isEqualTo: kode)
        .getDocuments();
    if (qs.documents.isEmpty) {
      Fluttertoast.showToast(msg: 'Kode tidak valid');
      _controller.resumeCamera();
      return;
    }
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PartDetail(
          ds: qs.documents.first,
        ),
      ),
    );
    _controller.resumeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Parts'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Tidak bisa scan?',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Coba masukkan kode',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                RaisedButton(
                  textColor: MERAH,
                  child: Text('KODE'),
                  onPressed: _inputKode,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          QRView(
            key: GlobalKey(debugLabel: 'QR'),
            onQRViewCreated: _onQRViewCreated,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.flip),
                color: MERAH,
                onPressed: () {
                  _controller.flipCamera();
                },
              ),
              IconButton(
                icon: Icon(Icons.flash_on),
                color: MERAH,
                onPressed: () {
                  _controller.toggleFlash();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PartDetail extends StatefulWidget {
  final DocumentSnapshot ds;
  const PartDetail({Key key, @required this.ds}) : super(key: key);
  @override
  _PartDetailState createState() => _PartDetailState();
}

class _PartDetailState extends State<PartDetail> {
  void _pilihMobil() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    bool result = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection('users')
                  .document(user.uid)
                  .collection('mobil')
                  .orderBy('created_at', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) return Text(snapshot.error);
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(child: CircularProgressIndicator());
                return ListView(
                  shrinkWrap: true,
                  children: snapshot.data.documents.map((doc) {
                    return ListTile(
                      title: Text(doc['tipe']),
                      onTap: () {
                        Firestore.instance
                            .collection('mobil')
                            .document(doc.documentID)
                            .collection('spareparts')
                            .add(widget.ds.data);
                        widget.ds.reference.updateData({'new': false});
                        Navigator.of(context).pop(true);
                      },
                    );
                  }).toList(),
                );
              },
            ),
          );
        });
    if (result ?? false) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Part Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'ORIGINAL',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: MERAH,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text('Nama'),
            Text(widget.ds['nama'], style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Parts Number'),
            Text(widget.ds['parts_number'], style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Tipe Mobil'),
            Text(widget.ds['mobil'], style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Kode'),
            Text(widget.ds['kode'], style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Kondisi'),
            Text(
              widget.ds['new'] ? 'BRAND NEW' : 'SECOND HAND',
              style: TextStyle(
                fontSize: 18,
                color: MERAH,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'REGISTERED',
              style: TextStyle(
                fontSize: 18,
                color: MERAH,
              ),
            ),
            SizedBox(height: 8),
            RaisedButton(
              color: MERAH,
              textColor: Colors.white,
              child: Text('ADD TO MY CAR'),
              onPressed: _pilihMobil,
            ),
          ],
        ),
      ),
    );
  }
}
