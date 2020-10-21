import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:lifebalance/screens/CalendarPage.dart';
import 'package:lifebalance/screens/friends_page.dart';
import 'package:lifebalance/screens/message_page.dart';
import 'package:lifebalance/screens/notification_page.dart';
import 'package:lifebalance/screens/profile_page.dart';
import 'package:lifebalance/screens/friends/friends/friends_list_page.dart';

class profile_page2 extends StatefulWidget {

  @override
  _profile_page2State createState() => _profile_page2State();
}

class _profile_page2State extends State<profile_page2> {

  int _currentIndex = 0;
  final List<Widget> _children = [
    profile_page(),
    //FriendsListPage to add new friends(keep refreshing itself)
    //FriendsListPage(),
    //friendsPage to show existing(added) friends: CAN ONLY VIEW ADDED FRIENDS' CALENDAR/PROGRESS
    friends_page(),
    CalendarPage(),
    message_page(),
    notification_page()
  ];

  void onTappedBar(int index)
  {
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
      bottomNavigationBar: BottomNavigationBar
        (
        onTap: onTappedBar,
        currentIndex: _currentIndex,

        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text('Profile')
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.supervisor_account),
              title: new Text('Friends')
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.date_range),
              title: new Text('Calendar')
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.mail_outline),
              title: new Text('Messages')
          ),

          BottomNavigationBarItem(
              icon: Icon(Icons.add_alert),
              title: new Text('Notifications')
          ),
        ],
      ),);
  }
}
