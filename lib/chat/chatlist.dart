import 'package:datingappmain/chat/chatroom.dart';
import 'package:datingappmain/commons/constData.dart';
import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ChatList();
}

class _ChatList extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: const EdgeInsets.fromLTRB(4.0,10,4,10),
      children: <Widget>[
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(chat1Image,
              height: 80,
              fit: BoxFit.cover,
              width: 60),
          ),
          title: Text('Luna'),
          subtitle: Text('Hey ! What is up?'),
          trailing: Padding(
            padding: const EdgeInsets.fromLTRB(4,8,4,4),
            child: Column(
              children: <Widget>[
                Text('April 11'),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,8,0,0),
                  child: CircleAvatar(
                    radius: 9,
                    child: Text('N',style: TextStyle(fontSize: 12),),
                    backgroundColor: Colors.red[400],
                    foregroundColor: Colors.white,
                  )
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatRoom('Luna','Female / 5km / 44m','I bring a lot of energy to what I do and always have some leftover to get into trouble on the weekends at my fav. local bar. (If you play your cards right, maybe we can meet there.)',chat1Image)),
            );
          },
        ),
        Divider(),
        ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.network(chat2Image,
                height: 80,
                fit: BoxFit.cover,
                width: 60),
          ),
          title: Text('Kim'),
          subtitle: Text('I will go to home now'),
          trailing: Padding(
            padding: const EdgeInsets.fromLTRB(4,8,4,4),
            child: Column(
              children: <Widget>[
                Text('April 06'),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatRoom('Kim','Female / 32km / 5h','Lately my hobbies include weightlifting and tinkering with music (no, I will not call myself a DJ). If you want to know more, just ask.',chat2Image)),
            );
          },
        ),
        Divider(),
      ],
    );
  }
}