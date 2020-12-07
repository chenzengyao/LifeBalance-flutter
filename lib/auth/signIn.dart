import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lifebalance/auth/signUp.dart';
import 'package:lifebalance/theme/colors/light_colors.dart';

showSnackBar(String message, final scaffoldKey) {
  scaffoldKey.currentState.showSnackBar(
    new SnackBar(
      backgroundColor: Colors.red[600],
      content: new Text(
        message,
        style: new TextStyle(color: Colors.white),
      ),
    ),
  );
}



class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

//Edited colour of all the headers to Green - standardised colours
//Color myPink = LightColors.kDarkBlue;
Color myPink = LightColors.kGreen;

class _SignInState extends State<SignIn> {
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
                    /*CircleAvatar(
                      radius: height * 0.1,
                      backgroundColor: myPink,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [*/
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
                          /*Text(
                            "The Friendly Planner",
                            style: TextStyle(
                              color: Colors.green,
                              letterSpacing: 2,
                            ),
                          ),*/
                        //],
                      //),
                    //),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    //Spacer(),
                    // TextFormField(
                    //   controller: name,
                    //   decoration: InputDecoration(
                    //     prefixIcon: Icon(
                    //       Icons.person,
                    //       color: myPink,
                    //       size: 20,
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: myPink, width: 2),
                    //         borderRadius: BorderRadius.circular(10)),
                    //     border: InputBorder.none,
                    //     hintText: "Name",
                    //   ),
                    // ),
                    // Divider(),
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
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              title: Text("Reset Password"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    controller: email,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "An email will be sent to the above id with instructions to reset your password.",
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: width * 0.7,
                                    height: height * 0.06,
                                    child: RaisedButton(
                                      elevation: 5,
                                      color: Color(0xFFFF6F6F),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      onPressed: () {
                                        if (email.text.isNotEmpty) {
                                          FirebaseAuth.instance
                                              .sendPasswordResetEmail(
                                              email: email.text);
                                        }
                                      },
                                      child: Text(
                                        "Send email",
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ));
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password ?",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: myPink,
                          ),
                        ),
                      ),
                    ),
                    // Divider(),
                    SizedBox(
                      height: height * 0.08,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignUp(),
                        ));
                      },
                      child: Text(
                        "Don't have an account? Sign Up",
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
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            try {
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text);
                            } on PlatformException catch (e) {
                              showSnackBar(e.message, scaffoldKey);
                              print('Failed with error code: ${e.code}');
                              print(e.message);
                            }
                          }
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: height * 0.1,
                    ),
                    // Spacer(),

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
