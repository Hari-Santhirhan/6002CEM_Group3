import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safeguard_group3_project/register_model.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterModel registerModel = RegisterModel(
      username: '', password: '', email: '');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? currentUser; // Declare currentUser variable


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
    try{// Get the user's input values
    String username = registerModel.username;
    String password = registerModel.password;
    String email = registerModel.email;


      // Register the user using Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

    // Update the currentUser variable with the authenticated user
    currentUser = userCredential.user; // Assigning User? to User?

    // Store the user data in Firestore
    await _firestore.collection('users').doc(currentUser!.uid).set({
      'username': username,
      'password': password,
      'email': email,
    });

    // Data successfully saved to Firestore
    print('User data saved to Firestore');

    _showSuccessDialog(context);
  } catch (e) {
  // An error occurred while registering the user or saving data to Firestore
  print('Error registering user or saving data: $e');
  }
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