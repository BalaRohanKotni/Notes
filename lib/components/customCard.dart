import 'dart:html';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class CustomCard extends StatelessWidget {
  Function onTap;
  DateTime creation;
  DateTime updation;
  String title;
  String body;
  bool darkMode;
  String type;

  CustomCard({
    Key? key,
    required this.onTap,
    required this.creation,
    required this.updation,
    required this.title,
    required this.body,
    required this.darkMode,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (type == "note")
        ? GestureDetector(
            onTap: onTap(),
            child: Container(
              height: 140,
              padding: EdgeInsets.all(8.0),
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 15),
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: darkMode ? kSpaceCadet : Colors.white,
                    border: Border.all(color: Colors.grey, width: 0.75),
                    borderRadius: BorderRadius.all(
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
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: kCeruleanBlue,
                            fontFamily: "SourceSansPro",
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          body,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: kSpaceCadet,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: "SourceSansPro",
                          ),
                        ),
                      ),
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
          )
        : Container();
  }
}
