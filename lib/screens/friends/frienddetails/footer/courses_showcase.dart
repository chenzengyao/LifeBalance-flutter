import 'package:flutter/material.dart';

class SkillsShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return new Center(
      child: new Text(
            'IM3080   DESIGN & INNOVATION PROJECT',
          style: TextStyle(fontSize: 16, color: Colors.white), textAlign: TextAlign.left,
      ),
    );
  }
}
