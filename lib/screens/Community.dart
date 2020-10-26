import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifebalance/Chat/conversationscreen.dart';
import 'package:lifebalance/Objects/calender.dart';
import 'package:lifebalance/Objects/user.dart';
import 'package:lifebalance/auth/authService.dart';
import 'package:lifebalance/auth/signIn.dart';
import 'package:lifebalance/screens/CalenderExpandedView.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class CommunityPage extends StatefulWidget {
  @override
  CommunityPageState createState() => CommunityPageState();
}

class CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      /// we have the default tab bar view whcih creates a tabbed page for us, we have to give it the count of tabs we want and then we provide it
      /// that many widgets to display, on this case we set the length to 3 and provide three widgets.
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Community"),
          bottom: TabBar(tabs: [
            Tab(
              text: "Calenders",
            ),
            Tab(
              text: "Friends",
            ),
            Tab(
              text: "People",
            ),
          ]),
        ),
        body: TabBarView(
          children: [// these are the three widgets provided
            AllCalenders(),
            AllFriends(),
            AllUsers(),
          ],
        ),
      ),
    );
  }
}

class AllUsers extends StatefulWidget {
  @override
  _AllUsersState createState() => _AllUsersState();
}

class _AllUsersState extends State<AllUsers> {
  @override
  Widget build(BuildContext context) {
    /// this is paginate firestore form the paginate firestore package, it reads 15 documents at a time from firebase, based on the query we provide it
    /// in this case, it is ffetching all registered users so we can add whoever we want.
    return PaginateFirestore(
        itemBuilder: (index, context, doc) {
          var friend = User.fromJson(doc.data);
          return ListTile(
            leading: friend.imageUrl.isNotEmpty
                ? ClipOval(
                child: Image.network(
                  friend.imageUrl,
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ))
                : CircleAvatar(
              backgroundColor: myPink,
              child: Text(friend.name[0].toUpperCase()),
            ),
            title: Text(friend.name),
            subtitle: Text(friend.email),
            trailing: currentUser.uid != friend.uid
                ? FlatButton(
              onPressed: () async {
                if (currentUser.friendList.contains(friend.uid)) {
                  await doc.reference.setData({
                    'friendList':
                    FieldValue.arrayRemove([currentUser.uid])
                  }, merge: true);
                  await currentUserDocumentReference.setData({
                    'friendList': FieldValue.arrayRemove([friend.uid])
                  }, merge: true);
                  setState(() {});
                } else {
                  await doc.reference.setData({
                    'friendList': FieldValue.arrayUnion([currentUser.uid])
                  }, merge: true);
                  await currentUserDocumentReference.setData({
                    'friendList': FieldValue.arrayUnion([friend.uid])
                  }, merge: true);
                  setState(() {});
                }
              },
              child: Text(
                currentUser.friendList.contains(friend.uid)
                    ? "Remove"
                    : "Add",
              ),
            )
                : null,
          );
        },
        query: Firestore.instance.collection('/users').orderBy('email'), // this is the query and above is what to build. so above is the widget it should build based on teh adta it reads from the databse.
        itemBuilderType: PaginateBuilderType.listView);
  }
}

class AllCalenders extends StatefulWidget {
  @override
  _AllCalendersState createState() => _AllCalendersState();
}

