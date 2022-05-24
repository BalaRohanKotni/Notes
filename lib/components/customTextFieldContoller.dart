import 'package:flutter/material.dart';

class CustomTextFieldController extends TextEditingController {
  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    List<InlineSpan> children = [];

    final boldRegex = RegExp(r'\*(.*?)\*');

    text.splitMapJoin(
      boldRegex,
      onMatch: (Match m) {
        // String matchText = m[0]!.replaceAll("*", '');
        String matchText = m[0]!.replaceAll("*", '‎');

        children.add(
          TextSpan(
            children: [
              (m[0]!.length + text.indexOf(m[0]!) >= selection.base.offset &&
                      selection.base.offset >= text.indexOf(m[0]!))
                  ? TextSpan(text: "*", children: [
                      TextSpan(text: matchText),
                      const TextSpan(text: "*")
                    ])
                  : TextSpan(text: matchText),
            ],
            style: const TextStyle(
              fontSize: 24,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
        );
        return "";
      },
      onNonMatch: (str) {
        children.add(TextSpan(text: str, style: style));
        return "";
      },
    );

    return TextSpan(
        // text: text,
        // style: const TextStyle(color: Colors.red),
        children: children);
  }
}
