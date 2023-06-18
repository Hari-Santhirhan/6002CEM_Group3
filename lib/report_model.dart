import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  String? title;
  String? desc;
  String? location;
  String? category;
  String? reportId;
  String? imageURL;
  String? userId;
  String? reportStatus;

  ReportModel({
    this.title,
    this.desc,
    this.location,
    this.category,
    this.reportId,
    this.imageURL,
    this.userId,
    this.reportStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'desc': desc,
      'location': location,
      'category': category,
      'reportId': reportId,
      'imageURL' : imageURL,
      'userId' : userId,
      'reportStatus' : reportStatus,
    };
  }

  factory ReportModel.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return ReportModel(
      title: data['title'],
      desc: data['desc'],
      location: data['location'],
      category: data['category'],
      reportId: data['reportId'],
      imageURL: data['imageURL'],
      userId: data['userId'],
      reportStatus: data['reportStatus'],
    );
  }
}