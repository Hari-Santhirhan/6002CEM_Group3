import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/register_model.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterModel registerModel = RegisterModel(
    username: '',
    password: '',
    email: '',
  );
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void updateUsername(String value) {
    registerModel.username = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    registerModel.password = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    registerModel.email = value;
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    try {
      String username = registerModel.username;
      String password = registerModel.password;
      String email = registerModel.email;

      // Check if the email already exists
      bool isEmailTaken = await checkIfEmailExists(email);

      if (isEmailTaken) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Email Taken'),
              content: Text('The email is already registered. Please use a different email.'),
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
        return; // Stop registration process if the email is taken
      }

      // Check if the username is already taken
      bool isUsernameTaken = await checkIfUsernameExists(username);

      if (isUsernameTaken) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Username Taken'),
              content: Text('The username is already taken. Please choose a different username.'),
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
        return; // Stop registration process if the username is taken
      }

      // Check if the username has at least 4 characters
      if (username.length < 4) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Invalid Username'),
              content: Text('The username must be at least 4 characters long.'),
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
        return; // Stop registration process if the username is invalid
      }

      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? currentUser = userCredential.user;

      // Store user data in Firestore
      await _firestore.collection('users').doc(currentUser!.uid).set({
        'userId': currentUser.uid,
        'username': username,
        'email': email,
      });

      print('User data saved to Firestore');
      _showSuccessDialog(context);
    } catch (e) {
      print('Error registering user or saving data: $e');
    }
  }

  Future<bool> checkIfEmailExists(String email) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<bool> checkIfUsernameExists(String username) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Account Created'),
          content: Text('Account successfully created!'),
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
}
