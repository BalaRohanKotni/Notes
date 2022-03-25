import 'package:flutter/material.dart';

Container AuthCustomSubmitButtons(Text text) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 60, vertical: 0),
    decoration: BoxDecoration(
      // color: Color(0xFF23CE6B),
      color: Color(0xFFA846A0),
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
    ),
    width: double.infinity,
    child: TextButton(
      onPressed: () {},
      child: text,
    ),
  );
}
