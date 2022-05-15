import 'package:flutter/material.dart';
import 'package:notes/controllers/auth.dart';
import 'package:notes/views/loginScreen.dart';

import '../components/authCustomSubmitButton.dart';
import '../components/authCustomTextField.dart';
import '../constants.dart';
import 'overview_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late TextEditingController unameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController pwdController = TextEditingController();

  void signUp(
    BuildContext context,
  ) async {
    String email = emailController.text;
    String pwd = pwdController.text;
    String uName = unameController.text;

    AuthService().registerWithEmailAndPassword(uName, email, pwd).then((user) {
      if (user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => OverviewScreen(
                      user: user,
                      type: "all",
                    )),
            (route) => false);
      }
    }).catchError((e) {
      // Network error
      if (e.toString() ==
          '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Network problem! Try checking your network and try again."),
            duration: Duration(seconds: 6),
          ),
        );
      } else if (e.toString() ==
          '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Account already exists! Try logging in."),
            duration: Duration(seconds: 6),
          ),
        );
        // Handle other errors
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "Sorry! Not able to process your request this time, try again later. Thank you."),
            duration: Duration(seconds: 6),
          ),
        );
        // TODO: Try to send dev the error code, to be worked on for updates
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 45),
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: Container(),
              leadingWidth: 15,
              elevation: 0,
              iconTheme: const IconThemeData(
                color: kCeruleanBlue,
              ),
              backgroundColor: Colors.white,
              title: const Text(
                "Sign up",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'LobsterTwo',
                  fontSize: 40,
                  color: kCaledonBLue,
                ),
              ),
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 25),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  authCustomTextFeild("Name", unameController,
                      onSubmittedFunction: (str) {}),
                  const SizedBox(
                    height: 25,
                  ),
                  authCustomTextFeild("Email", emailController,
                      onSubmittedFunction: (str) {}),
                  const SizedBox(height: 20),
                  authCustomTextFeild("Password", pwdController,
                      type: TextInputType.visiblePassword,
                      obsureText: true, onSubmittedFunction: (str) {
                    signUp(context);
                  }),
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
                    () async {
                      signUp(context);
                    },
                    kCeruleanBlue,
                    kCeruleanBlue,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                            fontSize: 18.0, fontFamily: "SourceSansPro"),
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
                            color: kSpaceCadet,
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
      ),
    );
  }
}
