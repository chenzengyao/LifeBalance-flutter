import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lifebalance/Objects/task.dart';
import 'package:lifebalance/auth/authService.dart';
import 'package:lifebalance/screens/Others/CoursePage.dart';
import 'package:lifebalance/screens/editProfile.dart';
//import 'package:lifebalance/screens/models/course.dart';
//import 'package:lifebalance/screens/services/database.dart';
//import 'package:provider/provider.dart';
//import 'package:lifebalance/screens/CalendarPage.dart';
import 'package:lifebalance/theme/colors/light_colors.dart';
//import 'package:percent_indicator/percent_indicator.dart';
import 'package:lifebalance/widgets/active_project_card.dart';
import 'package:lifebalance/widgets/top_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class profile_page extends StatefulWidget {
  @override
  _profile_pageState createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;


    /*return StreamProvider<List<Course>>.value(
          value: DatabaseService().courses,
          child: Scaffold(*/
    return Container(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text('Life Balance'),
            backgroundColor: LightColors.kGreen,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: Text(
                  'Logout',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut(); //return null value to user
                },
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                TopContainer(
                  width: width,
                  // height: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                currentUser.imageUrl.isNotEmpty
                                    ? ClipOval(
                                    child: Image.network(
                                      currentUser.imageUrl,
                                      height: 50,
                                      width: 50,
                                      fit: BoxFit.cover,
                                    ))
                                    : CircleAvatar(
                                  radius: 50.0,
                                  backgroundImage: AssetImage(
                                    'assets/images/avatar.png',
                                  ),
                                ),
                                StreamBuilder<DocumentSnapshot>(
                                  ///another stream builder continuously connected to database and watching the current user document, whenever the document chanegs, such as uodated, this widget will show new changes
                                    stream:
                                    currentUserDocumentReference.snapshots(),
                                    builder: (context, snapshot) {
                                      return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              currentUser.name,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              '${currentUser.email}',
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w200,
                                              ),
                                            ),
                                      ),
                                      SizedBox(height: 15),
                                      ButtonTheme(
                                          minWidth: 10,
                                          height: 30,
                                          child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        18.0)),
                                            color: LightColors.test5,
                                            elevation: 0.0,
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .push(MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfile(
                                                  user: currentUser,
                                                ),
                                              ));
                                            },
                                            child: Text(
                                              "Edit Profile",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          )
                                          )
                                        ],
                                      );
                                    })
                              ],
                            ),
                          )
                        ]),
                  ),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                      child: Column(
                        children: <Widget>[
                          PaginateFirestore(
                              shrinkWrap: true,
                              itemBuilder: (index, context, doc) {
                                return Container(
                                  child: StreamBuilder<DocumentSnapshot>(
                                      stream: doc.reference.snapshots(),
                                      builder: (context, tasksnapshot) {
                                        if (tasksnapshot.hasData) {
                                          var task = TaskEvent.fromJson(
                                              tasksnapshot.data.data);
                                          return InkWell(
                                            onTap: () {
                                              /// this is the bottom sheet which the user will click to update his progress in his task.
                                              /// this whole widget is wrapped in a stream builder too so when the task data in database changes
                                              /// this widget rebuilds based on new data.
                                              showModalBottomSheet(
                                                  context: context,
                                                  builder: (context) {
                                                    var workDone =
                                                    task.unitsDone.toDouble();
                                                    return StatefulBuilder(
                                                      builder:
                                                          (context, setState) =>
                                                          Card(
                                                            child: Padding(
                                                              padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                MainAxisSize.min,
                                                                children: [
                                                                  Text(
                                                                    "How much work is done?",
                                                                    style: TextStyle(
                                                                      fontSize: 20,
                                                                    ),
                                                                  ),
                                                                  Slider(
                                                                    divisions: task
                                                                        .quantityOfWork -
                                                                        task.unitsDone,
                                                                    label: workDone
                                                                        .toInt()
                                                                        .toString() +
                                                                        " units",
                                                                    min: task.unitsDone
                                                                        .toDouble(),
                                                                    max: task
                                                                        .quantityOfWork
                                                                        .toDouble(),
                                                                    value: workDone,
                                                                    onChanged: (val) {
                                                                      setState(() {
                                                                        workDone = val;
                                                                      });
                                                                    },
                                                                  ),
                                                                  Text(workDone
                                                                      .toInt()
                                                                      .toString() +
                                                                      " / " +
                                                                      task.quantityOfWork
                                                                          .toString() +
                                                                      " Done"),
                                                                  RaisedButton(
                                                                    onPressed: () {
                                                                      doc.reference.updateData({
                                                                        'unitsDone':
                                                                        workDone
                                                                            .toInt()
                                                                      }).then((value) =>
                                                                          Navigator.of(
                                                                              context)
                                                                              .pop());
                                                                    },
                                                                    child: Text("Save"),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                    );
                                                  });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 2),
                                              child: ActiveProjectsCard(
                                                task: task,
                                                cardColor: LightColors.test4,
                                                loadingPercent: task.unitsDone /
                                                    task.quantityOfWork,
                                                title: task.taskName,
                                                subtitle: task.description,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                );
                              },
                              query: Firestore.instance
                                  .collectionGroup('events')
                                  .where('taskCreatorID',
                                  isEqualTo: currentUser.uid)
                                  .orderBy('dueDate'),
                              itemBuilderType: PaginateBuilderType.gridView),
                          // Row(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: <Widget>[
                          //     subheading('My Tasks'),
                          //     GestureDetector(
                          //       onTap: () {
                          //         Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => CoursePage()),
                          //         );
                          //       },
                          //       child: addCourseIcon(),
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(height: 5.0),
                          // Row(
                          //   children: <Widget>[
                          //     ActiveProjectsCard(
                          //       cardColor: LightColors.kPurple,
                          //       loadingPercent: 0.25,
                          //       title: 'Mathematics',
                          //       subtitle: '8 Chapters',
                          //     ),
                          //     SizedBox(width: 20.0),
                          //     ActiveProjectsCard(
                          //       cardColor: LightColors.kRed,
                          //       loadingPercent: 0.6,
                          //       title: 'Information Security',
                          //       subtitle: '10 Chapters',
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   children: <Widget>[
                          //     ActiveProjectsCard(
                          //       cardColor: LightColors.kDarkYellow,
                          //       loadingPercent: 0.45,
                          //       title: 'Digital Electronics',
                          //       subtitle: '4 Chapters',
                          //     ),
                          //     SizedBox(width: 20.0),
                          //     ActiveProjectsCard(
                          //       cardColor: LightColors.kBlue,
                          //       loadingPercent: 0.9,
                          //       title: 'Online Flutter Course',
                          //       subtitle: '9 Chapters',
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
