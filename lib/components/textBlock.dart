import 'package:flutter/material.dart';
import '../controllers/customTextFieldContoller.dart';

Expanded textBlock(CustomTextFieldController testController, widget) {
  return Expanded(
    child: Container(
      color: (widget.themeMode == ThemeMode.dark)
          ? const Color.fromARGB(255, 37, 37, 37)
          : const Color.fromARGB(255, 239, 239, 239),
      child: TextField(
          controller: testController,
          maxLines: null,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
          )),
    ),
  );
}
