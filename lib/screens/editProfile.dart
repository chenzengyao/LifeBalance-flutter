import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lifebalance/Objects/user.dart';
import 'package:lifebalance/auth/authService.dart';
import 'package:lifebalance/auth/signIn.dart';

class EditProfile extends StatefulWidget {
  final User user;
  EditProfile({@required this.user});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name;
    contactController.text = widget.user.email;

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  PickedFile _imagefile;
  final ImagePicker _picker = ImagePicker();
// ignore: non_constant_identifier_names
  Widget ImagePickerWidget() {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 65,
          backgroundColor:
              _imagefile != null ? Colors.transparent : Colors.transparent,
          child: widget.user.imageUrl.isEmpty
              ? _imagefile != null
                  ? ClipOval(
                      child: Image.file(
                        File(_imagefile.path),
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    )
                  : CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage(
                        'assets/images/avatar.png',
                      ),
                    )
              : _imagefile != null
                  ? ClipOval(
                      child: Image.file(
                        File(
                          _imagefile.path,
                        ),
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    )
                  : CircleAvatar(
                      radius: 50.0,
                      backgroundImage: AssetImage(
                        'assets/images/avatar.png',
                      ),
                    ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget myBottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: <Widget>[
          Text(
            'Choose Profile Photo',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                  },
                  icon: Icon(Icons.camera),
                  label: Text('Camera')),
              FlatButton.icon(
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                  },
                  icon: Icon(Icons.image),
                  label: Text('Gallery')),
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    // ignore: non_constant_identifier_names
    final PickedFile = await _picker.getImage(source: source);
    setState(() {
      _imagefile = PickedFile;
    });
  }

  TextEditingController nameController = new TextEditingController();
  TextEditingController contactController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  var formkey = GlobalKey<FormState>();

  validationandSave() async {
    final formState = formkey.currentState;
    if (formState.validate()) {
      formState.save();
      showDialog(
          context: context,
          child: AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 20,
                ),
                Text("Saving"),
              ],
            ),
          ));

      Firestore.instance
          .collection('/users')
          .document(currentUser.uid.trim())
          .updateData({
        'name': nameController.text,
        'email': contactController.text,
      }).then((value) {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Account',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: myPink,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * .05,
                ),
                ImagePickerWidget(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Container(
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .02,
                          ),
                          Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                validator: (val) {
                                  return val.length > 2
                                      ? null
                                      : "Name should be above then 2 characters";
                                },
                                style: TextStyle(fontSize: 19),
                                maxLines: 1,
                                controller: nameController,
                                decoration: InputDecoration(
                                  hintText: "Type Your Name",
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * .03,
                          ),
                          // Text(
                          //   'Email',
                          //   style: TextStyle(
                          //       fontSize: 19, fontWeight: FontWeight.bold),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Container(
                          //   width: MediaQuery.of(context).size.width,
                          //   decoration: BoxDecoration(
                          //       border: Border.all(color: Colors.grey)),
                          //   child: Padding(
                          //     padding:
                          //         const EdgeInsets.symmetric(horizontal: 8.0),
                          //     child: TextFormField(
                          //       enabled: false,
                          //       keyboardType: TextInputType.number,
                          //       // validator: (val) {
                          //       //   return RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                          //       //           .hasMatch(val)
                          //       //       ? null
                          //       //       : "Invalid Format, number length should be less then 13";
                          //       // },
                          //       controller: contactController,
                          //       style: TextStyle(fontSize: 19),
                          //       maxLines: 1,
                          //       decoration: InputDecoration(
                          //         hintText: " Enter Number ",
                          //         focusedBorder: UnderlineInputBorder(
                          //             borderSide:
                          //                 BorderSide(color: Colors.white)),
                          //         enabledBorder: UnderlineInputBorder(
                          //             borderSide:
                          //                 BorderSide(color: Colors.white)),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text(
                //       'Availability',
                //       style:
                //           TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                //     ),
                //   ),
                // ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     child: InkWell(
                //       onTap: () {
                //         // showTimePicker(
                //         //         helpText: "Starting Time",
                //         //         context: context,
                //         //         initialTime: TimeOfDay.now())
                //         //     .then((value) {
                //         //   if (value != null) {
                //         //     availablitiyController.text = value.format(context);
                //         //     start = value;
                //         //     showTimePicker(
                //         //             helpText: "Ending Time",
                //         //             context: context,
                //         //             initialTime: value)
                //         //         .then((svalue) {
                //         //       if (svalue != null) {
                //         //         availablitiyController.text =
                //         //             availablitiyController.text +
                //         //                 " To " +
                //         //                 svalue.format(context);
                //         //         end = svalue;
                //         //       }
                //         //     });
                //         //   }
                //         // });
                //       },
                //       child: TextFormField(
                //         decoration: InputDecoration(
                //           hintText: "Tap to select availability",
                //         ),
                //         enabled: true,
                //         controller: availablitiyController,
                //       ),
                //     ),
                //   ),
                // ),
                // Text("Working Days"),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: List.generate(
                //       7,
                //       (index) => Column(
                //         children: [
                //           Checkbox(
                //               value: selectedDays[days[index]],
                //               onChanged: (val) {
                //                 setState(() {
                //                   selectedDays[days[index]] =
                //                       !selectedDays[days[index]];
                //                 });
                //               }),
                //           Text(days[index]),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     RaisedButton(
                //       onPressed: () {
                //         showTimePicker(
                //                 context: context,
                //                 initialTime: TimeOfDay(hour: 0, minute: 0))
                //             .then((value) {
                //           setState(() {
                //             weekendStart = value;
                //             if (weekendEnd != null && weekendStart != null) {
                //               weekendavailablitiyController.text =
                //                   weekendStart.format(context) +
                //                       " -- " +
                //                       weekendEnd.format(context);
                //             }
                //           });
                //         });
                //       },
                //       child: Text(
                //           weekendStart?.format(context) ?? "Starting Time"),
                //     ),
                //     Text("---"),
                //     RaisedButton(
                //       onPressed: () {
                //         showTimePicker(
                //                 context: context,
                //                 initialTime: TimeOfDay(hour: 0, minute: 0))
                //             .then((value) {
                //           setState(() {
                //             weekendEnd = value;
                //             if (weekendEnd != null && weekendStart != null) {
                //               weekendavailablitiyController.text =
                //                   weekendStart.format(context) +
                //                       " -- " +
                //                       weekendEnd.format(context);
                //             }
                //           });
                //         });
                //       },
                //       child: Text(weekendEnd?.format(context) ?? "Ending Time"),
                //     ),
                //   ],
                // ),
                // Divider(),
                // Text("Weekdays Availability"),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   children: [
                //     RaisedButton(
                //       onPressed: () {
                //         showTimePicker(
                //                 context: context,
                //                 initialTime: TimeOfDay(hour: 0, minute: 0))
                //             .then((value) {
                //           setState(() {
                //             weekdayStart = value;
                //             if (weekdayEnd != null && weekdayStart != null) {
                //               weekdayavailablitiyController.text =
                //                   weekdayStart.format(context) +
                //                       " To " +
                //                       weekdayEnd.format(context);
                //             }
                //           });
                //         });
                //       },
                //       child: Text(
                //           weekdayStart?.format(context) ?? "Starting Time"),
                //     ),
                //     Text("---"),
                //     RaisedButton(
                //       onPressed: () {
                //         showTimePicker(
                //                 context: context,
                //                 initialTime: TimeOfDay(hour: 0, minute: 0))
                //             .then((value) {
                //           setState(() {
                //             weekdayEnd = value;
                //             if (weekdayEnd != null && weekdayStart != null) {
                //               weekdayavailablitiyController.text =
                //                   weekdayStart.format(context) +
                //                       " To " +
                //                       weekdayEnd.format(context);
                //             }
                //           });
                //         });
                //       },
                //       child: Text(weekdayEnd?.format(context) ?? "Ending Time"),
                //     ),
                //   ],
                // ),
                SizedBox(height: MediaQuery.of(context).size.height * .03),
                GestureDetector(
                  onTap: () {
                    validationandSave();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: myPink, borderRadius: BorderRadius.circular(10)),
                    width: MediaQuery.of(context).size.width * .46,
                    height: size.height < 600
                        ? MediaQuery.of(context).size.height * .13
                        : MediaQuery.of(context).size.height * .066,
                    child: Center(
                      child: Text('Update Profile',
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  Map<String, bool> selectedDays = {
    'Mon': false,
    'Tue': false,
    'Wed': false,
    'Thu': false,
    'Fri': false,
    'Sat': false,
    'Sun': false,
  };

  TextEditingController weekendavailablitiyController =
      new TextEditingController();

  TextEditingController weekdayavailablitiyController =
      new TextEditingController();
  TimeOfDay start;
  TimeOfDay end;

  TimeOfDay weekendStart;
  TimeOfDay weekendEnd;

  TimeOfDay weekdayStart;
  TimeOfDay weekdayEnd;
}
