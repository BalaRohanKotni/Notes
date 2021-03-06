import 'package:flutter/material.dart';

class CustomTextFieldController extends TextEditingController {
  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    List<InlineSpan> children = [];

    Map styleMaps = {
      "##": [
        r'##(.*)',
        style?.copyWith(fontSize: 24, fontWeight: FontWeight.bold)
      ],
      "#": [
        r'#(.*)',
        style?.copyWith(fontSize: 36, fontWeight: FontWeight.bold)
      ],
      "`": [r'`(.+?)`', style?.copyWith(fontFamily: "SpaceMono")],
      "~~": [
        r'~~(.+?)~~',
        style?.copyWith(decoration: TextDecoration.lineThrough)
      ],
      "***": [
        r'\*\*\*(.+?)\*\*\*',
        style?.copyWith(
            fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
      ],
      "**": [r'\*\*(.+?)\*\*', style?.copyWith(fontWeight: FontWeight.bold)],
      "*": [r'\*(.+?)\*', style?.copyWith(fontStyle: FontStyle.italic)],
    };

    Pattern pattern = RegExp(
        styleMaps.keys.map((key) {
          return styleMaps[key][0];
        }).join('|'),
        multiLine: true);

    text.splitMapJoin(
      pattern,
      onMatch: (Match m) {
        TextStyle customStyle = const TextStyle();
        String delimeter = "";

        for (String key in styleMaps.keys) {
          var styleMap = styleMaps[key];
          if (RegExp(styleMap[0]).hasMatch(m[0]!)) {
            customStyle = styleMap[1];
            delimeter = key;
            break;
          }
        }
        children.add(
          TextSpan(children: [
            (m[0]!.length + text.indexOf(m[0]!) >= selection.base.offset &&
                    selection.base.offset >= text.indexOf(m[0]!))
                ? TextSpan(text: m[0])
                : TextSpan(
                    text: m[0]!.replaceAll(delimeter, "‎" * delimeter.length)),
          ], style: customStyle),
        );

        return "";
      },
      onNonMatch: (str) {
        children.add(TextSpan(text: str, style: style));
        return "";
      },
    );

    return TextSpan(children: children);
  }
}
