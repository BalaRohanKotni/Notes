import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/components/listBlockWidget.dart';
import 'package:notes/constants.dart';
import 'package:notes/controllers/customTextFieldContoller.dart';
import 'package:notes/controllers/appTheme.dart';
import 'package:notes/controllers/dataServices.dart';
import '../components/textBlockWidget.dart';

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
  late String docId;

  TextEditingController titleEditingController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  CustomTextFieldController testController = CustomTextFieldController();

  List<dynamic> blocks = [];
  int focusOnBlockNumber = -1;

  deleteBlock(int creation) {
    for (int index = 0; index < blocks.length; index++) {
      if (blocks[index]['creation'] == creation) {
        blocks.removeAt(index);
        focusOnBlockNumber = index - 1;
        setState(() {});
        break;
      }
    }
  }

  findBlockIndex(int creation) {
    for (int index = 0; index < blocks.length; index++) {
      if (blocks[index]['creation'] == creation) {
        return index;
      }
    }
    return -1;
  }

  createTextBlock({int creation = -1, String content = ""}) {
    CustomTextFieldController controller = CustomTextFieldController();
    if (creation != -1) controller.text = content;
    if (creation == -1) creation = DateTime.now().millisecondsSinceEpoch;
    FocusNode focusNode = FocusNode();
    blocks.add({
      "creation": creation,
      "type": "textBlock",
      "controller": controller,
      "focusNode": focusNode,
      "block": TextBlockWidget(
        controller,
        focusNode,
        widget,
        () {
          deleteBlock(creation);
        },
      ),
    });
    focusOnBlockNumber = findBlockIndex(creation);
    setState(() {});
  }

  createListBlock({
    int creation = -1,
    List list = const [],
  }) {
    if (creation == -1) {
      list = [
        [false, ""]
      ];
    }
    if (creation == -1) creation = DateTime.now().millisecondsSinceEpoch;
    FocusNode focusNode = FocusNode();
    blocks.add({
      "creation": creation,
      "type": "listBlock",
      "focusNode": focusNode,
      "list": list,
      "block": ListBlockWidget(
        list: list,
        focusNode: focusNode,
        deleteListBlock: () {
          deleteBlock(creation);
        },
        themeMode: widget.themeMode,
        toggleToNextBlock: () {
          for (int index = 0; index < blocks.length; index++) {
            if (blocks[index]["creation"] == creation) {
              if (index == blocks.length - 1) {
                createTextBlock();
              } else {
                focusOnBlockNumber = index + 1;
                setState(() {});
              }
            }
          }
        },
      ),
    });
    focusOnBlockNumber = findBlockIndex(creation);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    theme = AppTheme(widget.user.uid);

    if (!widget.newNote) {
      Map data = widget.data["data"];
      print(data);
      docId = widget.data["id"];
      titleEditingController.text = data["title"];
      for (int index = 0; index < data["body"].length; index++) {
        dynamic block = data["body"][index];
        if (block.containsKey("textBlock")) {
          createTextBlock(
              creation: block["creation"], content: block["textBlock"]);
        } else if (block.containsKey("listBlock")) {
          List list = [];
          for (dynamic listItem in block["listBlock"]) {
            list.add([listItem["0"][0], listItem["0"][1]]);
          }
          createListBlock(creation: block["creation"], list: list);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    print(focusOnBlockNumber);
    if (focusOnBlockNumber < 0) {
      print("title");
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
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                IconButton(
                  icon: const Icon(
                    Icons.list_alt,
                    size: 30,
                  ),
                  onPressed: () {
                    createListBlock();
                  },
                ),
                PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  itemBuilder: ((popupMenuButtonContext) => [
                        PopupMenuItem(
                          child: const Text("Delete"),
                          onTap: () {
                            if (!widget.newNote) {
                              Navigator.pop(context);
                              deleteDoc(widget.user.uid, docId);
                            } else {
                              Navigator.pop(context);
                            }
                          },
                        ),
                      ]),
                )
              ]),
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
                      focusOnBlockNumber = -1;
                      setState(() {});
                    }
                  },
                  child: TextField(
                    focusNode: titleFocusNode,
                    controller: titleEditingController,
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
                    onChanged: (context) {
                      setState(() {});
                    },
                    onSubmitted: (text) {
                      // create textblock when title is submitted
                      createTextBlock();
                    },
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // TODO
                    },
                    child: ReorderableList(
                      itemCount: blocks.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          contentPadding: const EdgeInsets.all(0),
                          minVerticalPadding: 0,
                          key: ValueKey(blocks[index]["block"]),
                          title: GestureDetector(
                            child: blocks[index]["block"],
                            onTap: () {
                              //  TODO
                            },
                          ),
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
              if (element["type"] == "textBlock" &&
                  element["controller"].text != "") {
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

            if (widget.newNote) {
              addDoc(widget.user.uid, {
                "title": title,
                "body": body,
                "creation": creation,
                "updation": updation,
                "path": path,
              });
            } else {
              updateDoc(widget.user.uid, docId, {
                "title": title,
                "body": body,
                "creation": creation,
                "updation": updation,
                "path": path,
              });
            }
            Navigator.pop(context);
          },
          label: const Text("Save"),
          icon: const Icon(Icons.save),
          backgroundColor: kCeruleanBlue,
        ),
      ),
    );
  }
}
