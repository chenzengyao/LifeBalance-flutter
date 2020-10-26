import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lifebalance/Objects/task.dart';
import 'package:lifebalance/auth/authService.dart';
import 'package:lifebalance/screens/CalendarPage.dart';
import 'package:lifebalance/screens/event.dart';
import 'package:flutter/material.dart';
import 'package:lifebalance/screens/event_firestore_service.dart';

class AddEventPage extends StatefulWidget {
  final EventModel note;
  final CalenderMode mode;
  final String calenderId;
  final DocumentReference calenderDocRef;
  const AddEventPage(
      {Key key,
        this.note,
        this.mode,
        @required this.calenderId,
        this.calenderDocRef})
      : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  TextEditingController _title;
  TextEditingController _description;
  DateTime _eventDate;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  bool processing;
  CalenderMode mode;
  int totalUnits=0;
  TextEditingController countController=new TextEditingController();

  @override
  void initState() {
    super.initState();
    mode = widget.mode;
    _title = TextEditingController(
        text: widget.note != null ? widget.note.title : "");
    _description = TextEditingController(
        text: widget.note != null ? widget.note.description : "");
    _eventDate = DateTime.now();
    processing = false;
  }

  TimeOfDay chosenTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note != null ? "Edit Event" : "Add Event",
            style: TextStyle(fontSize: 20, color: Colors.white)),
        backgroundColor: Color(0xFFD1C0B6),
      ),
      key: _key,
      body: Form(
        key: _formKey,
        child: Container(
          alignment: Alignment.center,
          child: ListView(
            children: <Widget>[
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: TextFormField(
                  controller: _title,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter title" : null,
                  style: style,
                  decoration: InputDecoration(
                      labelText: "Title",
                      labelStyle:
                      TextStyle(color: Color(0x50000000), fontSize: 18),
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black))),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                child: TextFormField(
                  controller: _description,
                  minLines: 1,
                  maxLines: 5,
                  validator: (value) =>
                  (value.isEmpty) ? "Please Enter description" : null,
                  style: style,
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle:
                    TextStyle(color: Color(0x50000000), fontSize: 18),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              ListTile(
                title: Text(
                  "Date (YYYY-MM-DD-HH)",
                  style: TextStyle(fontSize: 18.0),
                ),
                subtitle: Text(
                    "${_eventDate.year} - ${_eventDate.month} - ${_eventDate.day} - ${chosenTime?.format(context) ?? TimeOfDay.now().format(context)}",
                    style: TextStyle(fontSize: 15.0)),
                onTap: () async {
                  DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: _eventDate,
                      firstDate: DateTime(_eventDate.year - 5),
                      lastDate: DateTime(_eventDate.year + 5));

                  chosenTime = await showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  if (picked != null) {
                    setState(() {
                      _eventDate = picked;
                    });
                  }
                },
              ),
              SizedBox(height: 10.0),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                child: TextFormField(
                  controller: countController,
                  minLines: 1,
                  maxLines: 5,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if(int.tryParse(value)!=null){
                      totalUnits=int.tryParse(value);
                      return null;
                    }else{
                      return "Value must be a valid number";
                    }


                  },
                  style: style,
                  decoration: InputDecoration(
                    labelText: "Unit Count",
                    labelStyle:
                    TextStyle(color: Color(0x50000000), fontSize: 18),
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              processing
                  ? Center(child: CircularProgressIndicator())
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(30.0),
                  color: Color(0xFFD1C0B6),
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() {
                          processing = true;
                        });
                        if (widget.mode == CalenderMode.PRIVATE) {
                          var taskID = currentUserCalenderCollectionRef
                              .document(widget.calenderId)
                              .collection('events')
                              .document()
                              .documentID;

                          currentUserCalenderCollectionRef
                              .document(widget.calenderId)
                              .collection('events')
                              .document(taskID)
                              .setData(TaskEvent(
                              taskCreatorID: currentUser.uid,
                              taskID: taskID,
                              time: chosenTime,
                              quantityOfWork: totalUnits,
                              taskName: _title.text,
                              description: _description.text,
                              dueDate: _eventDate)
                              .toJson())
                              .then((value) {
                            Navigator.pop(context);
                          });
                        } else {
                          var taskID = currentUserCalenderCollectionRef
                              .document(widget.calenderId)
                              .collection('events')
                              .document()
                              .documentID;

                          currentUserCalenderCollectionRef
                              .document(widget.calenderId)
                              .collection('events')
                              .document(taskID)
                              .setData(TaskEvent(
                              taskCreatorID: currentUser.uid,
                              taskID: taskID,
                              time: chosenTime,
                              taskName: _title.text,
                              description: _description.text,
                              dueDate: _eventDate)
                              .toJson())
                              .then((value) {
                            Navigator.pop(context);
                          });
                        }

                        // if (widget.note != null) {
                        //   await eventDBS.updateData(widget.note.id, {
                        //     "title": _title.text,
                        //     "description": _description.text,
                        //     "event_date": widget.note.eventDate
                        //   });
                        // } else {
                        //   await eventDBS.createItem(EventModel(
                        //       title: _title.text,
                        //       description: _description.text,
                        //       eventDate: _eventDate));
                        // }
                        if (mounted) {
                          setState(() {
                            processing = false;
                          });
                        }
                      }
                    },
                    child: Text(
                      "Save",
                      style: style.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }
}

/*
import 'package:flutter/material.dart';
import 'package:lifebalance/widgets/theme.dart';
import 'package:lifebalance/widgets/top_container.dart';
import 'package:lifebalance/widgets/back_button.dart';
import 'package:lifebalance/widgets/my_text_field.dart';

class TaskPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 10,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
    height: 400,
    width: 300,
    decoration: BoxDecoration(
      color: Color(0xFFD1C0B6),
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(10)
    ),
    child: Column(
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          'Add New Task',
          style: TextStyle(fontSize: 18),
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Event Title',

          ),
        )
      ]
    )
  );
    /* return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
              width: width,
              child: Column(
                children: <Widget>[
                  MyBackButton(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'New Task', //display task name when editing or "New Task" or just use "Task view"
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: <Widget>[
                      MyTextField(label: 'Title'),
                      SizedBox(height: 10),

                      MyTextField(
                        label: 'Date',
                        icon: downwardIcon,
                      ),
                      SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          SizedBox(height: 20),
                          Expanded(
                              child: MyTextField(
                                label: 'Start Time',
                                icon: downwardIcon,
                              )),
                          SizedBox(width: 20),
                          Expanded(
                            child: MyTextField(
                              label: 'End Time',
                              icon: downwardIcon,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 10),
                      MyTextField(label: 'Location'),
                      SizedBox(height: 10),
                      MyTextField(
                        label: 'Description',
                        minLines: 3,
                        maxLines: 3,
                      ),

                    ],
                  ),
                )),
            Container(
              height: 80,
              width: width,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    child: Text(
                      'Confirm Task',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18),
                    ),
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    width: width - 40,
                    decoration: BoxDecoration(
                      color: theme.darkbrown,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ); */
}

*/
