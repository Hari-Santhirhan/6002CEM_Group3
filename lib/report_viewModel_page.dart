import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safeguard_group3_project/report_model.dart';
import 'package:safeguard_group3_project/report_view_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ReportViewModel extends ChangeNotifier {
  ReportModel reportModel = ReportModel();

  Future<void> submitReport(ReportModel report, BuildContext context) async {
    try {
      // Check if any of the details are missing
      if (report.title == null ||
          report.desc == null ||
          report.location == null ||
          report.category == null ||
          report.userId == null ||
          report.imageURL == '' ||
          report.imageURL == "" ||
          report.imageURL!.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Incomplete Details'),
              content: Text('Please enter all details before submitting.'),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        return;
      }

      // Access the Firestore collection
      final CollectionReference reportsCollection =
          FirebaseFirestore.instance.collection('report_submissions');

      // Convert the report model to a map
      Map<String, dynamic> reportData = report.toMap();

      // Add the report to Firestore
      await reportsCollection.doc(report.reportId).set(reportData);

      // Show a dialog indicating successful submission
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Submission Successful'),
            content: Text('Report submitted successfully to Firestore.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  reportModel.imageURL = null;
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );

      // Notify listeners that the operation is complete
      notifyListeners();
    } catch (error) {
      // Handle any errors that occur during the process
      print('Error submitting report: $error');
    }
  }

  Future<XFile?> uploadImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? capturedImage =
        await imagePicker.pickImage(source: ImageSource.camera);
    return capturedImage;
  }
}
