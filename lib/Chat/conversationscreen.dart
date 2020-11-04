import 'dart:async';



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifebalance/Chat/message.dart';
import 'package:lifebalance/auth/authService.dart';
import 'package:lifebalance/auth/signIn.dart';


import 'messagewiget.dart';

class ConverstationScreen extends StatefulWidget {
  final String userID;
  final String name;

  ConverstationScreen({this.userID, this.name});

  @override
  _ConverstationScreenState createState() => _ConverstationScreenState();
}

class _ConverstationScreenState extends State<ConverstationScreen> {
  TextEditingController msgController = TextEditingController();
  ScrollController msgScrollController = new ScrollController();
  FocusNode focusNode = new FocusNode();

// var formkey=GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      print("focus");
      msgScrollController.jumpTo(msgScrollController.position.maxScrollExtent);
    });
  }

  sendMessage() async {
    if (msgController.text[0] != ' ') {
      msgScrollController.jumpTo(msgScrollController.position.maxScrollExtent);
      String temp = msgController.text;
      final time = DateTime.now();
      msgController.clear();
      // is this code from rippel yes
      await Firestore.instance
          .collection('conversations')
          .document(currentUser.uid)
          .collection('chats')
          .document(widget.userID)
          .collection('messages')
          .add({
        'senderID': currentUser.uid,
        'recieverID': widget.userID,
        'message': temp,
        'time': time
      });
      await Firestore.instance
          .collection('conversations')
          .document(widget.userID)
          .collection('chats')
          .document(currentUser.uid)
          .collection('messages')
          .add({
        'senderID':currentUser.uid,
        'recieverID': widget.userID,
        'message': temp,
        'time': time
      });

      await Firestore.instance
          .collection('conversations')
          .document(currentUser.uid)
          .collection('chats')
          .document(widget.userID)
          .setData({'lastMessage': temp, 'date': time});

      await Firestore.instance
          .collection('conversations')
          .document(widget.userID)
          .collection('chats')
          .document(currentUser.uid)
          .setData({'lastMessage': temp, 'date': time});


    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        focusNode.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          backgroundColor: myPink,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),

          title: Text(
            widget.name.isNotEmpty ? widget.name : "Anonymous",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            // textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
            ),
          ),

          //^[a-zA-Z0-9~!@#$%^&*()`\[\]{};':,./<>?| ]*$
        ),
        bottomSheet: TextFormField(
          // inputFormatters: [
          //   WhitelistingTextInputFormatter(RegExp(r"^[a-zA-Z0-9~!@#$%^&*()`\[\]{};':,./<>?| ]*$")),
          // ],
          focusNode: focusNode,
          controller: msgController,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            hintStyle: TextStyle(fontSize: 13),
            hintText: "Type message",
            isCollapsed: true,
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
            border: InputBorder.none,
            suffixIcon: InkWell(
              onTap: sendMessage,
              child: Icon(
                Icons.send,
                color: myPink,
                size: 20,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          reverse: true,
          controller: msgScrollController,
          child: Container(
            child: Column(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection('conversations')
                      .document(currentUser.uid)
                      .collection('chats')
                      .document(widget.userID)
                      .collection('messages')
                      .orderBy('time', descending: false).limit(200)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (!snapshot.hasData) {
                      return Center(
                        child: Text(
                          'No messages',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }


                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      shrinkWrap: true,
                      //   reverse:true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        msgScrollController.jumpTo(
                            msgScrollController.position.maxScrollExtent);
                        final message = ConversationMessage.message(
                            snapshot.data.documents[index]);
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Message(
                            message: message,
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 40,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
