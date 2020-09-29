import 'package:flutter/material.dart';
import 'package:lifebalance/widgets/theme.dart';

class TopContainerFlat extends StatelessWidget {
  final double height;
  final double width;
  final Widget child;
  final EdgeInsets padding;
  TopContainerFlat({this.height, this.width, this.child, this.padding});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding!=null ? padding : EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
          color: theme.green,
      ),
      height: height,
      width: width,
      child: child,
    );
  }
}
