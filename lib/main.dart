import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/home_screen.dart';
import 'package:safeguard_group3_project/login_page_view.dart';
import 'package:safeguard_group3_project/register_page_view.dart';
import 'package:safeguard_group3_project/reset_page_view.dart';

void main() {
  runApp(const SafeGuard());
}

class SafeGuard extends StatelessWidget {
  const SafeGuard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: loginPageView(),
      routes: {
        '/home': (context) => MyHomePage(title: 'SafeGuard Home'),
      },
    );
  }
}
