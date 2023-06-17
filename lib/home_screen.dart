import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safeguard_group3_project/pages/contacts_page/contact_list_trial_2.dart';
import 'package:safeguard_group3_project/pages/map_page/maps_page.dart';
import 'package:safeguard_group3_project/pages/settings_page/setting_page.dart';
import 'package:safeguard_group3_project/report_view_page.dart';
import 'package:safeguard_group3_project/utils/colors_util.dart';
import 'package:safeguard_group3_project/utils/date_utils.dart' as date_util;

class HomePage extends StatefulWidget {
  final String title;
  final String userId;

  const HomePage({Key? key, required this.title, required this.userId})
      : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  double width = 0.0;
  double height = 0.0;
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  int _selectedIndex = 0;

  @override
  void initState() {
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
    super.initState();
    fetchUserId();
  }

  void _onItemTapped(int index) {
    // Handle navigation based on the index
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(title: 'Home', userId: 'userId')),
      );

    }else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ReportPage()),
      );
    }
    else if (index == 2) {
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



  Future<void> fetchUserId() async {
    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();

      if (userSnapshot.exists) {
        // Get the userId from the user document
        String userId = userSnapshot.id;

        print('Fetched userId: $userId');
      } else {
        // Handle the case where the user document is not found
        print('User not found');
      }
    } catch (e) {
      print('Error fetching userId: $e');
    }
  }



  Widget backgroundView() {
    return Container(
      decoration: BoxDecoration(
        color: HexColor("FFEAEAEA"),
      ),
    );
  }

  Widget titleView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Text(
        date_util.DateUtils.months[currentDateTime.month - 1] +
            ' ' +
            currentDateTime.year.toString(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 30,
        ),
      ),
    );
  }

  Widget hrizontalCapsuleListView() {
    return Column(
      children: [
        Container(
          width: width,
          height: 150,
          child: ListView.builder(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemCount: currentMonthList.length,
            itemBuilder: (BuildContext context, int index) {
              return capsuleView(index);
            },
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget capsuleView(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Container(
        width: 80,
        height: 140,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: (currentMonthList[index].day != currentDateTime.day)
                ? [
              Colors.white.withOpacity(0.8),
              Colors.white.withOpacity(0.7),
              Colors.white.withOpacity(0.6)
            ]
                : [
              HexColor("ED6184"),
              HexColor("EF315B"),
              HexColor("E2042D")
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: const [0.0, 0.5, 1.0],
            tileMode: TileMode.clamp,
          ),
          borderRadius: BorderRadius.circular(40),
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, 4),
              blurRadius: 4,
              spreadRadius: 2,
              color: Colors.black12,
            )
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                currentMonthList[index].day.toString(),
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: (currentMonthList[index].day != currentDateTime.day)
                      ? HexColor("149EBD") //!unhighlighted date color (12)
                      : Colors.white,
                ),
              ),
              Text(
                date_util.DateUtils.weekdays[currentMonthList[index].weekday - 1],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: (currentMonthList[index].day != currentDateTime.day)
                      ? HexColor("A4351D") //unhighlighted day color (monday)
                      : Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget topView() {
    return ListView(
      children: <Widget>[
        Container(
          height: height * 0.35,
          width: width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexColor("488BC8").withOpacity(0.7),
                HexColor("488BC8").withOpacity(0.5),
                HexColor("488BC8").withOpacity(0.3),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: const [0.0, 0.5, 1.0],
              tileMode: TileMode.clamp,
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 4,
                color: Colors.black12,
                offset: Offset(4, 4),
                spreadRadius: 2,
              ),
            ],
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              titleView(),
              hrizontalCapsuleListView(),
            ],
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: 200,
          height: 100,
          child: ElevatedButton(
            onPressed: () {
              // Handle news button press
              // Navigate to news page or perform desired action
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
              ),
            ),
            child: Text(
              "News",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          width: 200,
          height: 100,
          child: ElevatedButton(
            onPressed: () {
              // Handle news button press
              // Navigate to news page or perform desired action
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
              ),
            ),
            child: Text(
              "Report",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        // Add the desired navigation elements to the AppBar
        // Example: leading, actions, etc.
        title: Text(widget.title),
        automaticallyImplyLeading: false, // Remove the back button
      ),
      body: Stack(
        children: <Widget>[
          backgroundView(),
          topView(),
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
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}