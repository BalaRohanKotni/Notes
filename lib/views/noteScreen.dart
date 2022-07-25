import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/components/listBlock.dart';
import 'package:notes/constants.dart';
import 'package:notes/controllers/customTextFieldContoller.dart';
import 'package:notes/controllers/appTheme.dart';
import 'package:notes/controllers/dataServices.dart';
import '../components/textBlock.dart';

class NoteScreen extends StatefulWidget {
  final User user;
  final ThemeMode themeMode;
  final bool newNote;
  final Map data;
  const NoteScreen({
    Key? key,
    required this.user,
    required this.themeMode,
    required this.newNote,
    required this.data,
  }) : super(key: key);

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
  int focusOnBlockNumber = 0;
  FocusNode titleFocusNode = FocusNode();

  late String givenTitle;
  late int givenCreation, givenUpdation;
  late Map givenBody;
  late String path;

  @override
  void initState() {
    super.initState();
    theme = AppTheme(widget.user.uid);

    if (!widget.newNote) {
      titleEditingController.text = widget.data["title"];
      for (dynamic givenBlock in widget.data["body"]) {
        if (givenBlock.containsKey("textBlock")) {
          FocusNode fNode = FocusNode();
          fNode.addListener(() {
            if (fNode.hasFocus) {}
          });
          CustomTextFieldController cTextFieldController =
              CustomTextFieldController();
          cTextFieldController.text = givenBlock["textBlock"];
          int creation = givenBlock["creation"];
          blocks.add({
            "type": "textBlock",
            "controller": cTextFieldController,
            "focusNode": fNode,
            "creation": creation,
            "block": textBlock(
              cTextFieldController,
              fNode,
              widget,
              () {
                removeTextBlock(creation);
              },
            ),
          });
        } else if (givenBlock.containsKey("listBlock")) {
          FocusNode listBlockFocusNode = FocusNode();
          List list = [];
          for (dynamic listItem in givenBlock["listBlock"]) {
            list.add([listItem["0"][0], listItem["0"][1]]);
          }

          int creation = givenBlock["creation"];
          blocks.add({
            "creation": creation,
            "type": "listBlock",
            "focusNode": listBlockFocusNode,
            "list": list,
            "block": ListBlock(
              list: list,
              themeMode: widget.themeMode,
              focusNode: listBlockFocusNode,
              deleteListBlock: () {
                int index = 0;
                for (var block in blocks) {
                  if (block["type"] == "listBlock" &&
                      block["creation"] == creation) {
                    blocks.remove(block);
                    focusOnBlockNumber = index - 1;
                    setState(() {});
                    break;
                  }
                  index++;
                }
              },
              toggleToNextBlock: () {
                for (int ind = 0; ind < blocks.length; ind++) {
                  if (blocks[ind]["type"] == "listBlock" &&
                      blocks[ind]["creation"] == creation) {
                    if (ind == blocks.length - 1) {
                      int textBlockCreation =
                          DateTime.now().millisecondsSinceEpoch;
                      focusOnTitle = false;
                      FocusNode fNode = FocusNode();
                      CustomTextFieldController cTextFieldController =
                          CustomTextFieldController();
                      blocks.add({
                        "creation": textBlockCreation,
                        "type": "textBlock",
                        "controller": cTextFieldController,
                        "focusNode": fNode,
                        "block": textBlock(
                          cTextFieldController,
                          fNode,
                          widget,
                          () {
                            removeTextBlock(textBlockCreation);
                          },
                        ),
                      });
                      focusOnBlockNumber = blocks.length - 1;
                    }
                    setState(() {});
                    break;
                  }
                }
              },
            ),
          });
        }
      }
    }

    FocusNode fNode = FocusNode();
    CustomTextFieldController cTextFieldController =
        CustomTextFieldController();
    int creation = DateTime.now().millisecondsSinceEpoch;
    blocks.add({
      "type": "textBlock",
      "controller": cTextFieldController,
      "focusNode": fNode,
      "creation": creation,
      "block": textBlock(
        cTextFieldController,
        fNode,
        widget,
        () {
          removeTextBlock(creation);
        },
      ),
    });
  }

