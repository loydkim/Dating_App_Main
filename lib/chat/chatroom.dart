import 'package:datingappmain/commons/constData.dart';
import 'package:datingappmain/commons/userProfile.dart';
import 'package:flutter/material.dart';

class ChatRoom extends StatefulWidget {
  ChatRoom(this.userName,
      this.userinfor,
      this.userIntro,
      this.userThumbnail);

  String userThumbnail;
  String userName;
  String userinfor;
  String userIntro;

  @override
  State<StatefulWidget> createState() => _ChatRoom();
}

class _ChatRoom extends State<ChatRoom> {
  final TextEditingController _textController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.userName,style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
          ),
          body: Column(
            children: <Widget>[
              Expanded(
                  child: Center(
                    child: ListView(
                      children: [
                        _listItemOther(context,
                            widget.userName,
                            widget.userThumbnail,
                            'Hello~~~~~~~~~~~~~~~ What are you doing?',
                            '11:30pm'),
                        _listItemOther(context,
                            widget.userName,
                            widget.userThumbnail,
                            'How are you?',
                            '11:41pm'),
                        _listItemMine(context,
                            'Nothing!',
                            '11:51pm'),
                        _listItemMine(context,
                            'Hello HelloHelloHello HelloHelloHello HelloHelloHello HelloHelloHello HelloHelloHello HelloHello',
                            '11:51pm')
                      ]
                    ),
                  )
              ),
              _buildTextComposer()
            ],
          ),
        ),
      ),
    );
  }

  Widget _listItemOther(BuildContext context, String name, String thumbnail, String message, String time) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top:16.0),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserProfile(
                              UserData(
                                widget.userName,
                                widget.userinfor,
                                widget.userIntro,
                                [widget.userThumbnail],
                                ['Sleep','Movie']
                              ),
                                ParentClassType.Chat
                            )
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.network(thumbnail,
                            height: 60,
                            fit: BoxFit.cover,
                            width: 60),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(name),
                      Padding(padding: const EdgeInsets.fromLTRB(0,8,0,8),
                        child: Container(
                          constraints: BoxConstraints(maxWidth: size.width - 150),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              child: Text(message,
                                style: TextStyle(color: Colors.black),),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.only(bottom:14.0, left: 4),
              child: Text(time),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listItemMine(BuildContext context, String message, String time) {
    final size = MediaQuery.of(context).size;
    return Padding( padding: const EdgeInsets.only(top:16.0,right: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom:14.0, right: 4,left:8),
            child: Text(time),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(padding: const EdgeInsets.fromLTRB(0,8,0,8),
                child: Container(
                  constraints: BoxConstraints(maxWidth: size.width - 150),
                  decoration: BoxDecoration(
                    color: Colors.green[700],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Text(message,
                        style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return new IconTheme(                                            //new
      data: new IconThemeData(color: Theme.of(context).accentColor), //new
      child: new Container(                                     //modified
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: new Row(
          children: <Widget>[
            new Flexible(
              child: new TextField(
                controller: _textController,
                onSubmitted: _handleSubmitted,
                decoration: new InputDecoration.collapsed(
                    hintText: "Send a message"),
              ),
            ),
            new Container(
              margin: new EdgeInsets.symmetric(horizontal: 4.0),
              child: new IconButton(
                  icon: new Icon(Icons.send),
                  onPressed: () => _handleSubmitted(_textController.text)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _handleSubmitted(String text) async {
    try {

    }catch(e){
      print(e.message);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message),
            );
          }
      );
    }
  }
}