import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/pages/contacts_page/contact_list_page.dart';
import 'package:safeguard_group3_project/pages/contacts_page/contact_list_trial_2.dart';
import 'package:safeguard_group3_project/pages/map_page/maps_page.dart';
import 'package:safeguard_group3_project/pages/profile_page/profile_page.dart';
import 'package:safeguard_group3_project/pages/profile_page/profile_pageTest.dart';
import 'package:safeguard_group3_project/pages/settings_page/setting_page.dart';
import 'package:safeguard_group3_project/widget/navigation_widget.dart';
import 'firebase_options.dart';
import 'package:safeguard_group3_project/home_screen.dart';
import 'package:safeguard_group3_project/login_page_view.dart';
import 'package:safeguard_group3_project/register_page_view.dart';
import 'package:safeguard_group3_project/reset_page_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(SafeGuard());
}

class SafeGuard extends StatelessWidget {
  const SafeGuard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 225, 229, 130),
        ),
        home: Navigation());
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
