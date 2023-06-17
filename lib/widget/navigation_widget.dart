import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/pages/map_page/maps_page.dart';
import 'package:safeguard_group3_project/pages/settings_page/setting_page.dart';

import '../pages/contacts_page/contact_list_trial_2.dart';

class Navigation extends StatefulWidget{
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State {
  int _selectedIndex = 0;
  static List<Widget> _pages = <Widget>[
    //HomePage()
    MapsPage(),
    ContactListPageTrial2(),
    //ProfilePage(),
    SettingsPage(),
    //modify to our bottom navigation
    //Make it in order
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex), //New
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // this will be set when a new tab is tapped
        items: [
          // BottomNavigationBarItem(
          //   icon: new Icon(Icons.home),
          //   label: "Home",
          // ),
          BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: "Map"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.phone_android),
              label: "Contacts"
          ),
          // BottomNavigationBarItem(
          //   icon: new Icon(Icons.person_rounded),
          //   label: "Profile",
          // ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Settings"
          )
        ],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}