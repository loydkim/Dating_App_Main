import 'package:cached_network_image/cached_network_image.dart';
import 'package:datingappmain/commons/fullPhoto.dart';
import 'package:datingappmain/search/searchmain.dart';
import 'package:datingappmain/setting/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constData.dart';

class UserProfile extends StatefulWidget {
  UserProfile(this.userData);

  UserData userData;

  @override
  State createState() => new _UserProfile();
}

class _UserProfile extends State<UserProfile> {

  List<Choice> choices = <Choice>[
    const Choice(title: 'Edit', icon: Icons.edit),
    const Choice(title: 'Delete', icon: Icons.delete_outline),
  ];

  void _select(Choice choice) {
    if (choice.title == 'Edit') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EditProfile(widget.userData.name,widget.userData.intro,widget.userData.userImages.first)),
      );
    }else {
      _showDialog();
    }
  }

  List<BottomButtonData> _bottomIconDataList = [
    BottomButtonData(FontAwesomeIcons.redoAlt,Colors.yellow[800]),
    BottomButtonData(FontAwesomeIcons.times,Colors.redAccent),
    BottomButtonData(FontAwesomeIcons.solidStar,Colors.blue[400]),
    BottomButtonData(FontAwesomeIcons.solidHeart,Colors.green[400]),
    BottomButtonData(FontAwesomeIcons.bolt,Colors.purple[400]),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
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
        padding: const EdgeInsets.only(top:8.0),
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
                    onTap: () {
                      Navigator.push(
                          context, MaterialPageRoute(builder: (context) => FullPhoto(imageUrlList: widget.userData.userImages,initIndex: 0,)));
                    },
                  ),
                  Positioned(
                    bottom: 4,
                    left: 4,
                    child: _userInformation(widget.userData)
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0,8,12,8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _bottomIconDataList.map(_bottomButtonWidget).toList(),
              ),
            )
          ],
        ),
      )
    );
  }



  Widget _userInformation(UserData userData) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  userData.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 36,
                      shadows: [ Shadow(blurRadius: 1.0,color: Colors.black,offset: Offset(0.6,0.6))]
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Text(
                  userData.information,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      shadows: [ Shadow(blurRadius: 1.0,color: Colors.black,offset: Offset(0.6,0.6))]
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              userData.intro,
              softWrap: true,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
                shadows: [ Shadow(blurRadius: 1.0,color: Colors.black,offset: Offset(0.6,0.6))]
              ),
            ),
          ),
          Wrap(
            children: userData.interesting.map(_interestingWidget).toList(),
          ),
          // _interestingWidget('Shop')
        ],
      ),
    );
  }

  List<Widget> _userProfile(Size size, int index,){
    List<Widget> _returnWidgetList = [];
    // String userImage in _dummyUserDataList[index].userImages
    // for(int i=0 ; i < widget.userData.userImages.length ; i++){
    //   Widget _userWidget =
    //   _returnWidgetList.add(_userWidget);
    // }
    return _returnWidgetList;
  }

  Widget _interestingWidget(String interesting){
    return Padding(
      padding: const EdgeInsets.only(right:8.0,bottom: 4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[700]
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6,4,6,4),
          child: Text(interesting,style: TextStyle(color: Colors.white),),
        ),
      ),
    );
  }

  Widget _bottomButtonWidget(BottomButtonData data){
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:8.0),
        child: new RawMaterialButton(
          onPressed: () { },
          child: new FaIcon(
            data.iconData,
            color: data.iconColor,
            size: (data.iconData == FontAwesomeIcons.times || data.iconData == FontAwesomeIcons.solidHeart) ? 32.0 : 20,
          ),
          shape: new CircleBorder(),
          elevation: 1.0,
          fillColor: Colors.white,
          padding: const EdgeInsets.all(14.0),
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

