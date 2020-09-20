import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,   //Background color of container
      child: Center(
        child: SpinKitChasingDots(  //widget in center
          color: Color(0xFF5E7A6C),      //color of widget
          size: 50.0,
        ),
      ),
    );
  }
}