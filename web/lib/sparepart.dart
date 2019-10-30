import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';

class SparePart extends StatefulWidget {
  @override
  _SparePartState createState() => _SparePartState();
}

class _SparePartState extends State<SparePart> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore()
          .collection('spareparts')
          .orderBy('created_at', 'desc')
          .onSnapshot,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Center(child: Text(snapshot.error));
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        return ListView(
          children: snapshot.data.docs.map((doc) {
            return ListTile(
              title: Text(doc.data()['nama']),
              subtitle:
                  Text(doc.data()['parts_number'] + '\n' + doc.data()['mobil']),
              isThreeLine: true,
            );
          }).toList(),
        );
      },
    );
  }
}
