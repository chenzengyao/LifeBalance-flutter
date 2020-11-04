import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lifebalance/auth/authService.dart';

import 'package:provider/provider.dart' as provider;
import 'package:flutter/material.dart';
import 'package:lifebalance/screens/CalendarPage.dart';
import 'package:lifebalance/screens/Community.dart';
import 'package:lifebalance/screens/message_page.dart';
import 'package:lifebalance/screens/notification_page.dart';
import 'package:lifebalance/screens/profile_page.dart';
import 'package:lifebalance/screens/Others/LandingPageNew.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthService().handleAuth(),
    );

    //  provider.StreamProvider<MyUser>.value(   //listen to stream, get user data from user.dart, no value if not signed in
    //   value: AuthService().user,
    //   child: MaterialApp(
    //     home: LandingPageNew(),          //access data from stream
    //   ),
    // );
  }
}

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    profile_page(),
    CommunityPage(),
    CalendarPage(),
    message_page(),
    notification_page()
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('Profile')),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account), title: new Text('Community')),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range), title: new Text('Calendar')),
          BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline), title: new Text('Messages')),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_alert), title: new Text('Notifications')),
        ],
      ),
    );
  }
}
