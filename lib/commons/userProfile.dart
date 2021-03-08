import 'package:datingappmain/commons/fullPhoto.dart';
import 'package:datingappmain/setting/editProfile.dart';
import 'package:flutter/material.dart';

import 'constData.dart';

class UserProfile extends StatefulWidget {
  UserProfile(this.userName,
      this.userinfor,
      this.userIntro,
      this.userThumbnail,
      this.isSelected);

  String userName;
  String userinfor;
  String userIntro;
  String userThumbnail;
  bool isSelected;

  @override
  State createState() => new _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  Widget titleSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: Text(
              '${widget.userName}, 24',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
              ),
            ),
          ),
          Text(
            widget.userinfor,
            style: TextStyle(
                color: Colors.grey[500],
                fontSize: 20
            ),
          ),
        ],
      ),
    );
  }

  Widget textSection() {
    return Container(
      padding: const EdgeInsets.only(left:32, right: 32),
      child: Text(
        widget.userIntro,
        softWrap: true,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  List<Choice> choices = <Choice>[
    const Choice(title: 'Edit', icon: Icons.edit),
    const Choice(title: 'Delete', icon: Icons.delete_outline),
  ];

  void _select(Choice choice) {
    if (choice.title == 'Edit') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(widget.userName,widget.userIntro,widget.userThumbnail)),
      );
    }else {
      _showDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        actions: <Widget>[
          widget.userName == myProfileName ?
          PopupMenuButton<Choice>(
            onSelected: _select,
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                  value: choice,
                  child: Row(
                    children: <Widget>[
                      Icon(choice.icon),
                      Text(' ${choice.title}'),
                    ],
                  ),
                );
              }).toList();
            },
          ) : Container(),
        ],
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(14,14.0,14,14),
        padding: const EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: Colors.white,
//        border: Border.all(color: Colors.grey[400]),
          borderRadius: BorderRadius.all(
              Radius.circular(25.0)
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 20.0, // has the effect of softening the shadow
              spreadRadius: 5.0, // has the effect of extending the shadow
              offset: Offset(
                4.0, // horizontal, move right 10
                4.0, // vertical, move down 10
              ),
            )
          ],
        ),
        child: Column(
          children: <Widget>[
            Container(
              height: widget.userName == myProfileName || widget.isSelected == true  ? size.height - 140 : size.height - 210,
              child: SingleChildScrollView(
                child: Stack(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child: Image.network(widget.userThumbnail,
                              height: size.height - 360,
                              fit: BoxFit.cover,
                              width: size.width,),
                          ),
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => FullPhoto(url: widget.userThumbnail)));
                          },
                        ),

                        Text('\n\n\n\n'),
                        textSection(),
                      ],
                    ),
                    Positioned(
                        top: size.height - 420,
                        left: size.width / 2 - (size.width / 2) + size.width / 10,
                        child: Container(
                          height: 110,
                          width: size.width - 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.0),
                              color: Colors.white,//Color(0xff0F0F0F),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                )
                              ]
                          ),
                          child: titleSection(),
//                        Center(
//                          child: titleSection(),
//                        ),
                        )
                    ),
                  ],
                ),
              ),
            ),
            widget.userName == myProfileName || widget.isSelected == true ? Container()
                : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: new RawMaterialButton(
                    onPressed: () { },
                    child: new Icon(
                      Icons.clear,
                      color: Colors.black54,
                      size: 44.0,
                    ),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.white,
                    padding: const EdgeInsets.all(15.0),
                  ),
                  margin: EdgeInsets.only(left: 2,right: 2, bottom: 4),
                ),
                Container(
                  child: new RawMaterialButton(
                    onPressed: () { },
                    child: new Icon(
                      Icons.sentiment_satisfied,
                      color: Colors.white,
                      size: 44.0,
                    ),
                    shape: new CircleBorder(),
                    elevation: 2.0,
                    fillColor: Colors.redAccent,
                    padding: const EdgeInsets.all(15.0),
                  ),
                  margin: EdgeInsets.only(left: 2,right: 2, bottom: 4),
                ),
              ],
            )
          ],
        ),
      )
    );
  }

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Do you want to delete your profile?"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("No", style: TextStyle(color: Colors.grey),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

