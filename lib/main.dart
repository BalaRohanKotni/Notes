import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes/views/signUpScreen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Notes",
      home: SignUpScreen(),
    );
  }
}
