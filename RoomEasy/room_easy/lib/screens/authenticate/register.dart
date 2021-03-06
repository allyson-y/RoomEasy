import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:room_easy/models/user.dart';
import 'package:room_easy/services/auth.dart';
import 'package:room_easy/services/database.dart';
import 'package:room_easy/shared/loading.dart';

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
  String name = "";
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
              resizeToAvoidBottomInset: false,
              backgroundColor: Color(0xffffefaf),
              // appBar: AppBar(
              //   title: Text("Create an Account"),
              // ),
              body: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Center(
                        child: Container(
                            width: 200,
                            height: 200,
                            /*decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50.0)),*/
                            child: Image.asset('assets/roomEasy.png')),
                      ),
                    ),
                    Padding(
                      //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: TextFormField(
                        validator: (val) {
                          return val.isEmpty ? "Enter Full Name" : null;
                        },
                        onChanged: (val) {
                          name = val;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Full Name',
                            hintText: 'Enter Full Name'),
                      ),
                    ),
                    /*Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: TextFormField(
                            validator: (val) {
                              return val.isEmpty ? "Enter Name" : null;
                            },
                            onChanged: (val) {
                              name = val;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                                hintText: 'Enter Full Name'),
                          ),
                        ),
                        Padding(
                          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: TextFormField(
                            validator: (val) {
                              return val.isEmpty ? "Enter Name" : null;
                            },
                            onChanged: (val) {
                              name = val;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Name',
                                hintText: 'Enter Full Name'),
                          ),
                        ),
                      ],
                    ),*/
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
                    SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                      onPressed: () {
                        //TODO FORGOT PASSWORD SCREEN GOES HERE
                      },
                      child: Text(
                        'Forgot Password',
                        style:
                            TextStyle(color: Color(0xff201cbb), fontSize: 15),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Color(0xff201cbb),
                          borderRadius: BorderRadius.circular(20)),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff201cbb)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(
                                color: Color(0xff201cbb),
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
                            email = email.trim();
                            dynamic result =
                                await _authService.registerWithEmailAndPassword(
                                    email,
                                    password); //NOTE: without trim it gives a email badly formatted bug when you enter email with space
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
                              showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _buildPopupDialog(context),
                              );
                              print(
                                  "CURRENT USER: ${_authService.auth.currentUser}");

                              await _authService.sendVerificationEmail();
                              await DatabaseService().addUserInfo(RmEasyUser(
                                  uid_: _authService.auth.currentUser.uid,
                                  name_: name,
                                  gender_: "",
                                  grade_: 2,
                                  dob_: "12-27-2001",
                                  surveyComplete_: false));
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
                              height: 50,
                              child: Center(child: Text('Tap here to sign in')),
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Verify your email'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            "Please go to your email to verify your account before pressing Accept."),
      ],
    ),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Accept'),
      ),
    ],
  );
}
