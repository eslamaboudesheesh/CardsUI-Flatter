import 'package:flutter/material.dart';
import 'package:startagain/pages/splash_screen.dart';
import '../widget/ProductCard.dart';
import '../widget/CustomIcon.dart';
import 'homepage.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Container(
      child: Homepage(),
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 3: School',
      style: optionStyle,
    ),
    Text(
      'Index 4: School',
      style: optionStyle,
    ),
  ];





  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            actions: <Widget>[],
            title: Padding(
              padding: EdgeInsets.only(top: 0, bottom: 0),
              child: Image.asset("assets/logo.png", width: 62.0, height: 43.0),
            )),
        drawer: Drawer(
          elevation: 6.0,
          child: ListView(
            children: <Widget>[
              ListTile(
                title: Text("Ttem 1"),
                trailing: Icon(Icons.arrow_forward),
              ),
              ListTile(
                title: Text("Item 2"),
                trailing: Icon(Icons.arrow_forward),
              ),
            ],
          ),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: new Image.asset('assets/store.png',
                  width: 25.0, height: 25.0),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.search,
                size: 23.0,
                color: Colors.black,
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.favorite,
                size: 25.0,
                color: Colors.black,
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                CustomIcons.cart,
                size: 25.0,
                color: Colors.black,
              ),
              title: Text(''),
            ),
            BottomNavigationBarItem(
              icon: new Image.asset(
                'assets/profile.png',
                width: 25.0,
                height: 25.0,
              ),
              title: Text(''),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedFontSize: 5.0,
          elevation: 5.0,
          backgroundColor:  Colors.red,
          onTap: _onItemTapped,
        ));
  }
}

