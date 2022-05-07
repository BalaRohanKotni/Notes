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
                  authCustomTextFeild("Email", emailController),
                  const SizedBox(height: 20),
                  authCustomTextFeild("Password", pwdController,
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
                    () async {
                      String email = emailController.text;
                      String pwd = pwdController.text;

                      var user = await AuthService()
                          .signInWithEmailAndPassword(email, pwd);
                      // TODO: Make sure user exists before sending to overview screen
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OverviewScreen(
                                    user: user,
                                    type: "all",
                                  )),
                          (route) => false);
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
