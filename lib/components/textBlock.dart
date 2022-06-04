import 'package:flutter/material.dart';
import '../controllers/customTextFieldContoller.dart';

Container textBlock(
    CustomTextFieldController testController, FocusNode focusNode, widget) {
  return Container(
    color: (widget.themeMode == ThemeMode.dark)
        ? const Color.fromARGB(255, 37, 37, 37)
        : const Color.fromARGB(255, 239, 239, 239),
    child: TextField(
        focusNode: focusNode,
        controller: testController,
        maxLines: null,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
        )),
  );
}
