import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskEvent {
  String taskID;
  String taskCreatorID;
  String calenderID;
  String taskName;
  String description;
  int quantityOfWork;
  int unitsDone;
  int percentageCompleted;
  DateTime dueDate;
  TimeOfDay time;

  TaskEvent(
      {this.taskID,
        this.taskCreatorID,
        this.taskName,
        this.description,
        this.dueDate,
        this.percentageCompleted,
        this.time,
        this.quantityOfWork});

  /// from json is used when reading data from firestore.
  TaskEvent.fromJson(Map<String, dynamic> json) {
    unitsDone = json['unitsDone'] ?? 0;
    time = TimeOfDay(hour: json['time'] ?? 0, minute: 0);
    taskID = json['taskID'] ?? '';
    calenderID = json['calenderID'] ?? '';
    taskCreatorID = json['taskCreatorID'] ?? "";
    taskName = json['taskName'];
    description = json['description'];
    quantityOfWork = json['quantityOfWork']??1;
    percentageCompleted = json['percentageCompleted'] ?? 0;
    dueDate = DateTime.fromMillisecondsSinceEpoch(
        json['dueDate'].millisecondsSinceEpoch);
  }

  /// to json is used when sending data to firestore.
  Map<String, dynamic> toJson() => {
    'unitsDone': unitsDone,
    'time': time?.hour ?? 0,
    'calenderID': calenderID,
    'taskID': taskID,
    'taskCreatorID': taskCreatorID,
    'taskName': taskName,
    'description': description,
    'quantityOfWork': quantityOfWork,
    'percentageCompleted': percentageCompleted,
    'dueDate': dueDate,
  };
}

Map<DateTime, List<TaskEvent>> generateMapOfEventsFromFirestoreDocuments(
    QuerySnapshot querySnapshot) {
  List<TaskEvent> tasks = List.generate(querySnapshot.documents.length,
          (index) => TaskEvent.fromJson(querySnapshot.documents[index].data));

  Map<DateTime, List<TaskEvent>> events = {};
  tasks.forEach((element) {
    DateTime date = DateTime(
        element.dueDate.year, element.dueDate.month, element.dueDate.day, 12);
    if (events[date] == null) {
      events[date] = [];
    }
    events[date].add(element);
  });
  return events;
}
