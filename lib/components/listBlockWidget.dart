import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/controllers/customTextFieldContoller.dart';

class ListBlockWidget extends StatefulWidget {
  final List list;
  final ThemeMode themeMode;
  final FocusNode focusNode;
  final VoidCallback deleteListBlock;
  final VoidCallback toggleToNextBlock;
  const ListBlockWidget({
    Key? key,
    required this.list,
    required this.themeMode,
    required this.focusNode,
    required this.deleteListBlock,
    required this.toggleToNextBlock,
  }) : super(key: key);

  @override
  State<ListBlockWidget> createState() => _ListBlockWidgetState();
}

class _ListBlockWidgetState extends State<ListBlockWidget> {
  List<CustomTextFieldController> controllers = [];
  List<FocusNode> focusNodes = [];
  late FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = widget.focusNode;
    _focusNode.addListener(focusChange);
    for (var element in widget.list) {
      controllers.add(CustomTextFieldController());
      controllers.last.text = element[1];
      FocusNode fNode = FocusNode();
      // fNode.addListener(() {
      //   if (fNode.hasFocus && !widget.initBuild) {
      //     widget.hasFocusInBlock();
      //   }
      // });
      focusNodes.add(fNode);
    }
  }

  void focusChange() {
    if (_focusNode.hasFocus) {
      focusNodes.last.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    focusChange();
    return ReorderableList(
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        controllers[index].addListener(() {
          widget.list[index][1] = controllers[index].text;
        });
        return ListTile(
          minLeadingWidth: -4,
          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
          contentPadding: const EdgeInsets.only(left: 8),
          minVerticalPadding: 0,
          key: ValueKey(index),
          leading: SizedBox(
            height: 24,
            width: 24,
            child: Checkbox(
              value: widget.list[index][0],
              onChanged: (value) {
                setState(() {
                  widget.list[index][0] = value;
                });
              },
            ),
          ),
          title: SizedBox(
            height: 24,
            child: RawKeyboardListener(
              onKey: (event) {
                if (event.logicalKey == LogicalKeyboardKey.backspace) {
                  if (controllers[index].text.isEmpty) {
                    setState(() {
                      if (index != 0) {
                        widget.list.removeAt(index);
                        controllers.removeAt(index);
                        focusNodes.removeAt(index);
                        focusNodes.last.requestFocus();
                      } else {
                        widget.deleteListBlock();
                      }
                    });
                  }
                }
              },
              focusNode: FocusNode(),
              child: TextField(
                  focusNode: focusNodes[index],
                  onChanged: (s) {
                    // int pos = s.indexOf(controllers[index].text);
                    // print(pos);
                    // String newS = s.replaceAll(controllers[index].text, "");
                    // print(newS);
                    // print(s);
                    // controllers[index].text = s;
                    // controllers[index].selection = TextSelection.fromPosition(
                    //     TextPosition(offset: pos + newS.length));
                  },
                  onSubmitted: (value) {
                    if (widget.list.isEmpty &&
                        controllers[index].text.isEmpty) {
                      widget.deleteListBlock();
                    } else if (controllers[index].text.isEmpty &&
                        widget.list.isNotEmpty) {
                      widget.list.removeAt(widget.list.length - 1);
                      controllers.removeAt(controllers.length - 1);
                      focusNodes.removeAt(focusNodes.length - 1);
                      if (controllers.isNotEmpty) {
                        widget.toggleToNextBlock();
                      } else {
                        widget.deleteListBlock();
                      }
                      setState(() {});
                    } else {
                      setState(() {
                        widget.list.last[1] = controllers.last.text;
                        if (controllers.last.text.isNotEmpty) {
                          widget.list.add([false, ""]);
                          controllers.add(CustomTextFieldController());
                          focusNodes.add(FocusNode());
                          focusNodes.last.requestFocus();
                        } else {
                          focusNodes.last.requestFocus();
                        }
                      });
                    }
                  },
                  controller: controllers[index],
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  )),
            ),
          ),
        );
      },
      itemCount: widget.list.length,
      onReorder: (oldIndex, newIndex) {},
    );
  }
}
