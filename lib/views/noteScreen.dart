import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/controllers/customTextFieldContoller.dart';
import 'package:notes/controllers/appTheme.dart';
import '../components/textBlock.dart';

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

  TextEditingController titleEditingController = TextEditingController();
  CustomTextFieldController testController = CustomTextFieldController();

  // r'###### (.*)': const TextStyle(fontSize: 10.72 + 8),
  // r'##### (.*)': const TextStyle(fontSize: 13.28 + 8),
  // r'#### (.*)': const TextStyle(fontSize: 16 + 8),
  // r'### (.*)': const TextStyle(fontSize: 18.72 + 8),
  // r'## (.*)': const TextStyle(fontSize: 24 + 8),
  // r'# (.*)': const TextStyle(fontSize: 32 + 8),
  // r'\*\*(.*?)\*\*': const TextStyle(fontWeight: FontWeight.bold),
  // r'\*(.*?)\*': const TextStyle(fontStyle: FontStyle.italic),

  @override
  void initState() {
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
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(titleEditingController.text),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Icon(
                    Icons.text_fields,
                    size: 30,
                  ),
                  Icon(
                    Icons.text_format,
                    size: 30,
                  ),
                  Icon(
                    Icons.list_alt,
                    size: 30,
                  ),
                ],
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            margin: const EdgeInsets.all(8),
            child: Column(
              children: [
                TextField(
                  controller: titleEditingController,
                  onChanged: (context) {
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Untitled",
                    hintStyle: TextStyle(fontSize: 40),
                  ),
                  style: const TextStyle(fontSize: 40),
                ),
                textBlock(testController)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
