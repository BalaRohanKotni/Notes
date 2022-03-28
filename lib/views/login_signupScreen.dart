// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:notes/constants.dart';
import 'package:notes/views/loginScreen.dart';
import 'package:notes/views/signUpScreen.dart';
import '../components/login_signupChoiceButton.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: kLoginSignupBGColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              loginSignupChoiceButton("Log in", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              }, 'login'),
              const SizedBox(
                height: 5,
              ),
              loginSignupChoiceButton("Sign up", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ),
                );
              }, 'signUp'),
            ],
          ),
        ),
      ),
    );
  }
}
