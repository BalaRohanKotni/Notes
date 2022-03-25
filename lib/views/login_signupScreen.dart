// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/constants.dart';

import '../components/AuthCustomTextFeild.dart';
import '../components/authCustomSubmitButton.dart';
import '../components/authCustomTextFieldHelper.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        // color: Color(0xFF23CE6B),
        color: Color(0xFF272D2D),
        child: Container(
          // color: Colors.white,
          margin: const EdgeInsets.symmetric(vertical: 225, horizontal: 40),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                // TODO: Customize TabBar
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Color(0xFF23CE6B),
                  ),
                  child: TabBar(
                    indicatorColor: Color(0xFFA846A0),
                    // indicator: BoxDecoration(color: Color(0xFF23CE6B)),
                    tabs: [
                      Container(
                        child: Text(
                          "Login",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontFamily: 'SourceSansPro'),
                        ),
                      ),
                      Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'SourceSansPro'),
                      ),
                    ],
                  ),
                ),

                // TODO: Customize TabBarView and data to it
                Expanded(
                  child: Container(
                    color: Color(0xFFF6F8FF),
                    child: TabBarView(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            AuthCustomTextFeildHelper(
                              Text(
                                "Email",
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: "SourceSansPro",
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            AuthCustomTextFeild(
                                type: TextInputType.emailAddress),
                            SizedBox(
                              height: 20,
                            ),
                            AuthCustomTextFeildHelper(Text(
                              "Password:",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontFamily: "SourceSansPro",
                                  fontWeight: FontWeight.w500),
                            )),
                            AuthCustomTextFeild(
                                type: TextInputType.visiblePassword,
                                obsureText: true),
                            SizedBox(
                              height: 20,
                            ),
                            AuthCustomSubmitButtons(
                              Text(
                                "Login",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontFamily: "SourceSansPro",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
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
}
