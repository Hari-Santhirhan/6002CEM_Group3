import 'package:flutter/material.dart';
// import 'login_model.dart';
// import 'login_view_model.dart';

class loginPageView extends StatelessWidget {
// final LoginViewModel viewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A4049),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/SafeGuard logo.png',
                width: 270.0,
                height: 92.0,
              ),
              SizedBox(height: 63.0),
              Text(
                'Sign in to your account',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 35.0),
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
                        // onChanged: (value) => viewModel.updateUsername(value),
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
              SizedBox(height: 15.0),
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
                        // onChanged: (value) => viewModel.updatePassword(value),
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
              SizedBox(height: 15.0),
              SizedBox(
                width: 150,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  backgroundColor: Color(0xFF7DB9B3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 9.0),
              InkWell(
                onTap: () {}, // viewModel.forgotPassword,
                child: Text(
                  'I forgot my password. Click here to reset',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 38.0),
              Container(
                width: 309.0,
                height: 43.0,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Color(0xFF176679),
                ),
                child: Center(
                  child: Text(
                    'Register New Account',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
