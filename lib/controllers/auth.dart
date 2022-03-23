import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/controllers/dataServices.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      createUserCollection(user!.uid);
      return user;
    } catch (error) {
      print('Error: ${error.toString()}');
      return null;
    }
  }
}
