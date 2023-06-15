import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String id;
  final String user;
  final String report;
  final GeoPoint location;

  Report({
    required this.id,
    required this.user,
    required this.report,
    required this.location,
  });

  factory Report.fromDocument(DocumentSnapshot doc) {
    return Report(
      id: doc.id,
      user: doc['user'],
      report: doc['report'],
      location: doc['location'],
    );
  }
}