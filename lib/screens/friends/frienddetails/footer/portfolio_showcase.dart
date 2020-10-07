import 'package:flutter/material.dart';
//import 'package:lifebalance/widgets/active_project_card.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:lifebalance/theme/colors/light_colors.dart';


class PortfolioShowcase extends StatelessWidget {
/*
  List<Widget> _buildItems() {
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

  }

 */
  List<Widget> _buildItems() {
    var items = <Widget>[];

    for (var i = 1; i <= 6; i++) {
      var image = new Image.asset(
        'images/portfolio_$i.jpeg',
        width: 200.0,
        height: 200.0,
      );

      items.add(image);
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    var delegate = new SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
    );

    return new GridView(
      padding: const EdgeInsets.only(top: 16.0),
      gridDelegate: delegate,
      children: _buildItems(),
    );
  }
}
