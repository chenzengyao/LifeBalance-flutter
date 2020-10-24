import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifebalance/Objects/calender.dart';
import 'package:lifebalance/Objects/task.dart';
import 'package:lifebalance/auth/authService.dart';
import 'package:lifebalance/auth/signIn.dart';
import 'package:lifebalance/screens/TaskPage.dart';
import 'package:lifebalance/screens/view_event.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:lifebalance/screens/event.dart';
import 'package:lifebalance/widgets/top_container_flat.dart';
import 'package:lifebalance/widgets/theme.dart';
import 'dart:core';

class CalendarPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

CollectionReference currentUserCalenderCollectionRef = Firestore.instance
    .collection('/calenders')
    .document(currentUser.uid)
    .collection('userCalenders');

enum CalenderMode { PRIVATE, SHARED }

class _HomePageState extends State<CalendarPage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  CalenderMode calenderMode = CalenderMode.PRIVATE;
  List<dynamic> _selectedSharedEvents = [];
  int calendersReloader;
  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
  }

  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> allEvents) {
    Map<DateTime, List<dynamic>> data = {};
    allEvents.forEach((event) {
      DateTime date = DateTime(
          event.eventDate.year, event.eventDate.month, event.eventDate.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }

  bool isPrivate = true;

  CalenderObject selectedCalender;

  @override
  Widget build(BuildContext context) {
    final user = currentUser;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: theme.green,
          onPressed: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddEventPage(
                  mode: calenderMode,
                  calenderId: calenderMode == CalenderMode.PRIVATE ||
                      selectedCalender == null
                      ? currentUser.myPrivateCalenderID
                      : selectedCalender.calenderID,
                ),
              ),
            );
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              getHeader(),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RaisedButton(
                    child: Text("Start new calender"),
                    onPressed: () {
                      TextEditingController name = new TextEditingController();
                      TextEditingController description =
                      new TextEditingController();
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Calender Title"),
                              TextFormField(
                                controller: name,
                                decoration: InputDecoration(
                                    hintText: "Calender title..."),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Short Description"),
                              TextFormField(
                                controller: description,
                                maxLines: null,
                                decoration: InputDecoration(
                                    hintText: "What is this about.."),
                              ),
                              Center(
                                child: RaisedButton(
                                  color: myPink,
                                  onPressed: () {
                                    var docId = currentUserCalenderCollectionRef
                                        .document()
                                        .documentID;
                                    currentUserCalenderCollectionRef
                                        .document(docId)
                                        .setData(CalenderObject(
                                      calenderTitle: name.text,
                                      calenderDescription: description.text,
                                      creatorID: currentUser.uid,
                                      isPrivate: false,
                                      calenderID: docId,
                                    ).toJson())
                                        .then((value) {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: Text(
                                    "Create Calender",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Spacer(),
                  Text("Private Mode"),
                  Switch(
                    activeColor: Colors.red,
                    value: isPrivate,
                    onChanged: (value) {
                      setState(() {
                        isPrivate = value;
                        _selectedSharedEvents=[];
                        calenderMode = isPrivate
                            ? CalenderMode.PRIVATE
                            : CalenderMode.SHARED;
                      });
                    },
                  ),
                ],
              ),
              calenderMode == CalenderMode.PRIVATE
                  ? getPrivateCalenderBody()
                  : getPublicCalenderBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget getHeader() {
    return TopContainerFlat(
        height: 70,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  //padding: EdgeInsets.only(top: 15),
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: AssetImage(
                      'assets/images/avatar.png',
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        FlatButton.icon(
                          materialTapTargetSize:
                          MaterialTapTargetSize.shrinkWrap,
                          padding: EdgeInsets.only(
                              left: 0, top: 0, right: 0, bottom: 0),
                          label: Text("Add Task",
                              style: TextStyle(color: Colors.white)),
                          icon: Icon(Icons.add, color: Colors.white),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddEventPage(
                                  calenderId:
                                  calenderMode == CalenderMode.PRIVATE ||
                                      selectedCalender == null
                                      ? currentUser.myPrivateCalenderID
                                      : selectedCalender.calenderID,
                                ),
                              ),
                            );
                          },
                        )
                      ],
                    )),
              ],
            ),
            Center(
              child: Text(
                currentUser.name,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ],
        ));
  }

  Widget getPrivateCalenderBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        StreamBuilder<QuerySnapshot>(
            stream: currentUserCalenderCollectionRef
                .document(currentUser.myPrivateCalenderID)
                .collection('events')
                .snapshots(),
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
                  onDaySelected: (date, events) {
                    setState(() {
                      _selectedSharedEvents = events;
                    });
                  },
                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: theme.orange,
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
              (event) => calenderMode==CalenderMode.PRIVATE? ListTile(
            title: Text(event.taskName),
            subtitle: Text(event.description),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TaskEventDetails(
                    event: event,
                    taskDocRef: currentUserCalenderCollectionRef
                        .document(currentUser.myPrivateCalenderID)
                        .collection('events')
                        .document(event.taskID),
                  ),
                ),
              ).then((value) {
                setState(() {});
              });
            },
          ):Container(),
        ),
      ],
    );
  }

  Widget getPublicCalenderBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ValueListenableBuilder(
          valueListenable: ValueNotifier(selectedCalender),
          builder: (context, CalenderObject value, child) {
            if (value == null) {
              return Container();
            } else {
              return Container(
                child: StreamBuilder<QuerySnapshot>(
                    stream: currentUserCalenderCollectionRef
                        .document(value.calenderID)
                        .collection('events')
                        .snapshots(),
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
                            formatButtonTextStyle:
                            TextStyle(color: Colors.white),
                            formatButtonShowsNext: false,
                          ),
                          startingDayOfWeek: StartingDayOfWeek.monday,
                          onDaySelected: (date, events) {
                            setState(() {
                              _selectedSharedEvents = events;
                            });
                          },
                          builders: CalendarBuilders(
                            selectedDayBuilder: (context, date, events) =>
                                Container(
                                    margin: const EdgeInsets.all(4.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: theme.orange,
                                        borderRadius:
                                        BorderRadius.circular(30.0)),
                                    child: Text(
                                      date.day.toString(),
                                      style: TextStyle(color: Colors.white),
                                    )),
                            todayDayBuilder: (context, date, events) =>
                                Container(
                                    margin: const EdgeInsets.all(4.0),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.orange,
                                        borderRadius:
                                        BorderRadius.circular(30.0)),
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
              );
            }
          },
        ),

        ..._selectedSharedEvents.map(
              (event) => _selectedSharedEvents.length>0? ListTile(
            title: Text(event.taskName),
            subtitle: Text(event.description),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => TaskEventDetails(
                    event: event,
                    taskDocRef: currentUserCalenderCollectionRef
                        .document(selectedCalender.calenderID)
                        .collection('events')
                        .document(event.taskID),
                  ),
                ),
              ).then((value) {
                setState(() {});
              });
            },
          ):Container(),
        ),
        Divider(
          indent: 20,
          endIndent: 20,
          thickness: 1,
        ),
        StreamBuilder<int>(
            stream: Stream.value(calendersReloader),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return PaginateFirestore(
                    emptyDisplay: Center(
                        child: Text("No Calenders created yet, create one?")),
                    shrinkWrap: true,
                    itemBuilder: (index, context, doc) {
                      var calenderObj = CalenderObject.fromJson(doc.data);
                      return ListTile(
                        onTap: () {
                          setState(() {
                            selectedCalender = calenderObj;
                          });
                        },
                        title: Text(calenderObj.calenderTitle),
                        subtitle: Text(calenderObj.calenderDescription),
                      );
                    },
                    query: Firestore.instance
                        .collection('/calenders')
                        .document(currentUser.uid)
                        .collection('userCalenders')
                        .where('isPrivate', isEqualTo: false)
                        .orderBy('participantCount'),
                    itemBuilderType: PaginateBuilderType.listView);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ],
    );
  }
}
