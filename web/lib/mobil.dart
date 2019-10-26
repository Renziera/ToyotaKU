import 'package:firebase/firebase.dart';
import 'package:firebase/firestore.dart';
import 'package:flutter/material.dart';

class Mobil extends StatefulWidget {
  @override
  _MobilState createState() => _MobilState();
}

class _MobilState extends State<Mobil> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestore()
          .collection('mobil')
          .orderBy('created_at', 'desc')
          .onSnapshot,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Center(child: Text(snapshot.error));
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        return ListView(
          children: snapshot.data.docs.map((doc){
            return ListTile(
              title: Text(doc.data()['tipe']),
            );
          }).toList(),
        );
      },
    );
  }
}
