import 'package:flutter/material.dart';
import 'package:lifebalance/Objects/task.dart';
import 'package:percent_indicator/percent_indicator.dart';

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

      margin: EdgeInsets.symmetric(horizontal: 10.0, ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
       height: 200,
      decoration: BoxDecoration(
        color: cardColor,
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
              backgroundColor: Colors.white10,
              progressColor: Colors.white,
              center: Text(
                '${(loadingPercent*100).round()}%',
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: Colors.white),
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
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white54,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
