import 'package:flutter/material.dart';

class notification_page extends StatefulWidget {
  @override
  _notification_pageState createState() => _notification_pageState();
}
class _notification_pageState extends State<notification_page> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Notification Page")
        ),
        body: new Center(
            child: new Text("This is notification page")
        )
    );
  }
}
