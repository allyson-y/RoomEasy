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
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                  color: Colors.black,
                  child: IconButton(
                    icon: Icon(Icons.help),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => helpScreen()),
                      );
                    },
                    color: Colors.blue[400],
                  )
              )
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
            child: new Image.asset(
              'assets/roomEasy.png',
              width: 200.0,

            ),
          ),
          SizedBox(
            height: 60.0,
          ),
          TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue[400],
              ),
              onPressed: () {
                widget.toggleView(2);
              },
              child: Text(
                'Create new account',
                style: TextStyle(color: Colors.white),
              )),
          TextButton(
              onPressed: () {
                //Navigator.pushNamed(context, '/sign_in');
                widget.toggleView(1);
                //return Wrapper(registration: false);
              },
              child: Text('Log in')),
        ],
      ),
    );
  }
}

class helpScreen extends StatelessWidget {
  //const helpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('About RoomEasy'),
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Container(
                  height: 300,
                  width: 300,
                  child: Center(
                    child: Text('RoomEasy is a roommate matching app that will give students '
                        'an intuitive and fun way to find the best match for their roommate. '),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Go Back'),
                ),
              ]
          ),
        )
    );
  }
}

