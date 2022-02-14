import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:room_easy/services/auth.dart';
import 'package:room_easy/screens/wrapper.dart';

class PreRegistration extends StatefulWidget {
  final Function toggleView;
  PreRegistration({ this.toggleView });

  @override
  _PreRegistrationState createState() => _PreRegistrationState();
}

class _PreRegistrationState extends State<PreRegistration> {

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: new BoxDecoration(color: Colors.white),

        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child:

        Flexible(
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topRight,
                child: RawMaterialButton(
                  onPressed: () {},
                  elevation: 1.0,
                  fillColor: Colors.white,
                  child: Text(
                    '?',
                    style: TextStyle(color: Colors.black,fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  padding: EdgeInsets.all(10.0),
                  shape: CircleBorder(
                    side: BorderSide(width: 2, color: Colors.black, style: BorderStyle.solid),
                  ),
                ),

              ),
              SizedBox(height: 120),
              new Image.asset(
                'assets/roomEasy.png',
                width: 200.0,
              ),
              SizedBox(
                height: 60.0,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[400],
                  ),
                  onPressed: () {
                    //Navigator.pushNamed(context, '/sign_in');
                    // widget.toggleView(1);
                    //return Wrapper(registration: false);
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(color: Colors.white),
                  )),
              TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.blue[400],
                  ),
                  onPressed: () {
                    //widget.toggleView(2);
                  },
                  child: Text('Sign Up',
                    style: TextStyle(color: Colors.white),))
              ,

            ],
          ),
        )
    );
  }
}
