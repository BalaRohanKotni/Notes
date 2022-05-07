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
                  AuthCustomTextFeild("Name", unameController),
                  const SizedBox(
                    height: 25,
                  ),
                  AuthCustomTextFeild("Email", emailController),
                  const SizedBox(height: 20),
                  AuthCustomTextFeild("Password", pwdController,
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
                      String uName = unameController.text;
                      String email = emailController.text;
                      String pwd = pwdController.text;
                      var user = await AuthService()
                          .registerWithEmailAndPassword(uName, email, pwd);
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
