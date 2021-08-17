import 'package:flutter/material.dart';
import 'package:radio/modules/Favourit.dart';
import 'package:radio/modules/Radio_Page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int cureentIndex = 0;
  final List<Widget> childern = [
    RadioPage(
      isFavouriteOnly: false,
    ),
    FavRadios()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: childern[cureentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.brown.shade300,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        showUnselectedLabels: false,
        currentIndex: cureentIndex,
        items: [
          bottomNavItem(Icons.play_arrow, "Listen"),
          bottomNavItem(Icons.favorite, "Favorite")
        ],
        onTap: onTabTapped,
      ),
    ));
  }

  bottomNavItem(IconData icon, String title) {
    return BottomNavigationBarItem(
      icon: new Icon(
        icon,
        color: Colors.black12,
      ),
      activeIcon: new Icon(
        icon,
        color: Colors.deepPurple,
      ),
      // ignore: deprecated_member_use
      title: new Text(
        title,
        style: TextStyle(
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    // Error : setState method called after dispose()?
    if (!mounted) return;
    setState(() {
      cureentIndex = index;
    });
  }
}
