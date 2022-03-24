import 'package:flutter/material.dart';
import 'package:notes/constants.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: appTheme,
        child: Container(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 225, horizontal: 40),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: const [
                // TODO: Customize TabBar
                TabBar(
                  tabs: [
                    Text(
                      "Login",
                      style: TextStyle(color: Colors.black),
                    ),
                    Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),

                // TODO: Customize TabBarView and data to it
                Expanded(
                  child: TabBarView(
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(color: Colors.red),
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
