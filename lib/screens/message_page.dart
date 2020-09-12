import 'package:flutter/material.dart';

class message_page extends StatefulWidget {
  @override
  _message_pageState createState() => _message_pageState();
}

class _message_pageState extends State<message_page> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Message Page")
        ),
        body: new Center(
            child: new Text("This is message page")
        )
    );
  }
}
