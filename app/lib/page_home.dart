import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final Function setPage;

  const HomePage({Key key, @required this.setPage}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToyotaKU'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder<FirebaseUser>(
                    future: FirebaseAuth.instance.currentUser(),
                    builder: (BuildContext context,
                        AsyncSnapshot<FirebaseUser> snapshot) {
                      if (snapshot.connectionState != ConnectionState.done)
                        return SizedBox(height: 96);
                      return Row(
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(96),
                            child: Image.network(
                              snapshot.data.photoUrl,
                              height: 96,
                              width: 96,
                            ),
                          ),
                          SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data.displayName,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                snapshot.data.email,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: SizedBox(
                      height: 96,
                      width: 72,
                      child: Center(child: Text('A')),
                    ),
                    onPressed: () => widget.setPage(2),
                  ),
                  FlatButton(
                    child: SizedBox(
                      height: 96,
                      width: 72,
                      child: Center(child: Text('B')),
                    ),
                    onPressed: () => widget.setPage(1),
                  ),
                  FlatButton(
                    child: SizedBox(
                      height: 96,
                      width: 72,
                      child: Center(child: Text('C')),
                    ),
                    onPressed: () => widget.setPage(3),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    child: SizedBox(
                      height: 96,
                      width: 72,
                      child: Center(child: Text('D')),
                    ),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: SizedBox(
                      height: 96,
                      width: 72,
                      child: Center(child: Text('E')),
                    ),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: SizedBox(
                      height: 96,
                      width: 72,
                      child: Center(child: Text('F')),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 128,
                      width: 256,
                      color: Colors.orange,
                    ),
                    SizedBox(width: 16),
                    Container(
                      height: 128,
                      width: 256,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(height: 150, color: Colors.teal),
              SizedBox(height: 16),
              Container(height: 150, color: Colors.indigo),
            ],
          ),
        ),
      ),
    );
  }
}