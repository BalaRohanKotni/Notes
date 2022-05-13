import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/controllers/appTheme.dart';

import '../components/textFieldFormatter.dart';

class NoteScreen extends StatefulWidget {
  final User user;
  final ThemeMode themeMode;
  const NoteScreen({Key? key, required this.user, required this.themeMode})
      : super(key: key);

  @override
  State<NoteScreen> createState() => NoteScreenState();
}

class NoteScreenState extends State<NoteScreen> {
  late AppTheme theme;

  final TextEditingController _controller = TextFieldFormatter(
    {
      r'###### (.*)': const TextStyle(fontSize: 10.72 + 8),
      r'##### (.*)': const TextStyle(fontSize: 13.28 + 8),
      r'#### (.*)': const TextStyle(fontSize: 16 + 8),
      r'### (.*)': const TextStyle(fontSize: 18.72 + 8),
      r'## (.*)': const TextStyle(fontSize: 24 + 8),
      r'# (.*)': const TextStyle(fontSize: 32 + 8),
      r'\*\*(.*?)\*\*': const TextStyle(fontWeight: FontWeight.bold),
      r'\*(.*?)\*': const TextStyle(fontStyle: FontStyle.italic),
    },
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = AppTheme(widget.user.uid);
    // SystemChannels.textInput.invokeListMethod("TextInput.show");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: widget.themeMode,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                Expanded(
                  child: TextField(
                    maxLines: 99999,
                    onChanged: (text) {
                      final val = TextSelection.collapsed(
                          offset: _controller.text.length);
                      _controller.selection = val;
                    },
                    style: const TextStyle(fontSize: 16),
                    controller: _controller,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
