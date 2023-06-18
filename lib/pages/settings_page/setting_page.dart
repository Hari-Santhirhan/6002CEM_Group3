import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/home_screen.dart';
import 'package:safeguard_group3_project/pages/contacts_page/contact_list_trial_2.dart';
import 'package:safeguard_group3_project/pages/map_page/maps_page.dart';
import 'package:safeguard_group3_project/report_view_page.dart';
import 'package:safeguard_group3_project/widget/settings_appbar_widget.dart';

import '../profile_page/profile_pageTest2.dart';
import '../profile_page/profile_pageTest3.dart';
// Other imports...

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int _selectedIndex = 4; // Set the initial selected index to 3 (Settings)

  void _onItemTapped(int index) {
    // Handle navigation based on the index
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(title: 'Home', userId: 'userId')),
      );
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ReportPage()),
      );
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MapsPage()),
      );
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ContactListPageTrial2()),
      );
    } else if (index == 4) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SettingsPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 43, 91, 45),
        title: Text(
          'Setting',
          style: TextStyle(fontSize: 20),
        ),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      backgroundColor: Color.fromRGBO(156, 180, 171, 1),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: 70,
          ),
          Container(
            constraints: BoxConstraints(maxHeight: double.infinity),
            decoration: BoxDecoration(
              color: Color.fromARGB(116, 115, 150, 74),
              border: Border.all(width: 3),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              child: Text(
                'Profile Page',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePageTest3()),
                );
              },
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Container(
            constraints: BoxConstraints(maxHeight: double.infinity),
            decoration: BoxDecoration(
              color: Color.fromARGB(116, 115, 150, 74),
              border: Border.all(width: 3),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              child: Text(
                'Logout',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                //signout and go to login page
                Navigator.of(context).pop(); //#uncomment these when login complete
                Navigator.of(context).pushReplacementNamed('/'); //#uncomment these when login complete
                FirebaseAuth.instance.signOut(); //#uncomment these when login complete
              },
            ),
          ),
          SizedBox(
            height: 70,
          ),
          Container(
            constraints: BoxConstraints(maxHeight: double.infinity),
            decoration: BoxDecoration(
              color: Color.fromARGB(116, 115, 150, 74),
              border: Border.all(width: 3),
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.black,
              ),
              child: Text(
                'Credits',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    //title
                    title: Text(
                      "Application",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        //add fontFamily to change font (add in the pubspec.yaml)
                      ),
                    ),

                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // box behind the TWEEN
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 222, 202, 186),
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "SafeGuard",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Spacing between Company & Developers
                        SizedBox(
                          height: 100,
                          width: 40,
                          // child: DecoratedBox(
                          //   decoration: BoxDecoration(color: Colors.red), ),
                        ),
                        Text(
                          "Developers",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        //Andrea Container
                        Container(
                          height: 50,
                          width: 500,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 222, 202, 186),
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "Hari Santhiran",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Darshanaa Container
                        Container(
                          height: 50,
                          width: 900,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 222, 202, 186),
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "Darshanaa Theivendran",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Rajadurai Container
                        Container(
                          height: 50,
                          width: 900,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 222, 202, 186),
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "Rajadurai Kannan",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        //Oscar Container
                        Container(
                          height: 50,
                          width: 900,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 222, 202, 186),
                            border: Border.all(width: 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          padding: const EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          child: Text(
                            "Oscar Cser",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blue, // Set selected icon color to blue
          unselectedItemColor: Colors.black, // Set unselected icon color to black
          currentIndex: _selectedIndex,
          items: [
      BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: "Home",
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.report_problem),
    label: "Report",
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.map),
    label: "Map",
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.contacts),
    label: "Contacts",
    ),
    BottomNavigationBarItem(
    icon: Icon(Icons.settings),
    label: "Settings",
    ),   ],
        onTap: _onItemTapped,
      ),
    );
  }
}

