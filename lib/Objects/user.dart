class User {
  String name;
  String uid;
  String email;
  String imageUrl;
  String myPrivateCalenderID;
  List<String> myCalenders;
  List<String> friendList;
  List<String> joinedCalenderPaths;


  User({
    this.email,
    this.name,
    this.uid,
    this.imageUrl,
    this.myCalenders,
    this.joinedCalenderPaths,
    this.myPrivateCalenderID,
    this.friendList = const [],
  });

  Map<String, dynamic> toJson() => {
    'joinedCalenderPaths': joinedCalenderPaths,
    'friendList': friendList,
    'name': name,
    'uid': uid,
    'email': email,
    'imageUrl': imageUrl,
    'myCalenders': myCalenders,
    'myPrivateCalenderID': myPrivateCalenderID,
  };

  User.fromJson(Map<String, dynamic> json) {
    joinedCalenderPaths = json['joinedCalenderPaths']?.cast<String>() ?? [];
    friendList = json['friendList']?.cast<String>() ?? [];
    name = json['name'];
    uid = json['uid'];
    email = json['email'];
    imageUrl = json['imageUrl'] ?? "";
    myCalenders = json['myCalenders']?.cast<String>() ?? [];
    myPrivateCalenderID = json['myPrivateCalenderID'] ?? '';
  }
}
