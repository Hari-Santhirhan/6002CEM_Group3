import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safeguard_group3_project/report_model.dart';
import 'package:safeguard_group3_project/report_view_page.dart';

class ReportViewModel extends ChangeNotifier {
  ReportModel reportModel = ReportModel();

  Future<void> submitReport(ReportModel report) async {
    try {
      // Access the Firestore collection
      final CollectionReference reportsCollection =
      FirebaseFirestore.instance.collection('report_submissions');

      // Convert the report model to a map
      Map<String, dynamic> reportData = report.toMap();

      // Add the report to Firestore
      await reportsCollection.doc(report.reportId).set(reportData);

      // Notify listeners that the operation is complete
      notifyListeners();
    } catch (error) {
      // Handle any errors that occur during the process
      print('Error submitting report: $error');
    }
  }
}
