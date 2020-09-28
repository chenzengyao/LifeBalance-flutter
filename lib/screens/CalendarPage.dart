import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar2.dart';
import 'package:lifebalance/screens/TaskPage.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  void _handleNewDate(date) {
    setState(() {
      _selectedDay = date;
      _selectedEvents = _events[_selectedDay] ?? [];
    });
    print(_selectedEvents);
  }

  List _selectedEvents;
  DateTime _selectedDay;

  final Map<DateTime, List> _events = {
    DateTime(2020, 5, 7): [
      {'name': 'Event A', 'isDone': true},
    ],
    DateTime(2020, 5, 9): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
    ],
    DateTime(2020, 5, 10): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
    ],
    DateTime(2020, 5, 13): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
      {'name': 'Event C', 'isDone': false},
    ],
    DateTime(2020, 5, 25): [
      {'name': 'Event A', 'isDone': true},
      {'name': 'Event B', 'isDone': true},
      {'name': 'Event C', 'isDone': false},
    ],
    DateTime(2020, 6, 7): [
      {'name': 'Event A', 'isDone': false},
    ],
    DateTime(2020, 9, 13): [
      {'name': 'Event A', 'isDone': false},
    ],
    DateTime(2020, 9, 19): [
      {'name': 'IM3002 Quiz 1', 'isDone': false},
    ],
  };

  @override
  void initState() {
    super.initState();
    _selectedEvents = _events[_selectedDay] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        //new - add task in app bar
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Task'),
            onPressed: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskPage(),
                ),
              );
            },
          ),
        ],

      ),

      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              child: Calendar(
                startOnMonday: false,
                //weekDays: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
                events: _events,
                onRangeSelected: (range) =>
                    print("Range is ${range.from}, ${range.to}"),
                onDateSelected: (date) => _handleNewDate(date),
                isExpandable: true,
                isExpanded:true,
                eventDoneColor: Colors.green,
                selectedColor: Colors.pink,
                todayColor: Colors.red,
                eventColor: Colors.grey,
                dayOfWeekStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 11),
              ),
            ),
            _buildEventList()
          ],
        ),
      ),
    );
  }

  Widget _buildEventList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) =>
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.5, color: Colors.black12),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: 0.0, vertical: 4.0),
              child: ListTile(
                title: Text(_selectedEvents[index]['name'].toString()),
                onTap: () {},
              ),
            ),
        itemCount: _selectedEvents.length,
      ),
    );
  }
}



