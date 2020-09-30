import 'package:flutter/material.dart';
import 'package:lifebalance/screens/event_firestore_service.dart';
import 'package:lifebalance/screens/TaskPage.dart';
import 'package:lifebalance/screens/view_event.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:lifebalance/screens/event.dart';
import 'package:lifebalance/theme/colors/light_colors.dart';
import 'package:lifebalance/widgets/top_container_flat.dart';
import 'package:lifebalance/widgets/theme.dart';

class CalendarPage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CalendarPage> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Column(
      children: <Widget>[
        TopContainerFlat(
            height: 70,
            width: width,
            child: Stack(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 15),
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
                            FlatButton(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding: EdgeInsets.only(
                                  left: 0, top: 0, right: 0, bottom: 0),
                              child: Column(
                                children: <Widget>[
                                  Text("Add Task",
                                      style: TextStyle(color: Colors.white)),
                                  Icon(Icons.add, color: Colors.white)
                                ],
                              ),
                              onPressed: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddEventPage(),
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
                    'DIP Group 6',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            )),
      Container(
        child: StreamBuilder<List<EventModel>>(
            stream: eventDBS.streamList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<EventModel> allEvents = snapshot.data;
                if (allEvents.isNotEmpty) {
                  _events = _groupEvents(allEvents);
                } else {
                  _events = {};
                  _selectedEvents = [];
                }
              }
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TableCalendar(
                      events: _events,
                      initialCalendarFormat: CalendarFormat.week,
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
                          _selectedEvents = events;
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
                    ),
                    ..._selectedEvents.map((event) => ListTile(
                          title: Text(event.title),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => EventDetailsPage(
                                          event: event,
                                        )));
                          },
                        )),
                  ],
                ),
              );
            }),
      ),
    Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: FloatingActionButton (
                child: Icon(Icons.add),
                backgroundColor: theme.green,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddEventPage(),
                    ),
                  );
                }),
            ),
          ],
        ),
      ],
    )]));}}     

