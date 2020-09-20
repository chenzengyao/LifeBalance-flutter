import 'package:flutter/material.dart';
//import 'package:lifebalance/screens/models/course.dart';
import 'package:lifebalance/screens/services/auth.dart';
//import 'package:lifebalance/screens/services/database.dart';
//import 'package:provider/provider.dart';

class profile_page extends StatefulWidget {

  @override
  _profile_pageState createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    /*return StreamProvider<List<Course>>.value(
          value: DatabaseService().courses,
          child: Scaffold(*/
    return Container(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
               title: Text('Life Balance'),
              backgroundColor: Colors.blue[400],
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person),
                  label: Text('Logout'),
                  onPressed: () async {
                    await _auth.signOut(); //return null value to user
                  },
                ),
              ],
            ),

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
                              image: AssetImage('assets/images/avatar.png'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.all(Radius.circular(55.0)),
                          boxShadow: [
                            BoxShadow(blurRadius: 7.0, color: Colors.black)
                          ])),
                ]))
          ],
        ),
    //),
    ),
    );
  }
}
