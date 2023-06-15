import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/report_view_page.dart';

void main() {
  runApp(const SafeGuard());
}

class SafeGuard extends StatelessWidget {
  const SafeGuard({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ReportPage(), // the report page
    );
  }
}
