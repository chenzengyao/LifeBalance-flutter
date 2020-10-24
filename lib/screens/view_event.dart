import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifebalance/Objects/task.dart';
import 'package:lifebalance/screens/event.dart';
import 'package:lifebalance/widgets/theme.dart';

import 'TaskPage.dart';

class EventDetailsPage extends StatelessWidget {
  final EventModel event;
  const EventDetailsPage({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(
            event.title,
            style: TextStyle(
              fontSize: 25.0,
            )
        ),
        backgroundColor: theme.green,
        toolbarHeight: 100.0,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(event.title, style: Theme.of(context).textTheme.display1,),
            SizedBox(height: 20.0),
            Text(event.description, style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 20.0),
            ButtonTheme(
                minWidth: 90.0,
                height: 40.0,
                child: RaisedButton(
                    child: Text ('Delete', style: TextStyle(fontSize: 16.0)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.event.taskName,
            style: TextStyle(
              fontSize: 25.0,
            )
        ),
        backgroundColor: theme.green,
        toolbarHeight: 100.0,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text( widget.event.taskName, style: Theme.of(context).textTheme.display1,),
            SizedBox(height: 20.0),
            Text(widget.event.description, style: TextStyle(fontSize: 20.0)),
            SizedBox(height: 20.0),
            ButtonTheme(
                minWidth: 90.0,
                height: 40.0,
                child: RaisedButton(
                    child: Text ('Delete', style: TextStyle(fontSize: 16.0)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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