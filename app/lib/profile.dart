import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:toyotaku/main.dart';
import 'package:toyotaku/splash.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseUser _user;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: _user == null
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(48),
                    child: Image.network(
                      _user.photoUrl,
                      width: 96,
                      height: 96,
                    ),
                  ),
                  Text(_user.displayName, style: TextStyle(fontSize: 20)),
                  Text(_user.email, style: TextStyle(color: MERAH)),
                  Text(_user.uid),
                  RaisedButton(
                    color: MERAH,
                    textColor: Colors.white,
                    child: Text('LOGOUT'),
                    onPressed: () async {
                      await GoogleSignIn().signOut();
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Splash()));
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
