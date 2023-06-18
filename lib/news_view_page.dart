import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/report_model.dart';

class NewsViewPage extends StatelessWidget {
  const NewsViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report News'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('report_submissions')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No report submissions available.'),
            );
          }

          List<ReportModel> reports = snapshot.data!.docs
              .map((doc) => ReportModel.fromSnapshot(doc))
              .toList();

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
            ),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              ReportModel report = reports[index];
              // Customize the UI as per your requirement
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AspectRatio(
                        aspectRatio: 16 / 9, // Adjust the aspect ratio as needed
                        child: Image.network(
                          report.imageURL ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Title: ${report.title ?? ''}'),
                          Text('Description: ${report.desc ?? ''}'),
                          Text('Location: ${report.location ?? ''}'),
                          Text('Category: ${report.category ?? ''}'),
                          Text('Status: ${report.reportStatus ?? ''}'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
