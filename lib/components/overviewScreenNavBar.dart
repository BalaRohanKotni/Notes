// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable
import 'package:flutter/material.dart';
import 'drawerTextButton.dart';

class OverViewScreenNavBar extends StatelessWidget {
  var user;
  bool isDarkMode;

  OverViewScreenNavBar({
    Key? key,
    required this.user,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.75,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notes',
                style: TextStyle(
                  color: theme.secondaryHeaderColor,
                  fontSize: 34.0,
                  fontFamily: 'LobsterTwo',
                  fontWeight: FontWeight.bold,
                ),
              ),
              drawerTextButton(
                  context: context, text: "All", type: "all", user: user),
              drawerTextButton(
                  context: context, text: "Notes", type: "note", user: user),
              drawerTextButton(
                  context: context, text: "Lists", type: "list", user: user),
            ],
          ),
        ),
      ),
    );
  }
}
