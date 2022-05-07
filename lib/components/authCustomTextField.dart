// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notes/constants.dart';

Column authCustomTextFeild(
  helper,
  controller, {
  TextInputType type = TextInputType.text,
  bool obsureText = false,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        margin: EdgeInsets.only(left: 5),
        child: Text(
          helper,
          style: TextStyle(
              color: kCaledonBLue,
              fontFamily: "SourceSansPro",
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      TextField(
        cursorColor: kSpaceCadet,
        controller: controller,
        style: TextStyle(
          fontSize: 20,
        ),
        obscureText: obsureText,
        keyboardType: type,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(color: Colors.grey, width: 2),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(),
          ),
        ),
      ),
    ],
  );
}
