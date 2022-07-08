import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/controllers/dataServices.dart';

class CustomCard extends StatelessWidget {
  final void Function() onTap;
  final DateTime creation;
  final DateTime updation;
  final String title;
  final dynamic body;
  final bool darkMode;
  final User user;
  final String docId;

  const CustomCard({
    Key? key,
    required this.onTap,
    required this.creation,
    required this.updation,
    required this.title,
    required this.body,
    required this.darkMode,
    required this.user,
    required this.docId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // {listBlock: [{0: [false, "listblock 1"]}, {0: [false, "listblock 2"]}]}

    List<Widget> bodyWidgetList = [];
    for (int blockIndex = 0; blockIndex < body.length; blockIndex++) {
      dynamic block = body[blockIndex];

      if (block.containsKey("textBlock")) {
        bodyWidgetList.add(Text(block["textBlock"]));
      } else if (block.containsKey("listBlock")) {
        for (int listBlockItemIndex = 0;
            listBlockItemIndex < block["listBlock"].length;
            listBlockItemIndex++) {
          dynamic listItem = block["listBlock"][listBlockItemIndex];
          List item = listItem["0"];
          bool boolValue = item[0];
          String stringValue = item[1];
          ListTile listTile = ListTile(
            minLeadingWidth: -4,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            contentPadding: const EdgeInsets.only(left: 8),
            minVerticalPadding: 0,
            leading: SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                value: boolValue,
                onChanged: (value) {
                  body[blockIndex]["listBlock"][listBlockItemIndex]["0"][0] =
                      value;
                  updateDoc(
                    user.uid,
                    docId,
                    {"body": body},
                  );
                },
              ),
            ),
            title: Text(stringValue),
          );
          bodyWidgetList.add(listTile);
        }
      }
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
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: bodyWidgetList,
                ),
              ),
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
