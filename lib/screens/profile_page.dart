import 'package:flutter/material.dart';
//import 'package:lifebalance/screens/models/course.dart';
import 'package:lifebalance/screens/services/auth.dart';
//import 'package:lifebalance/screens/services/database.dart';
//import 'package:provider/provider.dart';
//import 'package:lifebalance/screens/CalendarPage.dart';
import 'package:lifebalance/theme/colors/light_colors.dart';
//import 'package:percent_indicator/percent_indicator.dart';
import 'package:lifebalance/widgets/active_project_card.dart';
import 'package:lifebalance/widgets/top_container.dart';

class profile_page extends StatefulWidget {

  @override
  _profile_pageState createState() => _profile_pageState();
}

class _profile_pageState extends State<profile_page> {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    Text subheading(String title) {
      return Text(
        title,
        style: TextStyle(
            color: LightColors.kDarkBlue,
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2),
      );
    }
    double width = MediaQuery.of(context).size.width;

    CircleAvatar calendarIcon() {
      return CircleAvatar(
        radius: 25.0,
        backgroundColor: LightColors.kGreen,
        child: Icon(
          Icons.calendar_today,
          size: 20.0,
          color: Colors.white,
        ),
      );
    }
    /*return StreamProvider<List<Course>>.value(
          value: DatabaseService().courses,
          child: Scaffold(*/
    return Container(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Life Balance'),
              backgroundColor: LightColors.kGreen,
              elevation: 0.0,
              actions: <Widget>[
                FlatButton.icon(
                  icon: Icon(Icons.person, color: Colors.white,),
                  label: Text('Logout', style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    await _auth.signOut(); //return null value to user
                  },
                ),
              ],
            ),
          body: SafeArea(
            child: Column(
              children: <Widget>[
                TopContainer(
                  height: 200,
                  width: width,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'edit',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ]
                    ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 0.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                          CircleAvatar(
                            radius: 50.0,
                            backgroundImage: AssetImage(
                              'assets/images/avatar.png',
                            ),
                          ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
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
                                  Container(
                                    child: Text(
                                      '@myprofile',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      ]),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 30.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  subheading('My Tasks'),
                                  /*GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => CalendarPage()),
                                      );
                                    },
                                    child: calendarIcon(),
                                  ),*/
                                ],
                              ),
                              SizedBox(height: 5.0),
                              Row(
                                children: <Widget>[
                                  ActiveProjectsCard(
                                    cardColor: LightColors.kPurple,
                                    loadingPercent: 0.25,
                                    title: 'Mathematics',
                                    subtitle: '8 Chapters',
                                  ),
                                  SizedBox(width: 20.0),
                                  ActiveProjectsCard(
                                    cardColor: LightColors.kRed,
                                    loadingPercent: 0.6,
                                    title: 'Information Security',
                                    subtitle: '10 Chapters',
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  ActiveProjectsCard(
                                    cardColor: LightColors.kDarkYellow,
                                    loadingPercent: 0.45,
                                    title: 'Digital Electronics',
                                    subtitle: '4 Chapters',
                                  ),
                                  SizedBox(width: 20.0),
                                  ActiveProjectsCard(
                                    cardColor: LightColors.kBlue,
                                    loadingPercent: 0.9,
                                    title: 'Online Flutter Course',
                                    subtitle: '9 Chapters',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
