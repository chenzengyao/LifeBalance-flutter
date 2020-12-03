import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifebalance/Objects/task.dart';
import 'package:lifebalance/screens/event.dart';
import 'package:lifebalance/widgets/theme.dart';
import 'package:intl/intl.dart';


import 'TaskPage.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;
  const EventDetailsPage({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Event View',
            style: TextStyle(
              fontSize: 20.0,
            )
        ),
        backgroundColor: theme.green,
        toolbarHeight: 65.0,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(event.title, style: Theme.of(context).textTheme.display1,),
            SizedBox(height: 15.0),
            Text(event.description, style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 30.0),
            ButtonTheme(
                minWidth: 90.0,
                height: 40.0,
                child: RaisedButton(
                    child: Text ('Delete Event', style: TextStyle(fontSize: 16.0)),
                    color: theme.kLightGreen,
                    onPressed: ()async{
                      await Firestore.instance.collection('events').document(event.id).delete();
                      Navigator.pop(context);
                    }
                )
            )
          ],
        ),
      ),
    );
  }
}



class TaskEventDetails extends StatefulWidget {
  final TaskEvent event;
  final DocumentReference taskDocRef;

  const TaskEventDetails({Key key, this.event, this.taskDocRef}) : super(key: key);
  @override
  _TaskEventDetailsState createState() => _TaskEventDetailsState();
}

class _TaskEventDetailsState extends State<TaskEventDetails> {



  @override
  Widget build(BuildContext context){
    final dateFormatter = DateFormat('yyyy-MM-dd hh:mm');
    final dateString = dateFormatter.format(widget.event.dueDate);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Event View',
            style: TextStyle(
              fontSize: 20.0,
            )
        ),
        backgroundColor: theme.green,
        toolbarHeight: 65.0,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              widget.event.taskName,
              style: TextStyle(
                fontSize: 32.0,
                fontFamily: 'Courgette',
                fontWeight: FontWeight.bold,
              )
            ),
            SizedBox(height:25.0),
            Text(
              dateString,
              style: TextStyle(
                fontSize: 17.0,
              )
            ),
            SizedBox(height: 5.0),
            Text(
                widget.event.description,
                style: TextStyle(
                    fontSize: 18.0,
                )
            ),
            SizedBox(height: 25.0),
            ButtonTheme(
                minWidth: 50.0,
                height: 40.0,
                child: RaisedButton(
                    child: Text ('Delete Event', style: TextStyle(fontSize: 15.0)),
                    color: theme.kLightGreen,
                    onPressed: ()async{
                      await widget.taskDocRef.delete();
                      Navigator.pop(context);
                    }
                )
            )
          ],
        ),
      ),
    );
  }
}