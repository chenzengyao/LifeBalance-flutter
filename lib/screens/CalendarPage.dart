import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar2.dart';
import 'package:flutter_clean_calendar/calendar_tile.dart';
import 'package:lifebalance/screens/TaskPage.dart';
import 'package:date_utils/date_utils.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lifebalance/theme/colors/light_colors.dart';
import 'package:lifebalance/widgets/top_container.dart';
import 'package:lifebalance/widgets/top_container_flat.dart';
//import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final calendarUtils = Utils();
  List<DateTime> selectedMonthsDays;
  Iterable<DateTime> selectedWeekDays;
  DateTime _selectedDate = DateTime.now();
  String currentMonth;
  bool isExpanded = false;
  String displayMonth = "";
  DateTime get selectedDate => _selectedDate;

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

    var monthFormat = DateFormat("MMMM yyyy").format(_selectedDate);
    displayMonth = "${monthFormat[0].toUpperCase()}${monthFormat.substring(1)}";
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
                                    builder: (context) => TaskPage(),
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
          child: Calendar(
            startOnMonday: false,
            //weekDays: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"],
            events: _events,
            onRangeSelected: (range) =>
                print("Range is ${range.from}, ${range.to}"),
            onDateSelected: (date) => _handleNewDate(date),
            isExpandable: true,
            isExpanded: true,
            eventDoneColor: Colors.green,
            selectedColor: Colors.pink,
            todayColor: Colors.red,
            eventColor: Colors.grey,
            dayOfWeekStyle: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w800, fontSize: 11),
          ),
        ),
        _buildEventList()
      ],
    ));
  }

  Widget _buildEventList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            color: LightColors.kLightGreen,
            border: Border(
              bottom: BorderSide(width: 1.5, color: Colors.black12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
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
