import 'package:flutter/material.dart';

import 'package:lifebalance/screens/friends/frienddetails/footer/friend_detail_footer.dart';
import 'package:lifebalance/screens/friends/frienddetails/header/friend_detail_header.dart';
import 'package:lifebalance/screens/friends/friends/friend.dart';
import 'package:meta/meta.dart';
import 'package:lifebalance/theme/colors/light_colors.dart';

import 'friend_detail_body.dart';

class FriendDetailsPage extends StatefulWidget {
  FriendDetailsPage(
    this.friend, {
    @required this.avatarTag,
  });

  final Friend friend;
  final Object avatarTag;

  @override
  _FriendDetailsPageState createState() => new _FriendDetailsPageState();
}

class _FriendDetailsPageState extends State<FriendDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var linearGradient = const BoxDecoration(
      gradient: const LinearGradient(
        begin: FractionalOffset.centerRight,
        end: FractionalOffset.bottomLeft,
        colors: <Color>[
          LightColors.darkergreen,
          LightColors.kGreen,
        ],
      ),
    );

    return new Scaffold(
      body: new SingleChildScrollView(
        child: new Container(
          decoration: linearGradient,
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new FriendDetailHeader(
                widget.friend,
                avatarTag: widget.avatarTag,
              ),
              new Padding(
                padding: const EdgeInsets.all(24.0),
                child: new FriendDetailBody(widget.friend),
              ),
              new FriendShowcase(widget.friend),
            ],
          ),
        ),
      ),
    );
  }
}
