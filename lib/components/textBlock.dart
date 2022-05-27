import 'package:flutter/material.dart';
import '../controllers/customTextFieldContoller.dart';

Expanded textBlock(CustomTextFieldController testController, widget) {
  return Expanded(
    child: Container(
      color: (widget.themeMode == ThemeMode.dark)
          ? const Color(0xFF373737)
          : const Color(0xFFe1e1e0),
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
