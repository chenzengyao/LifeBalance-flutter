import 'package:lifebalance/auth/authService.dart';
import 'package:lifebalance/screens/Dashboard.dart';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

// Dynamic, shows which screens the user sees, either home screen (login success) or
// authentication screen due to login failure, etc.

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthService().handleAuth();
    // final user = provider.Provider.of<MyUser>(context);
    // print(user);

    // // return either the Home or Authenticate widget
    // if (user == null){
    //   return Authenticate();  //show authentication screen if no user logged in
    // } else {
    //   return Dashboard(); //show profile_page2 screen when user logged in
    // }
  }
}
