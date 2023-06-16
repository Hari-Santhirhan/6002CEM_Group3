import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:safeguard_group3_project/report_view_page.dart';
import 'package:safeguard_group3_project/widget/camera_screen.dart';

class ReportViewModel extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker(); // to pick images from gallery
  late CameraController _cameraController; // control device camera
  bool _isCameraInitialized = false; // check camera initialized
  String? imageValue;
  bool isImagePresent = false;

  Future<void> _initializeCamera() async { // retrives available cameras
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _cameraController = CameraController(firstCamera, ResolutionPreset.medium);
    await _cameraController.initialize();

    if (!_cameraController.value.isInitialized) {
      throw CameraException('Failed to initialize the camera', 'Failed');
    }

    _isCameraInitialized = true;
  }

  void processImage(String storedImage){
    imageValue = storedImage;
    if (imageValue != null){
      isImagePresent = true;
    }
    else{
      isImagePresent = false;
    }
  }

  void dispose() {
    _cameraController.dispose();
  }



  void uploadBtnPressed(BuildContext context) {
    // handles upload btn press
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16.0),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Please Select an Option",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Use Camera"),
                onTap: () async {
                  //Logic Code for camera option
                  try {
                    await _initializeCamera();
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                            "Camera Error",
                          ),
                          content: Text(
                            e.toString(),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Ok"),
                            ),
                          ],
                        );
                      },
                    );
                  }

                  Navigator.pop(context);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CameraScreen(cameraController: _cameraController),
                    ),
                  );
                  //Logic Code for camera option
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text("Go to Gallery"),
                onTap: () async {
                  final selectedImage = await _picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (selectedImage != null) {
                    // logic code for selected image
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
