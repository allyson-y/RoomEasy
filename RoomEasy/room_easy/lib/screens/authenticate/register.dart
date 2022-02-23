import 'dart:async';
import 'package:room_easy/models/user.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_easy/services/auth.dart';
import 'package:room_easy/services/database.dart';
import 'package:room_easy/shared/loading.dart';
import 'package:room_easy/shared/constants.dart';
import 'package:room_easy/screens/survey/survey.dart';
import 'package:provider/provider.dart';
import 'package:room_easy/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;

  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  String note = "";
  bool loading = false;

  Timer timer;

  @override
  Widget build(BuildContext context) {
    final _authService = context.watch<AuthService>();

    return loading
        ? Loading()
        : WillPopScope(
            onWillPop: () {
              widget.toggleView(0);
            },
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                title: Text("Create an Account"),
              ),
              body: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Center(
                        child: Container(
                            width: 200,
                            height: 150,
                            /*decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50.0)),*/
                            child: Image.asset('assets/roomEasy.png')),
                      ),
                    ),
                    Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        validator: (val) {
                          return val.isEmpty ? "Enter email" : null;
                        },
                        onChanged: (val) {
                          email = val;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                            hintText: 'Enter valid email id as abc@gmail.com'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 15, bottom: 0),
                      //padding: EdgeInsets.symmetric(horizontal: 15),
                      child: TextFormField(
                        onChanged: (val) {
                          password = val;
                        },
                        validator: (val) {
                          return val.length < 6
                              ? "Enter at least 6 characters for password"
                              : null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Enter secure password'),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        //TODO FORGOT PASSWORD SCREEN GOES HERE
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(color: Colors.blue, fontSize: 15),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              loading = true;
                            });
                            dynamic result =
                                await _authService.registerWithEmailAndPassword(
                                    email.trim(),
                                    password); //NOTE: without trim it gives a email badly formatted bug when you enter email with space
                            if (result == "invalid-email") {
                              setState(() {
                                print("WAAAAA");
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
                              print(
                                  "CURRENT USER: ${_authService.auth.currentUser}");
                              await DatabaseService().addUserInfo(RmEasyUser(
                                  uid_: _authService.auth.currentUser.uid,
                                  name_: _authService.auth.currentUser.uid,
                                  gender_: "",
                                  grade_: 2,
                                  dob_: "12-27-2001",
                                  surveyComplete_: false));
                              _authService.sendVerificationEmail();
                              setState(() {
                                note =
                                    "verification email sent to ${_authService.user}";
                              });
                            }

                            print(result);
                            print(email);
                            print(password);
                            print(loading);
                          } else {}
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                            onTap: () {
                              widget.toggleView(1);
                            },
                            child: Container(
                              width: double.infinity,
                              height: 100,
                              color: Colors.green,
                              child: Text('You can try'),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }

  Future<void> sendVerificationEmail(AuthService _authService) async {
    await _authService.auth.currentUser
        .sendEmailVerification(); //sends verification email
    setState(() {
      note = "verification email sent to ${_authService.user}";
    });
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified(_authService);
    });
  }

  Future<void> checkEmailVerified(AuthService _authService) async {
    User user = _authService.auth.currentUser;

    await user.reload();
    if (user.emailVerified) {
      timer.cancel();

      //https://stackoverflow.com/questions/51484032/flutter-navigation-push-replacement-is-not-working-when-not-placed-in-the-first
      //Navigator.of(context).popUntil((route) => route.isFirst);
      //Navigator.pushReplacementNamed(context, '/survey');
    }
  }
}
