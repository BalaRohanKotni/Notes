import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/controllers/dataServices.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future registerWithEmailAndPassword(
      String username, String email, String password) async {
    try {
      var result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      createUserCollection(user!.uid, email, username);
      return user;
    } catch (error) {
      if (error.toString() ==
          '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
        return signInWithEmailAndPassword(email, password);
      }
      rethrow;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      var result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      var user = result.user;
      return user;
    } catch (error) {
      rethrow;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut().then((value) => print("Signed out!"));
    } catch (error) {
      rethrow;
    }
  }
}
