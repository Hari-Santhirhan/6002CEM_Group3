import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  final CameraController cameraController;
  const CameraScreen(
      {Key? key,
      required this.cameraController})
      : super(key: key);

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  @override
  void dispose() {
    widget.cameraController.dispose();
    super.dispose();
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
