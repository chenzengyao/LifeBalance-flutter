//individual chat tile that the chatroom screen calls to render the user, last message, 
//profile pic and date time

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lifebalance/Chat/message.dart';
import 'package:lifebalance/Objects/user.dart';
import 'package:lifebalance/auth/signIn.dart';

import 'conversationscreen.dart';

class ChatTile extends StatefulWidget {
  final LastMessage lastMessage;
  ChatTile({this.lastMessage});
  @override
  _ChatTileState createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  User instructor;
  LastMessage lastMessage;
  @override
  void initState() {
    lastMessage = widget.lastMessage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('/users')
            .where('uid', isEqualTo: widget.lastMessage.userID)
            .limit(1)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              height: 50,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          instructor = User.fromJson(snapshot.data.documents[0].data);
          return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConverstationScreen(
                      userID: instructor.uid,
                      name: instructor.name,
                    ),
                  ),
                );
              },
              child: ListTile(
                title: Text(instructor.name ?? ""),
                leading: instructor.imageUrl.isNotEmpty
                    ? ClipOval(
                    child: Image.network(
                      instructor.imageUrl,
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ))
                    : CircleAvatar(
                  backgroundColor: myPink,
                  child: Text(instructor.name[0].toUpperCase()),
                ),
                subtitle: Text(lastMessage.message ?? ""),
                trailing: Text(
                  DateFormat.yMMMEd().format(
                    DateTime.tryParse(lastMessage.time ?? ""),
                  ),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 10),
                ),
              ));
        });
  }
}
