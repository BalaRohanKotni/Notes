import 'package:flutter/material.dart';
import 'package:notes/components/authCustomTextField.dart';
import 'package:notes/components/authCustomSubmitButton.dart';
import 'package:notes/constants.dart';
import 'package:notes/views/overview_screen.dart';
import 'package:notes/views/signUpScreen.dart';
import '../controllers/auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

  void login(
    BuildContext context,
  ) async {
    String email = emailController.text;
    String pwd = pwdController.text;

    AuthService().signInWithEmailAndPassword(email, pwd).then((user) {
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
      } else {
        // Handle other errors
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 65),
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
                "Log in",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'LobsterTwo',
                  fontSize: 40,
                  color: kCaledonBLue,
                ),
              ),
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  authCustomTextFeild("Email", emailController,
                      onSubmittedFunction: (str) {}),
                  const SizedBox(height: 20),
                  authCustomTextFeild("Password", pwdController,
                      type: TextInputType.visiblePassword,
                      obsureText: true, onSubmittedFunction: (str) {
                    login(
                      context,
                    );
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
                      login(context);
                      // TODO: Make sure user exists before sending to overview screen
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
                        "Dont have an account? ",
                        style: TextStyle(
                            // color: Colors.black,
                            fontSize: 16.0,
                            fontFamily: "SourceSansPro"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerLeft,
                            splashFactory: NoSplash.splashFactory),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: kSpaceCadet,
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
      ),
    );
  }
}
