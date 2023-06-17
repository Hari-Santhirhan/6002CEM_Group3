import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePageTest3 extends StatefulWidget {
  @override
  _ProfilePageTest3State createState() => _ProfilePageTest3State();
}

class _ProfilePageTest3State extends State<ProfilePageTest3> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: FutureBuilder(
        future: _getUserDetails(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView(
              children: <Widget>[
                CircleAvatar(
                  radius: 70,
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/profile_image.png', // replace with your image asset
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: 50, // adjust width as needed
                  height: 100, // adjust height as needed
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(20), // curved edges
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.email),
                      Text('Email'),
                      Text(snapshot.data!['email']),
                    ],
                  ),
                ),
                Container(
                  width: 50, // adjust width as needed
                  height: 100, // adjust height as needed
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[100],
                    borderRadius: BorderRadius.circular(20), // curved edges
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person),
                      Text('Username'),
                      Text(snapshot.data!['username']),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.lightBlue[100], // light blue background
                    child: SingleChildScrollView( // makes the FutureBuilder scrollable
                      child: FutureBuilder(
                        future: _getReports(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(), // to prevent scrolling of the inner ListView
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                var doc = snapshot.data!.docs[index].data() as Map<String, dynamic>;
                                return Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Title: ${doc['title']}',
                                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          'Desc: ${doc['desc']}',
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (snapshot.connectionState == ConnectionState.none) {
                            return Text("No data");
                          }
                          return CircularProgressIndicator();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.none) {
            return Text("No data");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  Future<DocumentSnapshot> _getUserDetails() async {
    User? user = _auth.currentUser;
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
  }

  Future<QuerySnapshot> _getReports() async {
    //User? user = _auth.currentUser;
    return await FirebaseFirestore.instance
        .collection('report_submissions')
        //.where('userId', isEqualTo: user!.uid)
        .get();
  }
}
