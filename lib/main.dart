import 'package:flutter/material.dart';
import 'package:notes/views/login_signupScreen.dart';
import 'views/overview_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Notes",
      home: LoginSignupScreen(),
    );
  }
}
