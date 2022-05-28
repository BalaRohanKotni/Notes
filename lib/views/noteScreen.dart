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

  FocusNode focusNode = FocusNode();

  List<Widget> textBlocks = [];
  List<CustomTextFieldController> textBlockControllers = [];
  List<FocusNode> textBlockFocusNodes = [];

  bool focusOnTitle = true;
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

    FocusNode fNode = FocusNode();
    CustomTextFieldController cTextFieldController =
        CustomTextFieldController();
    textBlockFocusNodes.add(fNode);
    textBlockControllers.add(cTextFieldController);
    textBlocks.add(textBlock(cTextFieldController, fNode, widget));
  }

  @override
  Widget build(BuildContext context) {
    if (!focusOnTitle) {
      FocusScope.of(context).requestFocus(textBlockFocusNodes.last);
    }
    return MaterialApp(
      themeMode: widget.themeMode,
      theme: theme.lightTheme,
      darkTheme: theme.darkTheme,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: (widget.themeMode == ThemeMode.light)
                  ? Colors.black
                  : Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
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
                        focusOnTitle = false;
                        FocusNode fNode = FocusNode();
                        CustomTextFieldController cTextFieldController =
                            CustomTextFieldController();
                        textBlockFocusNodes.add(fNode);
                        textBlockControllers.add(cTextFieldController);
                        textBlocks.add(
                            textBlock(cTextFieldController, fNode, widget));
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
                Focus(
                  onFocusChange: (hasFocus) {
                    if (hasFocus) {
                      focusOnTitle = true;
                    }
                  },
                  child: TextField(
                    autofocus: true,
                    controller: titleEditingController,
                    onChanged: (context) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Untitled",
                      hintStyle: TextStyle(
                          fontSize: 36,
                          color: (widget.themeMode == ThemeMode.dark)
                              ? const Color(0xFF373737)
                              : const Color(0xFFe1e1e0)),
                    ),
                    style: const TextStyle(fontSize: 36),
                    onSubmitted: (text) {
                      FocusScope.of(context)
                          .requestFocus(textBlockFocusNodes.last);
                      setState(() {
                        focusOnTitle = false;
                      });
                    },
                  ),
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
                                  int index = textBlocks.indexOf(textBlock);
                                  textBlocks.remove(textBlock);
                                  textBlockFocusNodes.removeAt(index);
                                  textBlockControllers.removeAt(index);
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
