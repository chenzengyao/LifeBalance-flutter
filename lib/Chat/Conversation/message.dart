import 'package:flutter/material.dart';
import 'package:lifebalance/Chat/message.dart';
import 'package:lifebalance/auth/authService.dart';



class Message extends StatefulWidget {
  ConversationMessage message;
  Message({this.message});
  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Column(
            children: [
              Container(
                child: Align(
                  alignment: (widget.message.senderID == currentUser.uid
                      ? Alignment.topRight
                      : Alignment.topLeft),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: (widget.message.senderID == currentUser.uid
                          ? Colors.lightBlue
                          : Colors.white),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(widget.message.message ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: (widget.message.senderID == currentUser.uid
                      ? Alignment.topRight
                      : Alignment.topLeft),

                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(30),
                  //   color: (widget.message.type == MessageType.Receiver
                  //       ? Colors.black
                  //       : Colors.black),
                  // ),
                  // padding: EdgeInsets.all(16),
                  child:   Text(widget.message.timeStamp.toString(),style: TextStyle(fontSize:6),),
                ),
              ),


            ]
        ),
      ),
    );
  }
}

// message object

enum MessageType {
  Sender,
  Receiver,
}

class ChatMessage {
  String message;
  MessageType type;
  DateTime date;

  ChatMessage({@required this.message, @required this.type,this.date});
}
