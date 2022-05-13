import 'package:flutter/material.dart';

class TextFieldFormatter extends TextEditingController {
  final Map<String, TextStyle> map;
  final Pattern pattern;

  TextFieldFormatter(this.map)
      : pattern = RegExp(
            map.keys.map((key) {
              return key;
            }).join('|'),
            multiLine: true);

  @override
  set text(String newText) {
    value = value.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final List<InlineSpan> children = [];
    String patternMatched = "";
    String? formatText;
    TextStyle? myStyle;
    text.splitMapJoin(
      pattern,
      onMatch: (Match match) {
        myStyle = map[match[0]] ??
            map[map.keys.firstWhere(
              (e) {
                bool ret = false;
                RegExp(e).allMatches(text).forEach((element) {
                  if (element.group(0) == match[0]) {
                    patternMatched = e;
                    ret = true;
                  }
                });
                return ret;
              },
            )];

        // if (patternMatched == r"_(.*?)\_") {
        //   formatText = match[0]!.replaceAll("_", " ");
        // } else if (patternMatched == r'\*(.*?)\*') {
        //   formatText = match[0]!.replaceAll("*", " ");
        // } else if (patternMatched == "~(.*?)~") {
        //   formatText = match[0]!.replaceAll("~", " ");
        // } else if (patternMatched == r'```(.*?)```') {
        //   formatText = match[0]!.replaceAll("```", "   ");
        // } else
        // if (patternMatched == r'# (.*)') {
        // formatText = match[0]!.replaceAll("#", " ");
        // print([formatText]);
        // }
        // else {
        //   formatText = match[0];
        // }

        map.forEach((key, value) {
          if (patternMatched == key) {
            String command = key;
            command = command.replaceAll("\\", "");
            int posFirstParanthesis = command.indexOf('(');
            command = command.substring(0, posFirstParanthesis);
            print([key, command]);
            formatText = match[0]!.replaceAll(command, " ");
            // print([key[0], formatText]);
          }
        });

        children.add(TextSpan(
          text: formatText,
          style: style?.merge(myStyle),
        ));
        return "";
      },
      onNonMatch: (String text) {
        children.add(TextSpan(text: text, style: style));
        return "";
      },
    );

    return TextSpan(style: style, children: children);
  }
}
