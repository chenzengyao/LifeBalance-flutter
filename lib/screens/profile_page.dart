import 'package:flutter/material.dart';

class profile_page extends StatefulWidget {
  @override
  _profile_pageState createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Profile Page")
        ),
        body: new Center(
            child: new Text("This is profile page")
        )
    );
  }
}
