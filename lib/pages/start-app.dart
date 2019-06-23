import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xffEEEEEE)),
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "fullName",
                                  softWrap: false,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 15.0),
                                  maxLines: 1,
                                ),
                                Container(
                                  height: 10,
                                ),
                                Text(
                                  "View Profile",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.black87,
                                      fontSize: 10.0),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              // border color
                              border: Border.all(
                                  width: 5, color: Color(0xFFFAFAFA)),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: ExactAssetImage('assets/profile.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )),
      Padding(padding: EdgeInsets.only(top: 30.0 , left: 20.0 , right: 20.0),
       child: Column(children: <Widget>[
             ListTile(
                title: Text("Location" ,style: TextStyle(fontSize: 13.0 ,fontWeight: FontWeight.w600 ),),
                trailing: Icon(Icons.location_on ),
              ),
              Divider(color: Colors.grey, height: 0.0,),
             
       ],),
      )              
              
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
          backgroundColor: Colors.red,
          onTap: _onItemTapped,
        ));
  }
}


