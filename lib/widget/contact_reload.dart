import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../pages/contacts_page/contact_list_page.dart';
import '../pages/settings_page/setting_page.dart';

AppBar contactsAppBar(BuildContext context, String title) {
  final icon = Icons.edit;

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
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => ProfilePageTest()));
        },
      ),
    ],
  );
}
