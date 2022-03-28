// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notes/constants.dart';

Container AuthCustomTextFeild(
  helper, {
  TextInputType type = TextInputType.text,
  bool obsureText = false,
}) {
  return Container(
    child: TextField(
      style: TextStyle(
        fontSize: 18.0,
        color: Colors.white,
      ),
      obscureText: obsureText,
      keyboardType: type,
      decoration: InputDecoration(
        filled: true,
        fillColor: kLoginSignupTextFeildFillColor,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide:
              BorderSide(color: kLoginSignupTextFeildOutlineColor, width: 2.0),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        labelText: helper,
        labelStyle: TextStyle(
          color: Colors.white,
          fontFamily: "SourceSansPro",
          fontSize: 20,
        ),
      ),
    ),
  );
}
