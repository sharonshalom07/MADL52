import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF0288D1), // Blue accent
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF0288D1),
          elevation: 0,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      home: Task3App(),
    );
  }
}

class Task3App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Layout Widgets'),
          bottom: TabBar(
            indicatorColor: Color(0xFFF57C00), // Orange indicator
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(text: 'Album'),
              Tab(text: 'Notes'),
              Tab(text: 'Nav'),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0288D1), Color(0xFFF57C00)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: TabBarView(
            children: [
              AlbumPage(),
              NoteApp(),
              NavigationApp(),
            ],
          ),
        ),
      ),
    );
  }
}

class AlbumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1514320291840-2e0a9bf2a9ae?ixlib=rb-4.0.3&auto=format&fit=crop&w=600&q=80'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1470225620780-d4df7d7d3a0e?ixlib=rb-4.0.3&auto=format&fit=crop&w=150&q=80',
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Vibes of Serenity',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                Text(
                  'Luna Star',
                  style: TextStyle(fontSize: 18, color: Colors.grey[300]),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(icon: Icon(Icons.shuffle, color: Colors.white, size: 30), onPressed: () {}),
                    IconButton(icon: Icon(Icons.skip_previous, color: Colors.white, size: 30), onPressed: () {}),
                    FloatingActionButton(
                      backgroundColor: Color(0xFFF57C00),
                      onPressed: () {},
                      child: Icon(Icons.play_arrow, color: Colors.white),
                    ),
                    IconButton(icon: Icon(Icons.skip_next, color: Colors.white, size: 30), onPressed: () {}),
                    IconButton(icon: Icon(Icons.repeat, color: Colors.white, size: 30), onPressed: () {}),
                  ],
                ),
                SizedBox(height: 20),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  separatorBuilder: (context, index) => Divider(color: Colors.grey[400]),
                  itemBuilder: (context, index) => FadeTransition(
                    opacity: Tween<double>(begin: 0, end: 1).animate(
                      CurvedAnimation(
                        parent: ModalRoute.of(context)!.animation!,
                        curve: Interval(0.1 * index, 1.0, curve: Curves.easeIn),
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.music_note, color: Colors.white),
                      title: Text('Song ${index + 1}', style: TextStyle(color: Colors.white)),
                      subtitle: Text('Luna Star', style: TextStyle(color: Colors.grey[300])),
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

class NoteApp extends StatefulWidget {
  @override
  _NoteAppState createState() => _NoteAppState();
}

class _NoteAppState extends State<NoteApp> {
  List<Widget> _notes = [];

  void _addNote() {
    setState(() {
      _notes.add(Note());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: _notes),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFF57C00),
        onPressed: _addNote,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class Note extends StatefulWidget {
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> with SingleTickerProviderStateMixin {
  Offset _position = Offset(100, 100);
  double _scale = 1.0;
  late AnimationController _controller;
  late Animation<double> _animation;
  final Color _noteColor = Colors.primaries[Random().nextInt(Colors.primaries.length)].shade300;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onScaleUpdate: (details) {
          setState(() {
            _position += details.focalPointDelta; // Handle panning
            _scale = (_scale * details.scale).clamp(0.5, 2.0); // Handle scaling
          });
        },
        child: FadeTransition(
          opacity: _animation,
          child: Transform.scale(
            scale: _scale,
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: _noteColor,
              child: Container(
                width: 120,
                height: 120,
                padding: EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    'Note',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationApp extends StatefulWidget {
  @override
  _NavigationAppState createState() => _NavigationAppState();
}

class _NavigationAppState extends State<NavigationApp> with SingleTickerProviderStateMixin {
  int _currentTab = 0;
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<Widget> _pages = [
    PageWidget(index: 0, title: 'Home'),
    PageWidget(index: 1, title: 'Profile'),
    PageWidget(index: 2, title: 'Settings'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: _pages[_currentTab],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentTab,
        selectedItemColor: Color(0xFF0288D1),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        onTap: (index) {
          setState(() {
            _currentTab = index;
            _controller.forward(from: 0);
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}

class PageWidget extends StatelessWidget {
  final int index;
  final String title;

  PageWidget({required this.index, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey<int>(index),
      color: Colors.grey[100],
      child: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              title,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0288D1)),
            ),
          ),
        ),
      ),
    );
  }
}