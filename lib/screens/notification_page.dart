import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifebalance/theme/colors/light_colors.dart';
import 'package:lifebalance/screens/models/notification_model.dart';
import 'package:lifebalance/screens/chat_screen.dart';
import 'package:lifebalance/widgets/gradient_appbar.dart';
import 'package:lifebalance/widgets/theme.dart';

class notification_page extends StatefulWidget {
  @override
  _notification_pageState createState() => _notification_pageState();
}

class _notification_pageState extends State<notification_page> {
  var selectedIndex, selectedType;
  //final GlobalKey<FormState> _formKeyValue = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: GradientAppBar(
        title: 'Notifications',
        gradientBegin: theme.green,
        gradientEnd: theme.darkergreen
      ), 
      //new AppBar(
          //title: new Text("Notifications"),
          //backgroundColor: LightColors.kGreen

      
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (BuildContext context, int index){
          final chat = chats[index];
          return GestureDetector(
            onTap:() {},
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical:10,
              ),

              child: Row(
                children:<Widget>[
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration:
                    BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),

                      ],

                    ),

                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(chat.sender.imageUrl),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    padding: EdgeInsets.only(
                      left: 20,
                      bottom: 10,
                    ),
                    //decoration: BoxDecoration(
                      //border: Border(bottom: BorderSide(color: Colors.grey[300])),

                    //),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: 210,
                                  height: 30,
                                  child: chat.unread
                                      ?Text(
                                    chat.title,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                      :Text(
                                    chat.title,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                                Divider(),
                              ],
                            ),

                            chat.unread
                                ?Text(
                              chat.time,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            )
                                :Text(
                              chat.time,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: Colors.black54,
                              ),
                            ),
                            Divider(),
                          ],
                        ),
                        SizedBox (
                          height: 10,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.topLeft,
                                width:210,
                                height: 30,
                                child:
                                chat.unread
                                    ?Text(
                                  chat.text,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.blueGrey[800],
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                )
                                    :Text(
                                  chat.text,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              SizedBox(
                                width: 9,
                              ),
                              Divider(),
                            ]
                        )
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ),
      /*body: Form(
          key: _formKeyValue,
          autovalidate: true,
          child: new ListView(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            children: <Widget>[
            SizedBox(height: 40.0),
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("course").snapshots(),
              builder: (context,snapshot) {
                if (!snapshot.hasData) {
                  Text("Loading");
                }
                else {
                  List<DropdownMenuItem> courseList = [];
                  for (int i = 0; i < snapshot.data.docs.length; i++) {
                    DocumentSnapshot snap = snapshot.data.docs[i];
                    courseList.add(
                      DropdownMenuItem(
                        child: Text(
                          snap.id,
                          style: TextStyle(color: Color(0xff11b719)),
                        ),
                        value: "${snap.id}",
                      ),
                    );
                  }
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(width: 50.0),
                      DropdownButton(
                        items: courseList,
                        onChanged: (selectedCourse) {
                          final snackBar = SnackBar(
                            content: Text(
                              'Selected course is index $selectedCourse',
                              style: TextStyle(color: Color(0xff11b719)),
                            ),
                          );
                          Scaffold.of(context).showSnackBar(snackBar);
                          setState(() {
                            courseList = selectedCourse;
                          });
                        },
                        value: selectedIndex,
                        isExpanded: false,
                        hint: new Text(
                          "Choose Course Index from List",
                          style: TextStyle(color: Color(0xff11b719)),
                        ),
                      ),
                    ],
                  );
                }
                return Row();
              }),
              SizedBox(
                height: 150.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  RaisedButton(
                      color: Color(0xff11b719),
                      textColor: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("Submit", style: TextStyle(fontSize: 24.0)),
                            ],
                          )),
                      onPressed: () async {
                      },
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0))),
                ],
              ),
          ],
          ),
    )*/);
  }
}
