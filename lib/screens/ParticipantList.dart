import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifebalance/Objects/calender.dart';
import 'package:lifebalance/Objects/task.dart';
import 'package:lifebalance/auth/authService.dart';
import 'package:lifebalance/auth/signIn.dart';
import 'package:lifebalance/screens/CalendarPage.dart';
import 'package:lifebalance/screens/TaskPage.dart';
import 'package:lifebalance/screens/view_event.dart';
import 'package:lifebalance/widgets/gradient_appbar.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lifebalance/widgets/theme.dart';
import 'package:lifebalance/Objects/user.dart';

class ParticipantList extends StatefulWidget {
  @override
  _ParticipantListState createState() => _ParticipantListState();
}

class _ParticipantListState extends State<ParticipantList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Participant List'),
        backgroundColor: theme.darkergreen,
        ), 
      /*GradientAppBar(
        title: 'Participant List',
        gradientEnd: theme.green,
        gradientBegin: theme.darkergreen
        ),*/
      body: ListView(
    children: const <Widget>[
    Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.green,
          child: Text ('M')
        ),
        title: Text('Marcus'),
        subtitle: Text('marcus@gmail.com')  
      ),
    ),
    Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.green,
          child: Text ('Y')
        ),
        title: Text('Yu Zhen'),
        subtitle: Text('wyz@gmail.com')  
      ),
    ),
    Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.green,
          child: Text ('A')
        ),
        title: Text('Amari'),
        subtitle: Text('awong@gmail.com')  
      ),
    ),
    Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.green,
          child: Text ('J')
        ),
        title: Text('Jia Dian'),
        subtitle: Text('tanjiadian.tjd@gmail.com')  
      ),
    ),
    Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.green,
          child: Text ('S')
        ),
        title: Text('Shuwen'),
        subtitle: Text('psw99@gmail.com')  
      ),
    ),
    
  ],
));}}
        
        
        /*leading: CircleAvatar(
          backgroundColor: theme.darkergreen,
          child: Text(participant.name[0].toUpperCase()),
                                    ),
                                  );
                              }*/