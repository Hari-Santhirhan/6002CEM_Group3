import 'dart:io';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    // to create the pfp & edit icon
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          )
        ], //children
      ),
    );
  }

  //modify this for image editing
  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: AssetImage('assets/images/user_profile.png'),
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color: color,
    pad: 8,
    child: Icon(
      Icons.edit,
      color: Colors.white,
      size: 20,
    ),
  );

  Widget buildCircle({
    //obtaining info from widget above
    required Widget child,
    required double pad,
    required Color color,
  }) =>
      //use info above here for circle
  ClipOval(
    child: Container(
      child: child,
      color: color,
      padding: EdgeInsets.all(pad),
    ),
  );
}
