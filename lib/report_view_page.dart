import 'package:flutter/material.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // the top bar on the screen
        backgroundColor: Colors.deepOrangeAccent,
        title: Text("Emergency/Disaster Response"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Container(
            // for the Upload box
            height: 200,
            width: 200,
            color: Colors.grey,
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
                  width: 200,
                  child: FloatingActionButton(
                    onPressed: () {
                      // Logic Code for upload pic/vid button press
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0)
                    ),
                    backgroundColor: Colors.greenAccent,
                    child: Text("Upload Picture/Video"),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
