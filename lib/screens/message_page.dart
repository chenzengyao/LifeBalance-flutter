/*import 'package:flutter/material.dart';
import 'package:lifebalance/screens/models/message_model.dart';
import 'package:lifebalance/screens/chat_screen.dart';
import 'package:lifebalance/theme/colors/light_colors.dart';

class message_page extends StatefulWidget {
  @override
  _message_pageState createState() => _message_pageState();
}

class _message_pageState extends State<message_page> {
  var isSearching = Message.searching;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: LightColors.kGreen,
        brightness: Brightness.dark,
        elevation: 8,
        leading: IconButton(
          icon: Icon(Icons.menu),
          color: Colors.white,
          onPressed: () {},
        ),
        title: !isSearching
        ?Text(
          'Messages',
          style: TextStyle(
            color: Colors.white,
          ),
        )
        :TextField(
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                hintText: "Search user here",
                hintStyle: TextStyle(
                  color: Colors.white,
                )
            )
        ),
        actions: <Widget>[
          isSearching
          ?IconButton(
            icon: Icon(Icons.cancel),
            color: Colors.white,
            onPressed: () {
              setState((){
                this.isSearching = !this.isSearching;
              });
            },
          )
          :IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              setState((){
                this.isSearching = !this.isSearching;
              });
            },
          )

        ],
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (BuildContext context, int index) {
          final Message chat = chats[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatScreen(
                  user: chat.sender,
                ),
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: chat.unread
                        ? BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      border: Border.all(
                        width: 2,
                        color: LightColors.kBrown,
                      ),
                      // shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    )
                        : BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 35,
                      //  backgroundImage: AssetImage(chat.sender.imageUrl),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    padding: EdgeInsets.only(
                      left: 20,
                    ),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  chat.sender.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                true // chat.sender.isOnline
                                    ? Container(
                                  margin: const EdgeInsets.only(left: 5),
                                  width: 7,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                                    : Container(
                                  child: null,
                                ),
                              ],
                            ),
                            Text(
                              chat.time,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            chat.text,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
*/