import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/settings_page/setting_page.dart';

AppBar buildEmptyAppBar(BuildContext context, String title) {

  return AppBar(
    leading: BackButton(
      color: Colors.white,
    ),
    backgroundColor: Color.fromARGB(255, 43, 91, 45),
    elevation: 0,
    title: Text(title),
    centerTitle: true,
  );
}
