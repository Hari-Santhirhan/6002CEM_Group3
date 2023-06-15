import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/pages/profile_page/profile_pageTest.dart';

import '../pages/settings_page/setting_page.dart';

AppBar buildSettingsAppBar(BuildContext context, String title) {
  final icon = CupertinoIcons.profile_circled;

  return AppBar(
    leading: BackButton(
      color: Colors.white,
    ),
    backgroundColor: Color.fromARGB(255, 43, 91, 45),
    elevation: 0,
    title: Text(title),
    centerTitle: true,

    //for the settings page
    actions: [
      IconButton(
        icon: Icon(icon),
        color: Colors.white,
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProfilePageTest()));
        },
      ),
    ],
  );
}
