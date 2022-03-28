import 'package:flutter/material.dart';
import 'package:notes/views/loginScreen.dart';

import '../components/authCustomSubmitButton.dart';
import '../components/authCustomTextField.dart';
import '../constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLoginSignupBGColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kLoginSignupBGColor,
          appBar: AppBar(
            backgroundColor: kLoginSignupBGColor,
            title: const Hero(
              tag: "signUp",
              child: Text(
                "Sign up",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SourceSansPro',
                    fontSize: 30,
                    color: Colors.white),
              ),
            ),
          ),
          body: Container(
            margin: const EdgeInsets.all(25),
            color: kLoginSignupBGColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AuthCustomTextFeild("Enter your name"),
                const SizedBox(
                  height: 25,
                ),
                AuthCustomTextFeild("Enter your email"),
                const SizedBox(height: 20),
                AuthCustomTextFeild("Enter your password",
                    type: TextInputType.visiblePassword, obsureText: true),
                const SizedBox(
                  height: 25,
                ),
                AuthCustomSubmitButtons(
                  const Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "SourceSansPro",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  () {
                    // TODO: Get values and login
                  },
                  kLoginSignupSubmitButonStartColor,
                  kLoginSignupSubmitButonEndColor,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontFamily: "SourceSansPro"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          splashFactory: NoSplash.splashFactory),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "SourceSansPro",
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
