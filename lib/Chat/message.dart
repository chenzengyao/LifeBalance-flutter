import 'package:cloud_firestore/cloud_firestore.dart';

class ConversationMessage {
  String message;
  String senderID;
  String receiverID;
  String timeStamp;
  DateTime sentTime;
  ConversationMessage(
      {this.message,
        this.receiverID,
        this.senderID,
        this.timeStamp,
        this.sentTime});

  factory ConversationMessage.message(DocumentSnapshot doc) {
    return ConversationMessage(
      message: doc['message'],
      senderID: doc['senderID'],
      receiverID: doc['recieverID'],
      sentTime: DateTime.fromMillisecondsSinceEpoch(
          doc.data['time'].millisecondsSinceEpoch),
        timeStamp:DateTime.fromMillisecondsSinceEpoch(
            doc.data['time'].millisecondsSinceEpoch).toIso8601String(),
    );
  }
}// all done?

class LastMessage {
  final String userID;
  final String message;
  final String time;

  LastMessage({this.userID, this.message, this.time});

  factory LastMessage.fromDocument(DocumentSnapshot doc) {
    return LastMessage(
        userID: doc.documentID, message: doc['message'], time: doc['time']);
  }
}
