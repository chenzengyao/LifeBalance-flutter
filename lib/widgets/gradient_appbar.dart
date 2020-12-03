import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget{
  final double _prefferedHeight = 90.0;

  String title;
  Color gradientBegin, gradientEnd;

  GradientAppBar({this.title, this.gradientBegin, this.gradientEnd}):
        assert(title != null);

  @override
  Widget build(BuildContext context){
    return Container(
      height: _prefferedHeight,
      alignment: Alignment.center,
      padding: EdgeInsets.only(top:20.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color> [
            gradientBegin,
            gradientEnd
          ]
        ) 
      ),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontFamily: 'Roboto',
          fontSize: 20,
          letterSpacing: 2),
      )
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(_prefferedHeight);
}