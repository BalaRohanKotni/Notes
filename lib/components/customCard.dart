import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomCard extends StatelessWidget {
  void Function() onTap;
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
    if (type == 'list') {
      for (var todo in body.take(2)) {
        if (todo["0"][0] == false) {
          notDoneItems.add(Text(todo['0'][1]));
        } else {
          doneItems.add(Text(
            todo['0'][1],
            style: const TextStyle(decoration: TextDecoration.lineThrough),
          ));
        }
      }
      if (body.length > 2) {
        doneItems.add(const Text(
          "...",
        ));
      }
      listItemsTextList = notDoneItems + doneItems;
    }

    return Card(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 140,
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: .75, color: Colors.grey),
            ),
          ),
          padding: const EdgeInsets.all(16.0),
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
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "SourceSansPro",
                          ),
                        )
                      : ListView(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: listItemsTextList,
                        )),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    " ${creation == updation ? DateFormat("MMMM d y, HH:mm").format((creation.toLocal())) : DateFormat("MMMM d y, HH:mm").format(updation.toLocal())}",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
