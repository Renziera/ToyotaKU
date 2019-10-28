import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ToyotaWorld extends StatefulWidget {
  @override
  _ToyotaWorldState createState() => _ToyotaWorldState();
}

class _ToyotaWorldState extends State<ToyotaWorld> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Toyota World'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Movies'),
              Tab(text: 'TV'),
              Tab(text: 'Playlist'),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Movies(),
            Movies(),
            Playlist(),
          ],
        ),
      ),
    );
  }
}

class Movies extends StatefulWidget {
  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  void _viewDetail({String judul, String gambar}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MovieDetail(
          judul: judul,
          gambar: gambar,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.search),
                    Text('Search'),
                  ],
                ),
                FlatButton(
                  textColor: Theme.of(context).accentColor,
                  child: Text('Filter'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          CarouselSlider(
            autoPlay: true,
            enlargeCenterPage: true,
            aspectRatio: .8,
            items: <Widget>[
              GestureDetector(
                child: Image.asset('img/countdown.jpg'),
                onTap: () => _viewDetail(
                  judul: 'Countdown',
                  gambar: 'img/countdown.jpg',
                ),
              ),
              GestureDetector(
                child: Image.asset('img/joker.jpg'),
                onTap: () => _viewDetail(
                  judul: 'Joker',
                  gambar: 'img/joker.jpg',
                ),
              ),
              GestureDetector(
                child: Image.asset('img/maleficent.jpg'),
                onTap: () => _viewDetail(
                  judul: 'Maleficent',
                  gambar: 'img/maleficent.jpg',
                ),
              ),
              GestureDetector(
                child: Image.asset('img/the_addams_family.jpg'),
                onTap: () => _viewDetail(
                  judul: 'The Addams Family',
                  gambar: 'img/the_addams_family.jpg',
                ),
              ),
              GestureDetector(
                child: Image.asset('img/zombieland_double_tap.jpg'),
                onTap: () => _viewDetail(
                  judul: 'Zombieland: Double Tap',
                  gambar: 'img/zombieland_double_tap.jpg',
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Exclusive',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                FlatButton(
                  textColor: Theme.of(context).accentColor,
                  child: Text('SEE ALL'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => _viewDetail(
                    judul: 'The Fellowship of the Ring',
                    gambar: 'img/lotr1.jpg',
                  ),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(4)),
                            child: Image.asset('img/lotr1.jpg', height: 200)),
                        SizedBox(height: 8),
                        Text('Fellowship of the Ring'),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _viewDetail(
                    judul: 'The Two Towers',
                    gambar: 'img/lotr2.jpg',
                  ),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(4)),
                            child: Image.asset('img/lotr2.jpg', height: 200)),
                        SizedBox(height: 8),
                        Text('The Two Towers'),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _viewDetail(
                    judul: 'The Return of the King',
                    gambar: 'img/lotr3.jpg',
                  ),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(4)),
                            child: Image.asset('img/lotr3.jpg', height: 200)),
                        SizedBox(height: 8),
                        Text('The Return of the King'),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _viewDetail(
                    judul: 'On Stranger Tides',
                    gambar: 'img/carib1.jpg',
                  ),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(4)),
                            child: Image.asset('img/carib1.jpg', height: 200)),
                        SizedBox(height: 8),
                        Text('On Stranger Tides'),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _viewDetail(
                    judul: 'Dead Men Tell No Tales',
                    gambar: 'img/carib2.jpg',
                  ),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(4)),
                            child: Image.asset('img/carib2.jpg', height: 200)),
                        SizedBox(height: 8),
                        Text('Dead Men Tell No Tales'),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'New Releases',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                FlatButton(
                  textColor: Theme.of(context).accentColor,
                  child: Text('SEE ALL'),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () => _viewDetail(
                    judul: 'Doctor Sleep',
                    gambar: 'img/doctor_sleep.jpg',
                  ),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(4)),
                            child: Image.asset('img/doctor_sleep.jpg',
                                height: 200)),
                        SizedBox(height: 8),
                        Text('Doctor Sleep'),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _viewDetail(
                    judul: 'Honey Boy',
                    gambar: 'img/honey_boy.jpg',
                  ),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(4)),
                            child:
                                Image.asset('img/honey_boy.jpg', height: 200)),
                        SizedBox(height: 8),
                        Text('Honey Boy'),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _viewDetail(
                    judul: 'Last Christmas',
                    gambar: 'img/last_christmas.jpg',
                  ),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(4)),
                            child: Image.asset('img/last_christmas.jpg',
                                height: 200)),
                        SizedBox(height: 8),
                        Text('Last Christmas'),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _viewDetail(
                    judul: 'Midway',
                    gambar: 'img/midway.jpg',
                  ),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(4)),
                            child: Image.asset('img/midway.jpg', height: 200)),
                        SizedBox(height: 8),
                        Text('Midway'),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => _viewDetail(
                    judul: 'The Kingmaker',
                    gambar: 'img/the_kingmaker.jpg',
                  ),
                  child: Card(
                    child: Column(
                      children: <Widget>[
                        ClipRRect(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(4)),
                            child: Image.asset('img/the_kingmaker.jpg',
                                height: 200)),
                        SizedBox(height: 8),
                        Text('The Kingmaker'),
                        SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MovieDetail extends StatefulWidget {
  final String judul;
  final String gambar;

  const MovieDetail({Key key, @required this.judul, @required this.gambar})
      : super(key: key);
  @override
  _MovieDetailState createState() => _MovieDetailState();
}

class _MovieDetailState extends State<MovieDetail> {
  bool _lagiServis = false;

  @override
  void initState() {
    super.initState();
    _cekLagiServis();
  }

  void _cekLagiServis() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot ds =
        await Firestore.instance.collection('users').document(user.uid).get();
    setState(() {
      _lagiServis = ds.data['servis'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(widget.judul),
              background: Image.asset(widget.gambar, fit: BoxFit.cover),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            widget.judul,
                            style: TextStyle(
                                color: Colors.brown,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          SizedBox(height: 16),
                          Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                          SizedBox(height: 16),
                          Text(
                              'Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Sed non sem nec sem dictum eleifend. Nam varius, mauris ut ullamcorper dignissim, ante urna imperdiet urna, a lobortis orci neque egestas tortor. Phasellus scelerisque tempor dapibus. Nunc dignissim ac dui id iaculis. Curabitur ut sem nec nibh efficitur ornare nec sed odio. Nam sit amet purus odio. Vestibulum eleifend urna sit amet magna condimentum, at volutpat eros ultricies.'),
                          Divider(),
                          SizedBox(height: 16),
                          _lagiServis
                              ? RaisedButton(
                                  color: Colors.green,
                                  textColor: Colors.white,
                                  child: Text('WATCH MOVIE'),
                                  onPressed: () {},
                                )
                              : SizedBox.shrink(),
                          RaisedButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text('WATCH TRAILER'),
                            onPressed: () {},
                          ),
                          RaisedButton(
                            color: Colors.yellow,
                            textColor: Colors.white,
                            child: Text('ADD TO PLAYLIST'),
                            onPressed: () async {
                              FirebaseUser user =
                                  await FirebaseAuth.instance.currentUser();
                              Firestore.instance
                                  .collection('users')
                                  .document(user.uid)
                                  .collection('playlist')
                                  .add({
                                'judul': widget.judul,
                                'gambar': widget.gambar,
                                'created_at': FieldValue.serverTimestamp(),
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SliverFillRemaining(),
        ],
      ),
    );
  }
}

class Playlist extends StatefulWidget {
  @override
  _PlaylistState createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  String _uid;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _uid = user.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_uid == null) return Center(child: CircularProgressIndicator());
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection('users')
          .document(_uid)
          .collection('playlist')
          .orderBy('created_at')
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());
        return ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return ListTile(
              title: Text(document['judul']),
              leading: Image.asset(document['gambar']),
              subtitle: Text('Lorem ipsum dolor sit amet, consectetur'),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MovieDetail(
                    judul: document['judul'],
                    gambar: document['gambar'],
                  ),
                ),
              ),
              onLongPress: () {
                document.reference.delete();
              },
            );
          }).toList(),
        );
      },
    );
  }
}
