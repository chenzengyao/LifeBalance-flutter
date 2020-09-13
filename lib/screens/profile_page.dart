import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class profile_page extends StatefulWidget {
  //TODO The code below can display user email/username in the app bar
  //TODO Subjected to removal
  const profile_page({
    Key key,
    @required this.user
  }) : super(key: key);
  final UserCredential user;

  @override
  _profile_pageState createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(title: new Text("Profile Page")),

        /* body: Container(
        padding: const EdgeInsets.all(32),
         child: Row(children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Image.asset(
                'images/avatar.png',
                width: 100.0,
                height: 100.0,
                fit: BoxFit.cover,
              ),
            ]),
          ]),*/

        body: new Stack(
          children: <Widget>[
            Positioned(
                width: 150.0,
                top: MediaQuery.of(context).size.height / 20,
                child: Column(children: <Widget>[
                  Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('images/avatar.png'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(55.0)),
                          boxShadow: [
                            BoxShadow(blurRadius: 7.0, color: Colors.black)
                          ])),
                ]))
          ],
        ));
  }
}
