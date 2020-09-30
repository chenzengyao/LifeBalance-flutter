/*
import 'package:flutter/material.dart';
import 'package:lifebalance/screens/models/course.dart';
import 'package:lifebalance/screens/home/course_tile.dart';
import 'package:provider/provider.dart';

class CourseList extends StatefulWidget {
  @override
  _CourseListState createState() => _CourseListState();
}

class _CourseListState extends State<CourseList> {
  @override
  Widget build(BuildContext context) {

    final courses = Provider.of<List<Course>>(context);

    return ListView.builder(
      itemCount: courses.length,
      itemBuilder: (context, index) {     //go through each item in course list
        return CourseTile(course: courses[index]);
      },
    );
  }
}
*/