class _AllCalendersState extends State<AllCalenders> {
  int reloader = 0;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
        stream: Stream.value(reloader),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return PaginateFirestore( /// same thing again but this time we fetch all calenders so user cna join whichever he wants. He cannot join his own calender.
              query: Firestore.instance
                  .collectionGroup('userCalenders')
                  .where('isPrivate', isEqualTo: false)
                  .orderBy('participantCount', descending: true),
              itemBuilderType: PaginateBuilderType.listView,
              itemBuilder: (index, context, doc) {
                var calenderObj = CalenderObject.fromJson(doc.data);
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CalenderExpandedView(
                            calenderDocRef: doc.reference,
                          )),
                    );
                  },
                  title: Text(calenderObj.calenderTitle),
                  subtitle: Text(calenderObj.calenderDescription),
                  trailing: calenderObj.creatorID != currentUser.uid
                      ? FlatButton(
                    child: Text(currentUser.joinedCalenderPaths
                        .contains(doc.reference.path)
                        ? "Leave"
                        : "Join"),
                    onPressed: () {
                      if (!currentUser.joinedCalenderPaths
                          .contains(doc.reference.path)) {
                        WriteBatch writeBatch =
                        Firestore.instance.batch();
                        writeBatch.setData(
                            currentUserDocumentReference,
                            {
                              'joinedCalenderPaths':
                              FieldValue.arrayUnion(
                                  [doc.reference.path])
                            },
                            merge: true);

                        writeBatch.setData(doc.reference,
                            {'participantCount': FieldValue.increment(1)},
                            merge: true);

                        writeBatch.setData(
                            doc.reference,
                            {
                              'participantList':
                              FieldValue.arrayUnion([currentUser.uid])
                            },
                            merge: true);
                        writeBatch.commit().then((value) {
                          setState(() {});
                        });
                      } else {
                        WriteBatch writeBatch =
                        Firestore.instance.batch();
                        writeBatch.setData(
                            currentUserDocumentReference,
                            {
                              'joinedCalenderPaths':
                              FieldValue.arrayRemove(
                                  [doc.reference.path])
                            },
                            merge: true);

                        writeBatch.setData(
                            doc.reference,
                            {
                              'participantCount': FieldValue.increment(-1)
                            },
                            merge: true);

                        writeBatch.setData(
                            doc.reference,
                            {
                              'participantList': FieldValue.arrayRemove(
                                  [currentUser.uid])
                            },
                            merge: true);
                        writeBatch.commit().then((value) {
                          setState(() {});
                        });
                        // currentUser.joinedCalenderPaths
                        //     .remove(doc.reference.path);
                        // currentUserDocumentReference.setData({
                        //   'joinedCalenderPaths': currentUser.joinedCalenderPaths
                        // }, merge: true).then((value) {
                        //   setState(() {});
                        // });
                      }
                    },
                  )
                      : FlatButton.icon(
                      onPressed: () {
                        doc.reference.delete().then((value) {
                          setState(() {
                            reloader=2;
                          });
                        });
                      },
                      icon: Icon(Icons.delete, color: Colors.red,),
                      label: Text("Delete", style: TextStyle(color: Colors.red),)),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class AllFriends extends StatefulWidget {
  @override
  _AllFriendsState createState() => _AllFriendsState();
}

class _AllFriendsState extends State<AllFriends> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('/users')
          .document(currentUser.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: ListView.builder(
              itemCount: currentUser.friendList.length,/// here we display a user's friends based on the list of friends that he had added.
              itemBuilder: (BuildContext context, int index) {
                return StreamBuilder<DocumentSnapshot>(
                    stream: Firestore.instance
                        .collection('/users')
                        .document(currentUser.friendList[index])
                        .snapshots(),
                    builder: (context, friendsnapshot) {
                      if (friendsnapshot.hasData &&
                          friendsnapshot.data.exists) {
                        var friend = User.fromJson(friendsnapshot.data.data);
                        return ListTile(
                          onLongPress: () async {
                            await currentUserDocumentReference.setData({
                              'friendList': FieldValue.arrayRemove([friend.uid])
                            }, merge: true);
                            setState(() {});
                          },
                          trailing: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ConverstationScreen(
                                        name: friend.name,
                                        userID: friend.uid,
                                      )),
                                );
                              },
                              child: Text("Message")),
                          leading: friend.imageUrl.isNotEmpty
                              ? ClipOval(
                              child: Image.network(
                                friend.imageUrl,
                                height: 50,
                                width: 50,
                                fit: BoxFit.cover,
                              ))
                              : CircleAvatar(
                            backgroundColor: myPink,
                            child: Text(friend.name[0].toUpperCase()),
                          ),
                          title: Text(friend.name),
                          subtitle: Text(friend.email),
                        );
                      } else {
                        return Container();
                      }
                    });
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
