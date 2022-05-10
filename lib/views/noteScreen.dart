import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/controllers/appTheme.dart';
import 'package:notes/controllers/dataServices.dart';

class NoteScreen extends StatefulWidget {
  final User user;
  const NoteScreen({Key? key, required this.user}) : super(key: key);

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
    theme.addListener(() {
      setState(() {});
    });
    // SystemChannels.textInput.invokeListMethod("TextInput.show");
  }

  bool currentTheme(snapshot) {
    return (snapshot.data) != null
        ? (snapshot.data as bool)
            ? true
            : false
        : false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getThemeFirestore(widget.user.uid),
      builder: (context, snapshot) {
        return MaterialApp(
          themeMode:
              (currentTheme(snapshot)) ? ThemeMode.dark : ThemeMode.light,
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
                      autofocus: true,
                      controller: controller,
                      onChanged: (currentStr) {
                        setState(() {});
                      },
                    ),
                  ),
                  Text(controller.text),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
