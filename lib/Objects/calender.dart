//calendar class file 
class CalenderObject {
  String calenderTitle;
  List<String> participantList=[];
  int participantCount=0;
  String creatorID;
  String calenderID;
  String calenderDescription;
  bool isPrivate = false;

  CalenderObject(
      {this.calenderTitle,
        this.creatorID,
        this.calenderDescription,
        this.participantCount,
        this.participantList,
        this.isPrivate,
        this.calenderID});
  
  //map list of attirbutes as json object file into firestore
  Map<String, dynamic> toJson() => {
    'isPrivate': isPrivate,
    'calenderTitle': calenderTitle,
    'creatorID': creatorID,
    'participantCount': participantCount,
    'participantList': participantList, //users that join public calendar, stored as their unique user id
    'calenderID': calenderID,
    'calenderDescription': calenderDescription,
  };

  CalenderObject.fromJson(Map<String, dynamic> json) {
    isPrivate = json['isPrivate'] ?? false;
    calenderTitle = json['calenderTitle'];
    calenderDescription = json['calenderDescription'];
    creatorID = json['creatorID'];
    participantCount = json['participantCount'];
    participantList = json['participantList']?.cast<String>() ?? [];
    calenderID = json['calenderID'];
  }
}
