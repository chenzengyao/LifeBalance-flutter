import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationMessage{
  String message;
  String senderID;
  String receiverID;
  String timeStamp;
  ConversationMessage({this.message,this.receiverID,this.senderID,this.timeStamp });

  factory ConversationMessage.message(DocumentSnapshot doc){
    return ConversationMessage(
        message: doc['message'],
        senderID: doc['senderID'],
        receiverID: doc['recieverID'],
        timeStamp:doc['time']
    );
  }
}

class LastMessage{
  final String userID;
  final String message;
  final String time;

  LastMessage({this.userID,this.message,this.time});

  factory LastMessage.fromDocument(DocumentSnapshot doc){
    return LastMessage(
        userID: doc.documentID,
        message: doc['message'],
        time:doc['time']
    );
  }
}