import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        // the top bar on the screen
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
            // for the Upload box
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
                Transform.scale(
                  scale: 4.0,
                  child: Icon(
                    Icons.upload,
                  ),
                ),
                SizedBox(
                  height: 35.0,
                ),
                SizedBox(
                  width: 250,
                  child: FloatingActionButton(
                    onPressed: () {
                      // Logic Code for upload pic/vid button press
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    backgroundColor: Color(0xFF37EE49),
                    child: Text(
                      "Upload Picture/Video",
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
            height: 20.0,
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
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10)),
              onChanged: (value) {
                // to update the title
              },
            ),
          ),
          SizedBox(
            height: 20.0,
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
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10)),
              onChanged: (value) {
                // to update the title
              },
            ),
          ),
          SizedBox(
            height: 20.0,
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
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Location',
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10)),
              onChanged: (value) {
                // to update the title
              },
            ),
          ),
          SizedBox(
            height: 20.0,
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
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Category',
                  labelStyle: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Roboto',
                    color: Colors.black,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(left: 10)),
              onChanged: (value) {
                // to update the title
              },
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          FloatingActionButton(
            onPressed: () {
              // Logic Code for upload pic/vid button press
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
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
        ],
      ),
    );
  }
}
