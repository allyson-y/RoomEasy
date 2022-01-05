import 'package:flutter/material.dart';
import 'package:room_easy/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User> get user {
    print("user changed state");
    return _auth.authStateChanges();
  }

  FirebaseAuth get auth {
    return _auth;
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return e.code;
    } catch (e) {
      print(e);
      return ("Invalid email");
    }
  }
  Future signInWithEmailAndPassword(String email, String password) async{
    try {
      print("sign in method fired");
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      print("ok");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code=='invalid-email') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return e.code;
    }
    catch(e)
    {
      print("jeffy");
      return('user-not-found');
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
