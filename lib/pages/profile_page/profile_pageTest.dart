import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:safeguard_group3_project/pages/profile_page/widget/profile_widget.dart';

import '../../model/user_model.dart';
import '../../widget/appbar_widget.dart';

class ProfilePageTest extends StatefulWidget {
  @override
  _ProfilePageTestState createState() => _ProfilePageTestState();
}

class _ProfilePageTestState extends State<ProfilePageTest> {
  List user = [];
  List reports = [];
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: Future.wait([
          _getUserDetails(),
          //getUser(),
          getReports(),
        ]),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
                body: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.purple, size: 200)));
          } else {
            Map<String, dynamic> user =
                snapshot.data![0].data() as Map<String, dynamic>;
            List reports = snapshot.data![1];
            return Scaffold(
              //top bar
              appBar: buildAppBar(context, "Profile Page"),
              backgroundColor: Color.fromARGB(255, 228, 218, 218),
              //list view # maybe edit this to change the look
              body: ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  //the image method
                  ProfileWidget(
                    imagePath: "../assets/user_profile.png",
                    onClicked: () async {},
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  buildInfo(user), //user info
                  //buildContent(user.first), //user content
                  //buildActivity(user.first),
                  buildReports(reports), //container with all reports
                ],
              ),
            );
          }
        });
  }

  Widget buildInfo(Map<String, dynamic> user) => Column(
    children: [
      Text(
        user['username'], //modify if necessary
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      const SizedBox(
        height: 4,
      ),
      Text(
        user['email'], //modify if necessary
        style: TextStyle(color: Colors.black),
      ),
      const SizedBox(
        height: 4,
      ),
      // Text(
      //   "Total Points: ",
      //   style: TextStyle(color: Colors.black),
      // ),
    ],
  );

  Widget buildReports(List reports) => Container(
        //displays reports in a Container
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Reports',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            ...reports.map((report) => Text(report)).toList(),
          ],
        ),
      );

  Future<List> _getUserDetails() async {
    User? user = _auth.currentUser;
    print('Current user UID: ${user!.uid}');
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    return [doc.data()]; // This will return a list containing one map
  }

  // Future<Map<String, dynamic>> getUser() async {
  //   final curr_user = FirebaseAuth.instance.currentUser!.uid;
  //
  //   QuerySnapshot query = await FirebaseFirestore.instance
  //       .collection("users")
  //       .where("userId", isEqualTo: curr_user)
  //       .get();
  //
  //   final user = query.docs.first.data() as Map<String, dynamic>;
  //
  //   print(user);
  //
  //   return user;
  // }

  Future<List> getReports() async {
    //modify to the firebase collection
    //fetches all reports made by the current user.
    final curr_user = _auth.currentUser!.uid;

    QuerySnapshot query = await FirebaseFirestore.instance
        .collection("Reports")
        .where("userId", isEqualTo: curr_user)
        .get();

    final reports = query.docs.map((doc) => doc['report']).toList();

    return reports;
  }
}
