import 'package:flutter/material.dart';

void main() {
  runApp(const SafeGuard());
}

class SafeGuard extends StatelessWidget {
  const SafeGuard({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello SafeGuard App 1234567!!!'),
        ),
      ),
    );
  }
}
