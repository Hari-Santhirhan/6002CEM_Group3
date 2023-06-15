import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../model/user_model.dart';
import '../../widget/appbar_widget.dart';
import 'widget/profile_widget.dart';

class ProfilePageTest extends StatefulWidget {
  @override
  _ProfilePageTestState createState() => _ProfilePageTestState();
}

class _ProfilePageTestState extends State<ProfilePageTest> {
  List user = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //top bar
      appBar: buildAppBar(context, "Profile Page"),
      backgroundColor: Color.fromARGB(255, 228, 218, 218),
      //list view # maybe edit this to change the look

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ProfileWidget(
              imagePath: "../assets/user_profile.png",
              onClicked: () {
                // Handle profile picture click event here
                // For example, you can navigate to an image picker page
              },
            ),
            SizedBox(height: 16),
            Text('Name: Victor', style: TextStyle(fontSize: 20)),
            Text('Gender: Male', style: TextStyle(fontSize: 20)),
            Text('Email: victor.email', style: TextStyle(fontSize: 20)),
            Text('Date: 12 May', style: TextStyle(fontSize: 20)),
            Text('Report: Fire Hazard', style: TextStyle(fontSize: 20)),
            Text('Location: Penang',
                style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