  void removeTextBlock(int creation) {
    int index = 0;
    for (var block in blocks) {
      if (block["type"] == "textBlock" && block["creation"] == creation) {
        blocks.remove(block);
        if (index == 0) {
          focusOnTitle = true;
          focusOnBlockNumber = -1;
        } else {
          focusOnBlockNumber = index - 1;
        }
        setState(() {});
        break;
      }
      index++;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (focusOnBlockNumber == -1) {
      FocusScope.of(context).requestFocus(titleFocusNode);
    } else {
      FocusScope.of(context)
          .requestFocus(blocks[focusOnBlockNumber]["focusNode"]);
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
                        int creation = DateTime.now().millisecondsSinceEpoch;
                        blocks.add({
                          "creation": creation,
                          "type": "textBlock",
                          "controller": cTextFieldController,
                          "focusNode": fNode,
                          "block": textBlock(
                            cTextFieldController,
                            fNode,
                            widget,
                            () {
                              removeTextBlock(creation);
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
                        int creation = DateTime.now().millisecondsSinceEpoch;
                        blocks.add({
                          "creation": creation,
                          "type": "listBlock",
                          "focusNode": listBlockFocusNode,
                          "list": list,
                          "block": ListBlock(
                            list: list,
                            themeMode: widget.themeMode,
                            focusNode: listBlockFocusNode,
                            deleteListBlock: () {
                              int index = 0;
                              for (var block in blocks) {
                                if (block["type"] == "listBlock" &&
                                    block["creation"] == creation) {
                                  blocks.remove(block);
                                  focusOnBlockNumber = index - 1;
                                  setState(() {});
                                  break;
                                }
                                index++;
                              }
                            },
                            toggleToNextBlock: () {
                              for (int ind = 0; ind < blocks.length; ind++) {
                                if (blocks[ind]["type"] == "listBlock" &&
                                    blocks[ind]["creation"] == creation) {
                                  if (ind == blocks.length - 1) {
                                    int textBlockCreation =
                                        DateTime.now().millisecondsSinceEpoch;
                                    focusOnTitle = false;
                                    FocusNode fNode = FocusNode();
                                    CustomTextFieldController
                                        cTextFieldController =
                                        CustomTextFieldController();
                                    blocks.add({
                                      "creation": textBlockCreation,
                                      "type": "textBlock",
                                      "controller": cTextFieldController,
                                      "focusNode": fNode,
                                      "block": textBlock(
                                        cTextFieldController,
                                        fNode,
                                        widget,
                                        () {
                                          removeTextBlock(textBlockCreation);
                                        },
                                      ),
                                    });
                                    focusOnBlockNumber = blocks.length - 1;
                                  }
                                  setState(() {});
                                  break;
                                }
                              }
                            },
                          ),
                        });
                        focusOnBlockNumber = blocks.length - 1;
                      });
                    },
                    icon: const Icon(
                      Icons.list_alt,
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
                      focusOnBlockNumber = -1;
                    }
                  },
                  child: TextField(
                    focusNode: titleFocusNode,
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
                    style: const TextStyle(
                        fontSize: 36, fontWeight: FontWeight.bold),
                    onSubmitted: (text) {
                      setState(() {
                        if (blocks.isEmpty) {
                          int creation = DateTime.now().millisecondsSinceEpoch;
                          FocusNode fNode = FocusNode();
                          CustomTextFieldController cTextFieldController =
                              CustomTextFieldController();
                          blocks.add({
                            "creation": creation,
                            "type": "textBlock",
                            "controller": cTextFieldController,
                            "focusNode": fNode,
                            "block": textBlock(
                              cTextFieldController,
                              fNode,
                              widget,
                              () {
                                removeTextBlock(creation);
                              },
                            ),
                          });
                        }
                        focusOnTitle = false;
                        focusOnBlockNumber = blocks.length - 1;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (blocks.isEmpty) {
                        int creation = DateTime.now().millisecondsSinceEpoch;
                        FocusNode fNode = FocusNode();
                        CustomTextFieldController cTextFieldController =
                            CustomTextFieldController();
                        blocks.add({
                          "type": "textBlock",
                          "controller": cTextFieldController,
                          "focusNode": fNode,
                          "creation": creation,
                          "block": textBlock(
                            cTextFieldController,
                            fNode,
                            widget,
                            () {
                              removeTextBlock(creation);
                            },
                          ),
                        });
                        focusOnTitle = false;
                        setState(() {});
                      }
                    },
                    child: ReorderableList(
                      itemCount: blocks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          minVerticalPadding: 0,
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
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            List body = [];
            for (var element in blocks) {
              if (element["type"] == "textBlock") {
                body.add({
                  "textBlock": element["controller"].text,
                  "creation": element["creation"]
                });
              } else if (element["type"] == "listBlock") {
                List li = [];
                for (List l in element["list"]) {
                  li.add({"0": l});
                }
                body.add({"listBlock": li, "creation": element["creation"]});
              }
            }

            String title = titleEditingController.text;
            int creation = DateTime.now().millisecondsSinceEpoch;
            int updation = DateTime.now().millisecondsSinceEpoch;
            String path = "/";

            addDoc(widget.user.uid, {
              "title": title,
              "body": body,
              "creation": creation,
              "updation": updation,
              "path": path,
            });
          },
          label: const Text("Save"),
          icon: const Icon(Icons.save),
          backgroundColor: kCeruleanBlue,
        ),
      ),
    );
  }
}
