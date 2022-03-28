import 'package:flutter/material.dart';
import 'package:notes/components/authCustomTextField.dart';
import 'package:notes/components/authCustomSubmitButton.dart';
import 'package:notes/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
              tag: "login",
              child: Text(
                "Log in",
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
                // AuthCustomTextFeildHelper(Text(
                //   "Email",
                //   style: authTextFieldHelperTextStyle(),
                // )),
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
                      "Dont have an account? ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontFamily: "SourceSansPro"),
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: Push to Signup screen
                      },
                      style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          splashFactory: NoSplash.splashFactory),
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
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
