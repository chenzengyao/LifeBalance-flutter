/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lifebalance/Chat/message.dart';
import 'package:lifebalance/auth/authService.dart';


import 'chatTile.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: _isLoading?Center(child: CircularProgressIndicator()):Container(
            child: Column(
              //  mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16, 8, 0),
                    child: Text(
                      "Chats",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection('lastMessages'+'${currentUser.uid}').orderBy('time',descending: true).snapshots(),
                      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {

                        if(!snapshot.hasData){
                          return Center(child: Text('No messages start chatting'),);
                        }

                        if(snapshot.connectionState==ConnectionState.waiting){
                          return Center(child: CircularProgressIndicator());
                        }
                        return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final lastMessage=LastMessage.fromDocument(snapshot.data.documents[index]);
                            return ChatTile(
                              lastMessage: lastMessage,

                            );
                          },
                        );
                      }
                  )
                ]),
          ),
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
            FloatingActionButton(
              backgroundColor: Colors.blueGrey[800],
              onPressed: (){

              },
              child: Icon(
                Icons.add,
                size: 45,
              ),
            )
          ]),
        ));
  }
}*/
