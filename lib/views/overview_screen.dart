import 'package:flutter/material.dart';
import '../components/circle_button.dart';
import '../constants.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<OverviewScreen> createState() => OverviewScreenState();
}

class OverviewScreenState extends State<OverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Notes",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40.0,
                  fontFamily: 'LobsterTwo',
                  fontWeight: FontWeight.bold,
                ),
              ),
              CircleButton(
                iconTD: Icons.settings,
                colorTD: appTheme,
                bgTD: Colors.white,
                onTap: () async {
                  // TODO: SETTINGS PAGE
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (bContext) => SettingsScreen(
                  //       theme: widget.theme,
                  //       mode: widget.backupMode,
                  //       version: widget.versionNumber,
                  //     ),
                  //   ),
                  // );
                },
              )
            ],
          ),
        ),
        backgroundColor: appTheme,
      ),
      body: SafeArea(
        child: Text(
          "Hello World!",
        ),
      ),
    );
  }
}
