import 'package:flutter/material.dart';

Container AuthCustomSubmitButtons(Text text, onPressed, beginColor, endColor) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 60, vertical: 0),
    decoration: BoxDecoration(
      // color: Color(0xFF23CE6B),
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [beginColor, endColor],
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
    ),
    width: double.infinity,
    child: TextButton(
      onPressed: onPressed,
      child: text,
    ),
  );
}
