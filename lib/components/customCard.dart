import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class CustomCard extends StatelessWidget {
  Function onTap;
  DateTime creation;
  DateTime updation;
  String title;
  dynamic body;
  bool darkMode;
  String type;

  CustomCard({
    Key? key,
    required this.onTap,
    required this.creation,
    required this.updation,
    required this.title,
    this.body = "",
    required this.darkMode,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> listItemsTextList = [];
    List<Widget> doneItems = [];
    List<Widget> notDoneItems = [];
    if (type == 'todo-list') {
      for (var todo in body) {
        if (todo["0"][0] == false) {
          notDoneItems.add(Text(todo['0'][1]));
        } else {
          doneItems.add(Text(
            todo['0'][1],
            style: const TextStyle(decoration: TextDecoration.lineThrough),
          ));
        }
      }
      listItemsTextList = notDoneItems + doneItems;
    }
    return GestureDetector(
      onTap: onTap(),
      child: Container(
        height: 140,
        padding: const EdgeInsets.all(8.0),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: darkMode ? kSpaceCadet : Colors.white,
              border: Border.all(color: Colors.grey, width: 0.75),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: kCeruleanBlue,
                      fontFamily: "SourceSansPro",
                    ),
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: (type == 'note')
                        ? Text(
                            body,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: kSpaceCadet,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: "SourceSansPro",
                            ),
                          )
                        : Container(
                            child: ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: listItemsTextList,
                            ),
                          )),
                Expanded(
                  flex: 1,
                  child: Text(
                      " ${creation == updation ? DateFormat("MMMM d y, HH:mm").format((creation.toLocal())) : DateFormat("MMMM d y, HH:mm").format(updation.toLocal())}"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
