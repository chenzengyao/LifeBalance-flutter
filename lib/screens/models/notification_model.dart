import 'package:lifebalance/screens/models/user_model.dart';

class Notification {
  final User1 sender;
  final String time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool unread;
  final String title;
  //static bool searching = false;

  Notification({
    this.sender,
    this.time,
    this.text,
    this.unread,
    this.title,
  });
}

// EXAMPLE CHATS ON HOME SCREEN
List<Notification> chats = [
  Notification(
    sender: ironMan,
    title: 'Study Invitation from Liyan',
    time: '2m ago',
    text: 'Hi there, just wondering if you would like to join me for a study session over at the hive.',
    unread: true,
  ),
  Notification(
    sender: captainAmerica,
    title: 'Amari just completed a task!',
    time: '27m ago',
    text: 'Your friend, Amari just completed - IM3001 Tutorial 1!',
    unread: true,
  ),
  Notification(
    sender: blackWindow,
    title:'Shu Wen is taking [IM3002] too!',
    time: '1h ago',
    text: 'Your friend, Shu Wen is also taking IM3001 module! Click here to start a conversation with your friend.',
    unread: false,
  ),
  Notification(
    sender: spiderMan,
    title: 'Marcus just completed a task!',
    time: '1h ago',
    text: 'Your friend, Marcus just completed - IM3001 Tutorial 1!',
    unread: true,
  ),
  Notification(
    sender: hulk,
    title:'Study Invitation from Jasmine',
    time: '3h ago',
    text: 'Hi there, just wondering if you would like to join me for a study session over at the Lee Wee Nam library.',
    unread: false,
  ),
  Notification(
    sender: thor,
    title: 'Xuan Ying just completed a task!',
    time: '4h ago',
    text: 'Your friend, Xuan Ying just completed - IM3001 Tutorial 1!',
    unread: false,
  ),
  Notification(
    sender: scarletWitch,
    title: 'Jia Dian is taking [IM2004] too!',
    time: '6h ago',
    text: 'Your friend, Jia Dian is also taking IM2004 module! Click here to start a conversation with your friend.',
    unread: false,
  ),
  Notification(
    sender: captainMarvel,
    title: 'Zeng Yao just completed a task!',
    time: '7h ago',
    text: 'Your friend, Zeng Yao just completed - IM2003 Tutorial 2!',
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
/*List<Message> messages = [
  Message(
    sender: ironMan,
    time: '5:30 PM',
    text: 'Hey dude! Event dead I\'m the hero. Love you 3000 guys.',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'We could surely handle this mess much easily if you were here.',
    unread: true,
  ),
  Message(
    sender: ironMan,
    time: '3:45 PM',
    text: 'Take care of peter. Give him all the protection & his aunt.',
    unread: true,
  ),
  Message(
    sender: ironMan,
    time: '3:15 PM',
    text: 'I\'m always proud of her and blessed to have both of them.',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'But that spider kid is having some difficulties due his identity reveal by a blog called daily bugle.',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Pepper & Morgan is fine. They\'re strong as you. Morgan is a very brave girl, one day she\'ll make you proud.',
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Yes Tony!',
    unread: true,
  ),
  Message(
    sender: ironMan,
    time: '2:00 PM',
    text: 'I hope my family is doing well.',
    unread: true,
  ),
];*/