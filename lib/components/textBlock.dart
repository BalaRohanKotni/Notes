import 'package:flutter/material.dart';
import '../controllers/customTextFieldContoller.dart';

Expanded textBlock(CustomTextFieldController testController) {
  return Expanded(
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
  );
}
