import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../views/overview_screen.dart';

Container drawerTextButton({
  required BuildContext context,
  required String text,
  required String type,
  required User user,
}) {
  return Container(
    margin: const EdgeInsets.only(top: 10, right: 20),
    child: TextButton(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(const Size.fromHeight(45)),
        alignment: Alignment.centerLeft,
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
      ),
      child: Text(text),
      onPressed: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => OverviewScreen(
                      user: user,
                      type: type,
                    )));
      },
    ),
  );
}
