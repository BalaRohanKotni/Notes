import 'package:flutter/material.dart';

Container AuthCustomSubmitButtons(Text text, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 60, vertical: 0),
    decoration: BoxDecoration(
      // color: Color(0xFF23CE6B),
      color: color,
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
