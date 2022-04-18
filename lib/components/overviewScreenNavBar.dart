import 'package:flutter/material.dart';

import '../views/overview_screen.dart';

class OverViewScreenNavBar extends StatelessWidget {
  var user;
  OverViewScreenNavBar({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // padding: EdgeInsets.zero,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OverviewScreen(
                            user: user,
                            type: "all",
                          )));
            },
            child: const Text("All"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OverviewScreen(
                            user: user,
                            type: "note",
                          )));
            },
            child: const Text("Notes"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OverviewScreen(
                            user: user,
                            type: "list",
                          )));
            },
            child: const Text("Lists"),
          ),
        ],
      ),
    );
  }
}
