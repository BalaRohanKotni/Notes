import 'package:flutter/material.dart';
import '../constants.dart';

Container loginSignupChoiceButton(text, onPressed, heroTag) {
  return Container(
    height: 50,
    margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
    child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(kCeruleanBlue),
        minimumSize: MaterialStateProperty.all(const Size.fromHeight(45)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: kAliceBlue,
              width: 2.5,
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Hero(
        tag: heroTag,
        child: Material(
          type: MaterialType.transparency, // likely needed
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'SourceSansPro',
              fontSize: 23,
              color: Colors.white,
            ),
          ),
        ),
      ),
    ),
  );
}
