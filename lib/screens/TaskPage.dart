import 'package:flutter/material.dart';
import 'package:lifebalance/widgets/theme.dart';
import 'package:lifebalance/widgets/top_container.dart';
import 'package:lifebalance/widgets/back_button.dart';
import 'package:lifebalance/widgets/my_text_field.dart';

class TaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    var downwardIcon = Icon(
      Icons.keyboard_arrow_down,
      color: Colors.white,
    );
    return Scaffold(
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
    );
  }
}

