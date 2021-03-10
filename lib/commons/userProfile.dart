import 'package:cached_network_image/cached_network_image.dart';
import 'package:datingappmain/commons/fullPhoto.dart';
import 'package:datingappmain/commons/userProfileCommon.dart';
import 'package:datingappmain/setting/editProfile.dart';
import 'package:flutter/material.dart';

import 'constData.dart';

class UserProfile extends StatefulWidget {
  UserProfile(this.userData,this.parentClassType);

  UserData userData;
  ParentClassType parentClassType;

  @override State createState() => new _UserProfile();
}

class _UserProfile extends State<UserProfile> with userProfileCommon{

  List<Choice> choices = <Choice>[
    const Choice(title: 'Edit', icon: Icons.edit),
    const Choice(title: 'Delete', icon: Icons.delete_outline),
  ];

  void _select(Choice choice) {
    if (choice.title == 'Edit') {
      Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(widget.userData.name,widget.userData.intro,widget.userData.userImages.first)),);
    }else {
      _showDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.userData.name,style: TextStyle(color: Colors.black),),
            backgroundColor: Colors.white,
            centerTitle: true,
            iconTheme: IconThemeData(
              color: Colors.black, //change your color here
            ),
            actions: <Widget>[
              widget.userData.name == myProfileName ?
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
          body: Padding(
            padding: const EdgeInsets.only(top:8.0,bottom:8.0),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      GestureDetector(
                        child: Container(
                          height: size.height,
                          width: size.width-14,
                          color: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25.0),
                            child:
                            CachedNetworkImage(
                              imageUrl: widget.userData.userImages.first,
                              placeholder: (context, url) => Container(
                                transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                                child: Container(
                                  width: double.infinity,
                                  height: MediaQuery.of(context).size.height*0.77,
                                  child: Center(child: new CircularProgressIndicator())),
                              ),
                              errorWidget: (context, url, error) => new Icon(Icons.error),
                              width: double.infinity,
                              height: MediaQuery.of(context).size.height*0.77,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => FullPhoto(imageUrlList: widget.userData.userImages,initIndex: 0,))),
                      ),
                      Positioned(
                        bottom: 4,
                        left: 4,
                        child: userInformation(widget.userData,size)
                      ),
                    ],
                  ),
                ),
                 widget.parentClassType == ParentClassType.Lounge ? Padding(
                  padding: const EdgeInsets.fromLTRB(12.0,8,12,8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: bottomIconDataList.map(bottomButtonWidget).toList(),
                  ),
                ) : Container()
              ],
            ),
          )
        ),
      ),
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
            new MaterialButton(
              child: new Text("No", style: TextStyle(color: Colors.grey),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new MaterialButton(
              child: new Text("Yes",style: TextStyle(color: Colors.blue),),
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


