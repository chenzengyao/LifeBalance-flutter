import'package:flutter/material.dart';

class friends_page extends StatefulWidget {
  @override
  _friends_pageState createState() => _friends_pageState();
}

class _friends_pageState extends State<friends_page> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Friends Page")
        ),
        body: new Center(
            child: new Text("This is friends page")
        )
    );
  }
}

