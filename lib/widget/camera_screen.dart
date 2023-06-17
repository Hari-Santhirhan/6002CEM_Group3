import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safeguard_group3_project/report_viewModel_page.dart';

class CameraScreen extends StatefulWidget {
  final CameraController cameraController;
  const CameraScreen({Key? key, required this.cameraController})
      : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  final ReportViewModel _reportViewModel = new ReportViewModel();

  @override
  void dispose() {
    widget.cameraController.dispose();
    super.dispose();
  }

  void _captureImage() async {
    final XFile? imageFile = await widget.cameraController.takePicture();
    if (imageFile != null) {
      // Displays image preview dialog
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Image Preview'),
          content: Image.file(File(imageFile.path)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                String storedImage = imageFile.path;
                _reportViewModel.processImage(storedImage);
              },
              child: Text('Confirm'),
            ),
            TextButton(
              onPressed: () { // when the image is cancelled
                Navigator.pop(context);
                setState(() {
                  imageFile == null;
                  imageFile.path == null;
                });
              },
              child: Text('Cancel'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CameraPreview(widget.cameraController),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              child: InkWell(
                onTap: () async {
                  //Logic for image capture
                  _captureImage();
                  Navigator.pop(context);// calls the image capturing function
                  //Logic for image capture
                },
                child: Ink(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.black,
                  ),
                  width: 200,
                  height: 265,
                  child: Icon(
                    Icons.camera_alt,
                    size: 50.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              child: InkWell(
                onTap: () async {
                  //Logic for video capture

                  //Logic for video capture
                },
                child: Ink(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.black,
                  ),
                  width: 200,
                  height: 265,
                  child: Icon(
                    Icons.videocam_rounded,
                    size: 50.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
