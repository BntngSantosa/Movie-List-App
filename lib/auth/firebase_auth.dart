import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Some error occured");
    }
    return null;
  }

  Future<void> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("User registered: ${userCredential.user!.uid}");
    } catch (e) {
      print("Error during registration: $e");
      // Handle registration errors here
    }
  }

  Future<bool> isEmailAlreadyInUse(String email) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: "dummy_password", // using a dummy password to check existence
      );
      // If the above operation is successful, the email is not in use
      await credential.user?.delete(); // delete the dummy user
      return false;
    } catch (e) {
      // If an error occurs, check if it's due to the email being already in use
      if (e.toString().contains('email-already-in-use')) {
        return true;
      }
      return false;
    }
  }
}
