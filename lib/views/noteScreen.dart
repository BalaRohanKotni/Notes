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

  List<Widget> textBlocks = [];

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
              Text((titleEditingController.text.isEmpty)
                  ? "Untitled"
                  : titleEditingController.text),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        textBlocks.add(
                            textBlock(CustomTextFieldController(), widget));
                      });
                    },
                    icon: const Icon(
                      Icons.text_fields,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.list_alt,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.text_format,
                      size: 30,
                    ),
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
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Untitled",
                    hintStyle: TextStyle(
                        fontSize: 40,
                        color: (widget.themeMode == ThemeMode.dark)
                            ? const Color(0xFF373737)
                            : const Color(0xFFe1e1e0)),
                  ),
                  style: const TextStyle(fontSize: 38),
                ),
                Expanded(
                  child: ReorderableListView(
                    children: [
                      for (final textBlock in textBlocks)
                        ListTile(
                          contentPadding: const EdgeInsets.all(4),
                          trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  textBlocks.remove(textBlock);
                                });
                              },
                              icon: Icon(
                                Icons.delete_forever,
                                size: 24,
                                color: (widget.themeMode == ThemeMode.light)
                                    ? Colors.black
                                    : Colors.white,
                              )),
                          key: ValueKey(textBlock),
                          title: textBlock,
                        )
                    ],
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex = newIndex - 1;
                        }
                        final item = textBlocks.removeAt(oldIndex);
                        textBlocks.insert(newIndex, item);
                      });
                    },
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
