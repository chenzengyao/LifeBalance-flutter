import 'package:flutter/material.dart';

class calendar_page extends StatefulWidget {
  @override
  _calendar_pageState createState() => _calendar_pageState();
}

class _calendar_pageState extends State<calendar_page> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Calendar Page")
      ),
      body: new Center(
        child: new Text("This is calendar page")
      )
    );
  }
}
