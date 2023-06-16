import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResetViewModel {
  Future<void> resetPassword(String username, String email, BuildContext context) async {
    try {
      // Check if the username and email exist in Firebase Authentication
      final List<String> signInMethods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (signInMethods.contains(EmailAuthProvider.EMAIL_PASSWORD_SIGN_IN_METHOD)) {
        // Username and email exist in Firebase Authentication

        // Check if the username and email exist in Firestore collection
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: username)
            .where('email', isEqualTo: email)
            .get();

        if (querySnapshot.size > 0) {
          // Username and email exist in Firestore collection

          // Send password reset email
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

          // Show success dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Password Reset'),
                content: Text('Please check your email to reset your password.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Show error dialog - username and email not found in Firestore collection
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content: Text('Username and email do not match our records.'),
                actions: [
                  TextButton(
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
        // Show error dialog - username and email not found in Firebase Authentication
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Username and email do not match our records.'),
              actions: [
                TextButton(
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
    } catch (error) {
      print('Error resetting password: $error');
      // Show error dialog - an error occurred
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('An error occurred while resetting your password.'),
            actions: [
              TextButton(
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
}