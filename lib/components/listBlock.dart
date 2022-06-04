import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notes/controllers/customTextFieldContoller.dart';

class ListBlock extends StatefulWidget {
  final List list;
  final ThemeMode themeMode;
  final FocusNode focusNode;
  final VoidCallback deleteListBlock;
  final VoidCallback toggleToNextBlock;
  const ListBlock({
    Key? key,
    required this.list,
    required this.themeMode,
    required this.focusNode,
    required this.deleteListBlock,
    required this.toggleToNextBlock,
  }) : super(key: key);

  @override
  State<ListBlock> createState() => _ListBlockState();
}

class _ListBlockState extends State<ListBlock> {
  List<CustomTextFieldController> controllers = [];
  List<FocusNode> focusNodes = [];
  late FocusNode _focusNode;
  // bool __hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode;
    _focusNode.addListener(focusChange);
    for (var element in widget.list) {
      controllers.add(CustomTextFieldController());
      controllers.last.text = element[1];
      focusNodes.add(FocusNode());
    }
  }

  void focusChange() {
    if (_focusNode.hasFocus) {
      focusNodes.last.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    print("building listBlock.dart");
    focusChange();
    return Container(
        color: (widget.themeMode == ThemeMode.dark)
            ? const Color.fromARGB(255, 37, 37, 37)
            : const Color.fromARGB(255, 239, 239, 239),
        child: ReorderableList(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return ListTile(
              key: ValueKey(index),
              leading: Checkbox(
                value: widget.list[index][0],
                onChanged: (value) {
                  setState(() {
                    widget.list[index][0] = value;
                  });
                },
              ),
              title: RawKeyboardListener(
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
                    onSubmitted: (value) {
                      if (widget.list.isEmpty &&
                          controllers[index].text.isEmpty) {
                        widget.deleteListBlock();
                      } else if (controllers[index].text.isEmpty &&
                          widget.list.isNotEmpty) {
                        widget.toggleToNextBlock();
                      } else {
                        setState(() {
                          widget.list.last[1] = controllers.last.text;
                          widget.list.add([false, ""]);
                          controllers.add(CustomTextFieldController());
                          focusNodes.add(FocusNode());
                          focusNodes.last.requestFocus();
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
            );
          },
          itemCount: widget.list.length,
          onReorder: (oldIndex, newIndex) {},
        ));
    ;
  }
}
