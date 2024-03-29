import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/pages/contacts_page/contact_list_trial_2.dart';
import 'package:safeguard_group3_project/pages/map_page/maps_page.dart';
import 'package:safeguard_group3_project/pages/settings_page/setting_page.dart';
import 'package:safeguard_group3_project/report_model.dart';
import 'package:safeguard_group3_project/report_viewModel_page.dart';
import 'package:safeguard_group3_project/list/category_list.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'home_screen.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int _selectedIndex = 1;
  final ReportViewModel reportViewModel = ReportViewModel();
  String? selectedCategory;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  User? userId;
  String userID = "";
  XFile? capturedImage = null;
  String imageURL = "";

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }

  bool shouldDisplayLabel(String? text) {
    return text == null || text.isEmpty;
  }

  void _onItemTapped(int index) {
    // Handle navigation based on the index
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage(title: 'Home', userId: 'userId')),
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
    return ChangeNotifierProvider<ReportViewModel>(
      create: (context) => ReportViewModel(),
      child: Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text(
            "Emergency/Disaster Response",
            style: TextStyle(fontFamily: 'Roboto', color: Colors.black),
          ),
          automaticallyImplyLeading: false, // Remove the back button
        ),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                color: Color(0xFFD9D9D9),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (capturedImage != null)
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          child: Image.file(
                            File(capturedImage!.path),
                            fit: BoxFit.contain,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: IconButton(
                            onPressed: () {
                              capturedImage = null;
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    Transform.scale(
                      scale: 4.0,
                      child: Icon(
                        Icons.upload,
                      ),
                    ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: 250,
                    child: FloatingActionButton(
                      onPressed: () async {
                        capturedImage = await reportViewModel.uploadImage();
                        setState(() {});
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      backgroundColor: Color(0xFF37EE49),
                      child: Text(
                        "Upload Image",
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 17,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                color: Color(0xFFD9D9D9),
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  shouldDisplayLabel(titleController.text)
                      ? Positioned(
                    left: 10,
                    child: Text(
                      'Title',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                    ),
                  )
                      : SizedBox(),
                  TextField(
                    controller: titleController,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                color: Color(0xFFD9D9D9),
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  shouldDisplayLabel(descriptionController.text)
                      ? Positioned(
                    left: 10,
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                    ),
                  )
                      : SizedBox(),
                  TextField(
                    controller: descriptionController,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 15.0),
            Container(
              height: 60,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                color: Color(0xFFD9D9D9),
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  shouldDisplayLabel(locationController.text)
                      ? Positioned(
                    left: 10,
                    child: Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Roboto',
                        color: Colors.black,
                      ),
                    ),
                  )
                      : SizedBox(),
                  TextField(
                    controller: locationController,
                    maxLines: null,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.0),
            SizedBox(height: 5.0),
            Container(
              height: 80,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                color: Color(0xFFD9D9D9),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText:
                    shouldDisplayLabel(selectedCategory) ? 'Category' : '',
                    labelStyle: TextStyle(
                      fontSize: 20.0,
                      fontFamily: 'Roboto',
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 10),
                  ),
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  items: categories.map<DropdownMenuItem<String>>(
                        (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 20),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                color: Color(0xFFD9D9D9),
              ),
              child: Consumer<ReportViewModel>(
                builder: (context, reportViewModel, _) {
                  return FloatingActionButton(
                    onPressed: () async {
                      // Generate report ID
                      String reportId =
                      DateTime.now().microsecondsSinceEpoch.toString();

                      final FirebaseAuth _auth = FirebaseAuth.instance;

                      String _getUserId() {
                        User? currentUser = FirebaseAuth.instance.currentUser;
                        if (currentUser != null) {
                          String userId = currentUser.uid;
                          return userId;
                        } else {
                          throw Exception('User not logged in');
                        }
                      }

                      userID = _getUserId().toString();

                      if (capturedImage != null) {
                        String uniqueImageFileName =
                        DateTime.now().millisecondsSinceEpoch.toString();

                        // Get storage root ref
                        Reference referenceRoot =
                        FirebaseStorage.instance.ref();
                        Reference referenceDirImages =
                        referenceRoot.child('images');

                        // Create ref for image to be stored
                        Reference referenceImageUpload =
                        referenceDirImages.child(uniqueImageFileName);

                        try {
                          // Store file
                          await referenceImageUpload
                              .putFile(File(capturedImage!.path));
                          // Success! Get download URL
                          imageURL =
                          await referenceImageUpload.getDownloadURL();
                        } catch (e) {
                          print('Error uploading image: $e');;
                        }
                      }

                      // Create a ReportModel instance
                      ReportModel report = ReportModel(
                        title: titleController.text,
                        desc: descriptionController.text,
                        location: locationController.text,
                        category: selectedCategory,
                        reportId: reportId,
                        imageURL: imageURL,
                        userId: userID,
                        reportStatus: "Reported",
                      );

                      // Submit report to Firestore
                      await reportViewModel.submitReport(report, context);

                      // Clear input fields
                      titleController.clear();
                      descriptionController.clear();
                      locationController.clear();
                      setState(() {
                        selectedCategory = null;
                        capturedImage = null;
                      });
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    backgroundColor: Colors.blue,
                    child: Text(
                      "Submit Report",
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 25,
                        color: Colors.black,
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
          unselectedItemColor:
          Colors.black, // Set unselected icon color to black
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
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
            // Add other bottom navigation bar items as needed
          ],
        ),
      ),
    );
  }
}
