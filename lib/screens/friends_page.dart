import'package:flutter/material.dart';
import 'package:lifebalance/screens/friends/friends/friends_list_page.dart';

class friends_page extends StatefulWidget {
  @override
  _friends_pageState createState() => _friends_pageState();
}

class _friends_pageState extends State<friends_page> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text("Friends Page"),
          actions: <Widget>[
           //TEMPORARY REDIRECTION
            // Goes to another page for friend list in case any edits are made
            FlatButton.icon(
              icon: Icon(Icons.people, color: Colors.white,),
              label: Text('Add New Friends', style: TextStyle(color: Colors.white),),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FriendsListPage(),
                  ),
                );
              },
            )
          ],
        ),
        body: new Center(
            child: new Text("This is friends page")
        )
    );
  }
}

