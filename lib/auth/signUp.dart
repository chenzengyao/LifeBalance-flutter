import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifebalance/Objects/calender.dart';
import 'package:lifebalance/Objects/user.dart';
import 'package:lifebalance/auth/signIn.dart';
import 'package:lifebalance/theme/colors/light_colors.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

//Edit Colours
//Color myPink = LightColors.kDarkBlue;
Color myPink = LightColors.kGreen;

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Container(
              height: height,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: height * 0.1,
                    ),
                    //CircleAvatar(
                    //  radius: height * 0.1,
                    //  backgroundColor: myPink,
                    //  child: Column(
                    //    mainAxisAlignment: MainAxisAlignment.center,
                    //    children: [
                          Container (
                            margin: EdgeInsets.all(20),
                            width: 200,
                            height: 170,
                            decoration: BoxDecoration(
                              //shape: BoxShape.circle,
                              image: DecorationImage(
                                image: new AssetImage("assets/images/newlogo.png"),
                                fit: BoxFit.fitHeight
                                )
                            ),
                          ),
                    /*       Text(
                            "The Freindly Planner",
                            style: TextStyle(
                              color: Colors.white,
                              letterSpacing: 2,
                            ),
                          ), */
                    //    ],
                    //  ),
                    //),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Name cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      controller: name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.person,
                          color: myPink,
                          size: 20,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: myPink, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        border: InputBorder.none,
                        hintText: "Name",
                      ),
                    ),
                    Divider(),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Email cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      controller: email,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.at,
                          color: myPink,
                          size: 20,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: myPink, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        border: InputBorder.none,
                        hintText: "Email",
                      ),
                    ),
                    Divider(),
                    TextFormField(
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Password cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      controller: password,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          FontAwesomeIcons.lock,
                          color: myPink,
                          size: 20,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: myPink, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        border: InputBorder.none,
                        hintText: "Password",
                      ),
                    ),
                    Divider(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Already have an account? Sign In",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: myPink,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Container(
                      width: width * 0.7,
                      height: height * 0.06,
                      child: RaisedButton(
                        elevation: 15,
                        color: myPink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        onPressed: () {
                          if (formKey.currentState.validate()) {
                            /// standard exception handling, errors are displayed in form of snack bar if they occur while singup or login.
                            try {
                              FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text)
                                  .then((value) {
                                var docID = Firestore.instance
                                    .collection('/calenders')
                                    .document(value.user.uid)
                                    .collection('userCalenders')
                                    .document()
                                    .documentID;
                                Firestore.instance
                                    .collection('/users')
                                    .document(value.user.uid)
                                    .setData(User(
                                  uid: value.user.uid,
                                  email: email.text,
                                  name: name.text,
                                  myCalenders: [],
                                  myPrivateCalenderID: docID,
                                ).toJson())
                                    .then((secondvalue) async {
                                  await Firestore.instance
                                      .collection('/calenders')
                                      .document(value.user.uid)
                                      .collection('userCalenders')
                                      .document(docID)
                                      .setData(CalenderObject(
                                      calenderID: docID,
                                      calenderDescription:
                                      name.text.trim() +
                                          "'s Personal Calender",
                                      calenderTitle: name.text,
                                      creatorID: value.user.uid,
                                      isPrivate: true,
                                      participantCount: 1,
                                      participantList: [value.user.uid])
                                      .toJson());
                                  Navigator.of(context).pop();
                                });
                              });
                            } on PlatformException catch (e) {
                              showSnackBar(e.message, scaffoldKey);
                              print('Failed with error code: ${e.code}');
                              print(e.message);
                            }
                          }
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: width * 0.7,
                      child: Text(
                        "By signing up you agree to the the terms and conditions of Life Balance",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    ),
                    // SizedBox(
                    //   height: height * 0.02,
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
