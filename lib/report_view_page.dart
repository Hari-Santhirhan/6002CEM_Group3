import 'dart:io';
import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/report_viewModel_page.dart';
import 'package:safeguard_group3_project/list/category_list.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final ReportViewModel reportViewModel = ReportViewModel();
  String? selectedCategory;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();

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
        ),
        body: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
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
              height: 200,
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
              height: 100,
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
              height: 80,
              width: 200,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                color: Color(0xFFD9D9D9),
              ),
              child: FloatingActionButton(
                onPressed: () {
                  // Logic Code for report button press
                  reportViewModel.submitReport();
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
