import 'package:lifebalance/screens/services/database.dart';
import 'package:lifebalance/screens/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on firebase user
  MyUser _userFromFirebaseUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;    //get user uid
  }

  // auth change user stream
  //get information in the stream whenever user sign in/out based on user class
  Stream<MyUser> get user {
    return _auth.authStateChanges()
        .map(_userFromFirebaseUser);
  }

  // sign in anon
  // Future signInAnon() async {
  //   try {
  //     AuthResult result = await _auth.signInAnonymously();
  //     FirebaseUser user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;

      //create a new document for the user with the uid, pass in data to database
      await DatabaseService(uid: user.uid).updateUserData('new user name', '0', 'module name', 0);
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // sign out function (future -> async task, needs time to complete)
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

}