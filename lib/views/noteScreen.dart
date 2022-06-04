import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/components/listBlock.dart';
import 'package:notes/constants.dart';
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
  List<dynamic> blocks = [];
  bool focusOnTitle = true;

  @override
  void initState() {
    super.initState();
    theme = AppTheme(widget.user.uid);
    // SystemChannels.textInput.invokeListMethod("TextInput.show");

    int currentId = textBlockId;
    textBlockId++;
    FocusNode fNode = FocusNode();
    CustomTextFieldController cTextFieldController =
        CustomTextFieldController();
    blocks.add({
      "type": "textBlock",
      "controller": cTextFieldController,
      "focusNode": fNode,
      "id": currentId,
      "block": textBlock(
        cTextFieldController,
        fNode,
        widget,
        () {
          for (var block in blocks) {
            if (block["type"] == "textBlock" && block["id"] == currentId) {
              blocks.remove(block);
              setState(() {});
              break;
            }
          }
        },
      ),
    });
// TODO: Get listBlockId from firestore
// TODO: Get textBlockId from firestore
  }

  @override
  Widget build(BuildContext context) {
    if (!focusOnTitle && blocks.isNotEmpty) {
      FocusScope.of(context).requestFocus(blocks.last["focusNode"]);
    }
    print("building noteScreen.dart");
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
                        int currentId = textBlockId;
                        textBlockId++;
                        blocks.add({
                          "type": "textBlock",
                          "controller": cTextFieldController,
                          "focusNode": fNode,
                          "block": textBlock(
                            cTextFieldController,
                            fNode,
                            widget,
                            () {
                              for (var block in blocks) {
                                if (block["type"] == "textBlock" &&
                                    block["id"] == currentId) {
                                  blocks.remove(block);
                                  setState(() {});
                                  break;
                                }
                              }
                            },
                          ),
                        });
                      });
                    },
                    icon: const Icon(
                      Icons.text_fields,
                      size: 30,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        FocusNode listBlockFocusNode = FocusNode();
                        List list = [
                          [false, ""]
                        ];
                        int currentId = listBlockId;
                        blocks.add({
                          "id": currentId,
                          "type": "listBlock",
                          "focusNode": listBlockFocusNode,
                          "list": list,
                          "block": ListBlock(
                            list: list,
                            themeMode: widget.themeMode,
                            focusNode: listBlockFocusNode,
                            deleteListBlock: () {
                              for (var block in blocks) {
                                if (block["type"] == "listBlock" &&
                                    block["id"] == currentId) {
                                  blocks.remove(block);
                                  setState(() {});
                                  break;
                                }
                              }
                            },
                            toggleToNextBlock: () {
                              for (int ind = 0; ind < blocks.length; ind++) {
                                if (blocks[ind]["type"] == "listBlock" &&
                                    blocks[ind]["id"] == currentId) {
                                  if (ind == blocks.length - 1) {
                                    int textBlockCurrentId = textBlockId;
                                    textBlockId++;
                                    focusOnTitle = false;
                                    FocusNode fNode = FocusNode();
                                    CustomTextFieldController
                                        cTextFieldController =
                                        CustomTextFieldController();
                                    blocks.add({
                                      "type": "textBlock",
                                      "controller": cTextFieldController,
                                      "focusNode": fNode,
                                      "block": textBlock(
                                        cTextFieldController,
                                        fNode,
                                        widget,
                                        () {
                                          for (var block in blocks) {
                                            if (block["type"] == "textBlock" &&
                                                block["id"] ==
                                                    textBlockCurrentId) {
                                              blocks.remove(block);
                                              setState(() {});
                                              break;
                                            }
                                          }
                                        },
                                      ),
                                    });
                                  }
                                  setState(() {});
                                  break;
                                }
                              }
                            },
                          ),
                        });
                        listBlockId += 1;
                      });
                    },
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
                      setState(() {
                        if (blocks.isEmpty) {
                          int textBlockCurrentId = textBlockId;
                          textBlockId++;
                          FocusNode fNode = FocusNode();
                          CustomTextFieldController cTextFieldController =
                              CustomTextFieldController();
                          blocks.add({
                            "type": "textBlock",
                            "controller": cTextFieldController,
                            "focusNode": fNode,
                            "block": textBlock(
                              cTextFieldController,
                              fNode,
                              widget,
                              () {
                                for (var block in blocks) {
                                  if (block["type"] == "textBlock" &&
                                      block["id"] == textBlockCurrentId) {
                                    blocks.remove(block);
                                    setState(() {});
                                    break;
                                  }
                                }
                              },
                            ),
                          });
                        }
                        focusOnTitle = false;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: ReorderableList(
                    itemCount: blocks.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.all(4),
                        key: ValueKey(blocks[index]["block"]),
                        title: blocks[index]["block"],
                      );
                    },
                    onReorder: (oldIndex, newIndex) {
                      setState(() {
                        if (newIndex > oldIndex) {
                          newIndex = newIndex - 1;
                        }
                        final item = blocks.removeAt(oldIndex);
                        blocks.insert(newIndex, item);
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
