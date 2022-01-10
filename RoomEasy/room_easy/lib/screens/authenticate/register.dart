import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_easy/services/auth.dart';
import 'package:room_easy/shared/loading.dart';
import 'package:room_easy/shared/constants.dart';
import 'package:room_easy/screens/home/survey.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  String note = "";
  bool loading = false;

  Timer timer;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("sign up for Room Easy"),
              actions: <Widget>[
                TextButton.icon(
                    onPressed: () {
                      //widget.toggleView();
                    },
                    style: TextButton.styleFrom(primary: Colors.black),
                    icon: Icon(Icons.person),
                    label: Text("Sign in"))
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Email"),
                      validator: (val) {
                        return val.isEmpty ? "Enter email" : null;
                      },
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          textInputDecoration.copyWith(hintText: "Password"),
                      validator: (val) {
                        return val.length < 6
                            ? "Enter at least 6 characters for password"
                            : null;
                      },
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _authService
                              .registerWithEmailAndPassword(email, password);
                          if (result == "invalid-email") {
                            setState(() {
                              error = "Email invalid";
                              loading = false;
                            });
                          } else if (result == "email-already-in-use") {
                            setState(() {
                              loading = false;
                              error = "Email already in use";
                            });
                          } else if (result == "weak-password") {
                            setState(() {
                              loading = false;
                              error = "Password too weak";
                            });
                          } else {
                            //valid registration
                            setState(() {
                              loading = false;
                            });
                            sendVerificationEmail();
                          }

                          print(result);
                          print(email);
                          print(password);
                          print(loading);
                        } else {}
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                      style:
                          ElevatedButton.styleFrom(primary: Colors.pink[400]),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(error, style: TextStyle(color: Colors.pink)),
                    SizedBox(
                      height: 20,
                    ),
                    Text(note, style: TextStyle(color: Colors.pink)),
                  ],
                ),
              ),
            ),
          );
  }

  Future<void> sendVerificationEmail() async {
    await _authService.auth.currentUser
        .sendEmailVerification(); //sends verification email
    setState(() {
      note = "verification email sent to ${_authService.user}";
    });
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
  }

  Future<void> checkEmailVerified() async {
    User user = _authService.auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      //https://stackoverflow.com/questions/51484032/flutter-navigation-push-replacement-is-not-working-when-not-placed-in-the-first
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.pushReplacementNamed(context, '/survey');
    }
  }
}
