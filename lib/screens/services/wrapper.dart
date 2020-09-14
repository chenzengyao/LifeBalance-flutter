import 'package:lifebalance/screens/profile_page2.dart';
import 'package:lifebalance/screens/services/user.dart';
import 'package:lifebalance/screens/authenticate/authenticate.dart';
import 'package:lifebalance/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();  //show authentication screen if no user logged in
    } else {
      return profile_page2(); //show profile_page2 screen when user logged in
    }

  }
}