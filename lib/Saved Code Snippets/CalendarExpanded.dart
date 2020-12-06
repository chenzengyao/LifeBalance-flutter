//class to display public calendar in the community calendars
/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifebalance/Objects/calender.dart';
import 'package:lifebalance/Objects/task.dart';
import 'package:lifebalance/auth/authService.dart';
import 'package:lifebalance/auth/signIn.dart';
import 'package:lifebalance/screens/CalendarPage.dart';
import 'package:lifebalance/screens/TaskPage.dart';
import 'package:lifebalance/screens/view_event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lifebalance/widgets/theme.dart';
import 'package:lifebalance/Objects/user.dart';

class CalenderExpandedView extends StatefulWidget {
  final DocumentReference calenderDocRef;

  const CalenderExpandedView({Key key, this.calenderDocRef}) : super(key: key);
  @override
  _CalenderExpandedViewState createState() => _CalenderExpandedViewState();
}

class _CalenderExpandedViewState extends State<CalenderExpandedView> {
  CalenderObject selectedCalender;
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  CalenderMode calenderMode = CalenderMode.PRIVATE;
  List<dynamic> _selectedSharedEvents = [];
  int calendersReloader;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
    widget.calenderDocRef.get().then((value) {
      selectedCalender = CalenderObject.fromJson(value.data);
      setState(() {});
    });
    print(widget.calenderDocRef.path);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          Container(
            height: 50,
            width: 50,
            child: FloatingActionButton(
              child: Icon(
                Icons.people
              ),
              backgroundColor: myPink,
              onPressed: ()=>{/*ParticipantList()*/},
              ),
          ),
            SizedBox(height:10),
          selectedCalender != null
              ? (selectedCalender.creatorID == currentUser.uid ||
              currentUser.joinedCalenderPaths
                  .contains(widget.calenderDocRef.path))
              ? FloatingActionButton(
            child: Icon(Icons.add),
            backgroundColor: theme.darkergreen,
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddEventPage(
                    fromPublic: true,
                    mode: CalenderMode.SHARED,
                    calenderId: widget.calenderDocRef.documentID,
                    calenderDocRef: widget.calenderDocRef,
                  ),
                ),
              );
            },
          )
              : null
              : null,
          
        ],
      ),
      appBar: AppBar(
        title: Text(selectedCalender.calenderTitle),
        backgroundColor: myPink,
      ),
      body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: widget.calenderDocRef.collection('events').snapshots(),
                  builder: (context, eventsnapshot) {
                    if (eventsnapshot.hasData) {
                      return TableCalendar(
                        events: generateMapOfEventsFromFirestoreDocuments(
                            eventsnapshot.data), //_events,
                        initialCalendarFormat: CalendarFormat.month,
                        calendarStyle: CalendarStyle(
                            canEventMarkersOverflow: true,
                            todayColor: Colors.orange,
                            selectedColor: Theme.of(context).primaryColor,
                            todayStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white)),
                        headerStyle: HeaderStyle(
                          centerHeaderTitle: true,
                          formatButtonDecoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          formatButtonTextStyle: TextStyle(color: Colors.white),
                          formatButtonShowsNext: false,
                        ),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        onDaySelected: (date, events,_) {  //we change this part i think, one of my friend cos prev got error, yeah soemtimes happens if the package changes, anyways. plesae show me firestore.
                          setState(() {
                            _selectedSharedEvents = events;
                          });
                        },
                        builders: CalendarBuilders(
                          selectedDayBuilder: (context, date, events) => Container(
                              margin: const EdgeInsets.all(4.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                          todayDayBuilder: (context, date, events) => Container(
                              margin: const EdgeInsets.all(4.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(30.0)),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        calendarController: _controller,
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }),
              ..._selectedSharedEvents.map(
                    (event) => ListTile(
                  title: Text(event.taskName),
                  subtitle: Text(event.description),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TaskEventDetails(
                          event: event,
                          taskDocRef: widget.calenderDocRef
                              .collection('events')
                              .document(event.taskID),
                        ),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                ),
              ),
            ],
          )),
    );
  }
}*/
/*
class ParticipantList extends StatefulWidget {
  final DocumentReference calenderDocRef;

  const ParticipantList({Key key, this.calenderDocRef}) : super(key: key);
  @override
  _ParticipantListState createState() => _ParticipantListState();
}

class _ParticipantListState extends State<ParticipantList> {
  CalenderObject selectedCalender;
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  CalenderMode calenderMode = CalenderMode.PRIVATE;
  List<dynamic> _selectedSharedEvents = [];
  int calendersReloader;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
    widget.calenderDocRef.get().then((value) {
      selectedCalender = CalenderObject.fromJson(value.data);
      setState(() {});
    });
    print(widget.calenderDocRef.path);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
        .collection('/calendars')
        .document(currentUser.uid)
        .snapshots(),
      builder: 
        (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
          if (snapshot.hasData){
            return AlertDialog(
              contentPadding: EdgeInsets.only(left: 25, right: 25),
              title: Center(child: Text("Participant List")),
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
              content: Container(
                height: 400,
                width: 300,
                child: SingleChildScrollView(
                                child: ListView.builder(
                    itemBuilder: (BuildContext context, int index){
                      return StreamBuilder<DocumentSnapshot>(
                        stream: Firestore.instance
                          .collection('/calendars')
                          .document(selectedCalender.participantList[index])
                          .snapshots(),
                          builder: (context, participantsnapshot){
                            if (participantsnapshot.hasData &&
                              participantsnapshot.data.exists){
                                var participant = User.fromJson(participantsnapshot.data.data);
                                return ListTile(
                                  leading: participant.imageUrl.isNotEmpty
                                  ? ClipOval(
                                    child: Image.network(
                                    participant.imageUrl,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ))
                                  : CircleAvatar(
                                    backgroundColor: theme.darkergreen,
                                    child: Text(participant.name[0].toUpperCase()),
                                    ),
                                  );
                              }
                          },
                      );
                    }),
                ),
              )); 
            
          }
        },
      
    );
  }
}
*/