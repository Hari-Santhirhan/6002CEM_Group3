import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:safeguard_group3_project/home_screen.dart';
import 'dart:convert';

import 'login_model.dart';

class LoginViewModel extends ChangeNotifier {
  LoginModel loginModel = LoginModel(email: '', password: '');

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void updateEmail(String value) {
    loginModel.email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    loginModel.password = value;
    notifyListeners();
  }

  String hashPassword(String password) {
    var bytes = utf8.encode(password); // Convert password to bytes
    var hashed = sha256.convert(bytes); // Hash the bytes using SHA-256
    return hashed.toString();
  }

  Future<void> login(BuildContext context) async {
    try {
      String email = loginModel.email;
      String password = loginModel.password;

      QuerySnapshot querySnapshot = await _firestore
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the user document from the query result
        DocumentSnapshot userSnapshot = querySnapshot.docs.first;
        String userId = userSnapshot.id;
        String storedPassword = userSnapshot['password'];

        String hashedPassword = hashPassword(password);

        if (storedPassword == hashedPassword) {
          UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

          User? currentUser = userCredential.user;

          if (currentUser != null && currentUser.uid == userId) {
            // Successfully logged in
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(
                  title: 'Home',
                  userId: userId,
                ),
              ),
            );
          } else {
            // Incorrect email or password
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Login Failed'),
                  content: Text('Incorrect email or password.'),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the dialog
                      },
                      child: Text('OK'),
                    ),
                  ],
                );
              },
            );
          }
        } else {
          // Incorrect email or password
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Login Failed'),
                content: Text('Incorrect email or password.'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Email not found
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Failed'),
              content: Text('Email not found.'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error logging in: $e');
    }
  }
}
