import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/home_screen.dart';
import 'package:safeguard_group3_project/login_page_view.dart';
import 'package:safeguard_group3_project/register_page_view.dart';
import 'package:safeguard_group3_project/reset_page_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SafeGuard());
}

class SafeGuard extends StatelessWidget {
  const SafeGuard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: loginPageView(),
      routes: {
        '/home': (context) => MyHomePage(title: 'SafeGuard Home', userId: '',),
        '/login': (context) => loginPageView(),
        '/register': (context) => RegisterView(),
        '/reset': (context) => resetView(),
      },
    );
  }
}
