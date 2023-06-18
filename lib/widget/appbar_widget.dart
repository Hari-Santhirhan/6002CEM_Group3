import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/settings_page/setting_page.dart';

AppBar buildAppBar(BuildContext context, String title) {
  final icon = CupertinoIcons.settings;

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
              context, MaterialPageRoute(builder: (context) => SettingsPage()));
        },
      ),
    ],
  );
}
