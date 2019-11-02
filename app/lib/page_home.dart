import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toyotaku/main.dart';

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
                color: MERAH,
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
                  GestureDetector(
                    onTap: () => widget.setPage(2),
                    child: Image.asset('img/legit.png', height: 96, width: 96),
                  ),
                  GestureDetector(
                    onTap: () => widget.setPage(1),
                    child:
                        Image.asset('img/my_cars.png', height: 96, width: 96),
                  ),
                  GestureDetector(
                    onTap: () => widget.setPage(3),
                    child: Image.asset('img/world.png', height: 96, width: 96),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Image.asset('img/sched.png', height: 96, width: 96),
                  Image.asset('img/book.png', height: 96, width: 96),
                  Image.asset('img/more.png', height: 96, width: 96),
                ],
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    Image.asset('img/card1.png'),
                    SizedBox(width: 16),
                    Image.asset('img/card2.png'),
                    SizedBox(width: 16),
                    Image.asset('img/card3.png'),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Image.asset('img/card4.png'),
              SizedBox(height: 16),
              Image.asset('img/card5.png'),
              SizedBox(height: 16),
              Image.asset('img/card6.png'),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
