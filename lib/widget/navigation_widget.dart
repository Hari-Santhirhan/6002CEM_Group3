import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/home_screen.dart';
import 'package:safeguard_group3_project/pages/map_page/maps_page.dart';
import 'package:safeguard_group3_project/pages/settings_page/setting_page.dart';
import '../pages/contacts_page/contact_list_trial_2.dart';

class Navigation extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  Navigation({required this.selectedIndex, required this.onItemTapped});

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  static List<Widget> _pages = <Widget>[
    HomePage(title: '', userId: ''),
    MapsPage(),
    ContactListPageTrial2(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Map",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_android),
            label: "Contacts",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
        selectedItemColor: Colors.blue, // Set the selected icon color
        unselectedItemColor: Colors.black, // Set the unselected icon color
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Call the callback function passed from HomePage

    widget.onItemTapped(index);
  }
}
