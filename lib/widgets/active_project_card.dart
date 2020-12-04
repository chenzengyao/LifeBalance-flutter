import 'package:flutter/material.dart';
import 'package:lifebalance/Objects/task.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:lifebalance/widgets/theme.dart';
import 'package:lifebalance/theme/colors/light_colors.dart';

class ActiveProjectsCard extends StatelessWidget {
  final TaskEvent task;
  final Color cardColor;
  final double loadingPercent;
  final String title;
  final String subtitle;

  ActiveProjectsCard({
    this.cardColor,
    this.loadingPercent,
    this.title,
    this.subtitle,
    this.task,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
       height: 200,
      decoration: BoxDecoration(
        boxShadow: [
          new BoxShadow(
            color: Colors.black54,
            blurRadius: 2.0,
            //offset: Offset(2,0)
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [cardColor, LightColors.test1 ]
          ),
        //color: cardColor,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: CircularPercentIndicator(
              animation: true,
              radius: 75.0,
              percent: loadingPercent,
              lineWidth: 5.0,
              circularStrokeCap: CircularStrokeCap.round,
              backgroundColor: Color(0xffdfc4bc),
              progressColor: Color(0xffa04e36),
              center: Text(
                '${(loadingPercent*100).round()}%',
                style: TextStyle(
                    fontSize: 14, color: Colors.black),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Color(0xFF202020),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height:2),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.black54,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
