import 'package:flutter/material.dart';

Container AuthCustomTextFeild(
    {TextInputType type = TextInputType.text, bool obsureText = false}) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
    child: TextField(
      style: TextStyle(fontSize: 18.0),
      obscureText: obsureText,
      keyboardType: type,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Color(0xFF23CE6B), width: 2.0),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
          color: Color(0xFF23CE6B),
        )),
      ),
    ),
  );
}
