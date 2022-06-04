import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/customTextFieldContoller.dart';

Container textBlock(CustomTextFieldController textFieldController,
    FocusNode focusNode, widget, Function deleteTextBlock) {
  return Container(
    color: (widget.themeMode == ThemeMode.dark)
        ? const Color.fromARGB(255, 37, 37, 37)
        : const Color.fromARGB(255, 239, 239, 239),
    child: RawKeyboardListener(
      onKey: (event) {
        if (textFieldController.text.isEmpty &&
            event.logicalKey == LogicalKeyboardKey.backspace) deleteTextBlock();
      },
      focusNode: FocusNode(),
      child: TextField(
          focusNode: focusNode,
          controller: textFieldController,
          maxLines: null,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
          )),
    ),
  );
}
