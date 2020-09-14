import 'package:flutter/material.dart';
import 'package:lifebalance/screens/authenticate/authenticate.dart';
import 'package:lifebalance/screens/home/home.dart';
import 'package:lifebalance/screens/profile_page.dart';
import 'package:lifebalance/screens/profile_page2.dart';
import 'package:lifebalance/screens/services/user.dart';
import 'package:provider/provider.dart';

//Dynamic, shows which screens the user sees, either home screen (login success) or
//authentication screen due to login failure, etc.

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //access user(stream) data from provider
    final user = Provider.of<User>(context);
    print(user);

    // return either the Home or Authenticate widget
    if (user == null){
      return Authenticate();  //user signed out, show authenticate (Sign in) screen
    } else {
      return profile_page2(); //show profile_page2(home page) when logged in successfully
    }

  }
}