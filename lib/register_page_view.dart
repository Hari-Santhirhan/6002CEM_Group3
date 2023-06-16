import 'package:flutter/material.dart';
import 'register_model.dart';
import 'register_viewmodel.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterView extends StatelessWidget {
   RegisterViewModel viewModel = RegisterViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A4049),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 55.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/SafeGuard logo.png',
                  width: 270.0,
                  height: 92.0,
                ),
                SizedBox(height: 8.0),
                Text(
                  'Register',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 15.0),
                Text(
                  'Register New Account',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 22.0),

                Container(
                  width: 309.0,
                  height: 43.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFEAEAEA),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          Icons.person,
                          color: Color(0xFF757575),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) => viewModel.updateUsername(value),
                          decoration: InputDecoration(
                            hintText: 'Username',
                            hintStyle: TextStyle(
                              color: Color(0xFF757575),
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: 309.0,
                  height: 43.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFEAEAEA),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          Icons.lock,
                          color: Color(0xFF757575),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) => viewModel.updatePassword(value),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Color(0xFF757575),
                            ),
                            border: InputBorder.none,
                          ),
                          obscureText: true,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  width: 309.0,
                  height: 43.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFEAEAEA),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(
                          Icons.email,
                          color: Color(0xFF757575),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) => viewModel.updateEmail(value),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Color(0xFF757575),
                            ),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 27.0),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  child: Text(
                    'I have an account. Click here to sign in',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 27.0),
                SizedBox(
                  width: 140,
                  child: FloatingActionButton(
                    onPressed: () async {
                      try {
                        await viewModel.register(context); // Call the method from the view model to register the user
                        // Success! Registration completed
                      } catch (e) {
                        // Handle any error that occurred during registration
                        Fluttertoast.showToast(
                          msg: 'Error registering user: $e',
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                        );
                        return; // Return early to avoid calling _showSuccessDialog on error
                      }

                      _showSuccessDialog(context); // Show success dialog
                    },
                    backgroundColor: Color(0xFF7DB9B3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
