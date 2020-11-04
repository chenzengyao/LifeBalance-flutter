import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifebalance/Chat/message.dart';
import 'package:lifebalance/auth/authService.dart';
import 'package:lifebalance/auth/signIn.dart';

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
        padding: EdgeInsets.only(left: 16, right: 16, top: 3, bottom: 3),
        child: Row(
          //  crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: widget.message.senderID == currentUser.uid
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
          children: [
            widget.message.senderID == currentUser.uid
                ? Text(
              DateFormat.jm().format(widget.message.sentTime),
              style: TextStyle(
                fontSize: 9,
              ),
            )
                : Container(),
            widget.message.senderID == currentUser.uid
                ? SizedBox(
              width: 5,
            )
                : Container(),
            Container(
              child: Align(
                alignment: (widget.message.senderID == currentUser.uid
                    ? Alignment.topRight
                    : Alignment.topLeft),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: widget.message.senderID == currentUser.uid
                        ? myPink
                        : Colors.grey[200],
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    widget.message.message,
                    style: TextStyle(
                        color: widget.message.senderID == currentUser.uid
                            ? Colors.white
                            : Colors.black),
                  ),
                ),
              ),
            ),
            widget.message.senderID != currentUser.uid
                ? SizedBox(
              width: 5,
            )
                : Container(),
            widget.message.senderID != currentUser.uid
                ? Text(
              DateFormat.jm().format(
                DateTime.tryParse(widget.message.timeStamp),
              ),
              style: TextStyle(
                fontSize: 9,
              ),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}

