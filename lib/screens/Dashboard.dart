import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lifebalance/Chat/chatroom.dart';
import 'package:lifebalance/screens/CalendarPage.dart';
import 'package:lifebalance/screens/Community.dart';
import 'package:lifebalance/screens/message_page.dart';
import 'package:lifebalance/screens/notification_page.dart';
import 'package:lifebalance/screens/profile_page.dart';
import 'package:lifebalance/theme/colors/light_colors.dart';
import 'package:lifebalance/widgets/theme.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    profile_page(),
    CommunityPage(),
    CalendarPage(),
    ChatRoom(),
    notification_page()
  ];

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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

      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: LightColors.darkergreen,
        unselectedItemColor: Colors.grey,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('Profile')),
          BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account), title: new Text('Social')),
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
