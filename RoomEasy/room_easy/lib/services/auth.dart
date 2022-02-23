import 'package:flutter/material.dart';
import 'package:room_easy/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Timer timer;

  Stream<User> get user {
    print("user changed state");
    return _auth.authStateChanges();
  }

  FirebaseAuth get auth {
    return _auth;
  }

  Future sendVerificationEmail() async {
    await _auth.currentUser.sendEmailVerification(); //sends verification email
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
  }

  Future checkEmailVerified() async {
    User user = _auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      notifyListeners();

      //https://stackoverflow.com/questions/51484032/flutter-navigation-push-replacement-is-not-working-when-not-placed-in-the-first
      //Navigator.of(context).popUntil((route) => route.isFirst);
      //Navigator.pushReplacementNamed(context, '/survey');
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      print("Register method fired");
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else {
        print("OK WHAT ");
        print(e.message + "$email 111111111");
        return e.code;
      }
    } catch (e) {
      print(e);
      print("WTF WHY");
      return e.code;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      print("sign in method fired");
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("ok");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-email') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return e.code;
    } catch (e) {
      print("jeffy");
      return ('user-not-found');
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
