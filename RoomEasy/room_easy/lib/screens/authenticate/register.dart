import 'package:flutter/material.dart';
import 'package:room_easy/services/auth.dart';
import 'package:room_easy/shared/loading.dart';
import 'package:room_easy/shared/constants.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.brown[100],
            appBar: AppBar(
              backgroundColor: Colors.brown[400],
              elevation: 0.0,
              title: Text("sign up for  brew crew"),
              actions: <Widget>[
                TextButton.icon(
                    onPressed: () {
                      widget.toggleView();
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
                          dynamic result = await _auth
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
                  ],
                ),
              ),
            ),
          );
  }
}
