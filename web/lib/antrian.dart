import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';

class Antrian extends StatefulWidget {
  @override
  _AntrianState createState() => _AntrianState();
}

class _AntrianState extends State<Antrian> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore()
          .collection('antrian')
          .orderBy('created_at', 'asc')
          .onSnapshot,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Center(child: Text(snapshot.error));
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        return ListView(
          children: snapshot.data.docs.map((doc) {
            return ListTile(
              title: Text(doc.data()['tipe']),
              subtitle:
                  Text(doc.data()['no_rangka'] + '\n' + doc.data()['no_mesin']),
              isThreeLine: true,
              trailing: RaisedButton(
                color: Colors.red,
                textColor: Colors.white,
                child: Text('SELESAI'),
                onPressed: () {
                  var data = doc.data();
                  firestore()
                      .collection('users')
                      .doc(data['owner'])
                      .update(data: {'servis': false});

                  firestore()
                      .collection('mobil')
                      .doc(data['id_mobil'])
                      .collection('servis')
                      .add({
                        'masuk': data['created_at'],
                        'keluar': FieldValue.serverTimestamp(),
                      });
                  
                  doc.ref.delete();
                },
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
