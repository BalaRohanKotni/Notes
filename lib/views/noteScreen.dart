import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/controllers/appTheme.dart';

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
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = AppTheme(widget.user.uid);
    // SystemChannels.textInput.invokeListMethod("TextInput.show");
  }

  @override
  Widget build(BuildContext context) {
    String text = controller.text;
    TextStyle style =
        const TextStyle(fontFamily: "SourceSansPro", fontSize: 12);
    return MaterialApp(
      themeMode: widget.themeMode,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 0.00001,
                width: 0.00001,
                child: TextField(
                  textInputAction: TextInputAction.newline,
                  autofocus: true,
                  controller: controller,
                  maxLines: 99999,
                  onChanged: (currentStr) {
                    setState(() {});
                  },
                ),
              ),
              Container(
                color: Colors.blue,
                child: Text(
                  text,
                  style: style,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Stack(
                fit: StackFit.loose,
                children: [
                  Container(
                    height: 20,
                    width: 30,
                    color: Colors.green,
                  ),
                  Positioned(
                    bottom: -15,
                    right: 20,
                    child: Container(
                      height: 20,
                      width: 30,
                      color: Colors.blue,
                    ),
                  ),
                ],
                clipBehavior: Clip.none,
              )
            ],
          ),
        ),
      ),
    );
  }
}
