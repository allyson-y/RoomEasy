import 'package:flutter/material.dart';
import 'package:room_easy/services/auth.dart';

class Survey extends StatefulWidget {
  @override
  _SurveyState createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  int _selectedIndex = 0; //int that keeps track of which bottom navigation item is selected
  final AuthService _authService = AuthService();
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: Business',
    ),
    Text(
      'Index 2: School',
    ),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[100],
        elevation: 0.0,
        title: Text("Survey"),
        actions: <Widget>[
          TextButton.icon(
              onPressed: () async {
                await _authService.signOut();
              },
              style: TextButton.styleFrom(primary: Colors.black),
              icon: Icon(Icons.person),
              label: Text("Sign out"))
        ],
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text("Survey"),
          ],
        ),
      ),
    );
  }
}
