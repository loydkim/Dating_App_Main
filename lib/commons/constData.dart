import 'package:datingappmain/search/searchmain.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ParentClassType{
  Lounge,
  Chat,
  EditProfile,
}

class BottomButtonData{
  IconData iconData;
  Color iconColor;
  BottomButtonData(this.iconData, this.iconColor);
}

class UserData{
  String name;
  String information;
  String intro;
  List<String> userImages;
  List<String> interesting;

  UserData(this.name, this.information, this.intro, this.userImages,
      this.interesting);
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const chat1Image = 'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const chat2Image = 'https://images.pexels.com/photos/1391498/pexels-photo-1391498.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const myProfileImage = 'https://images.pexels.com/photos/1043474/pexels-photo-1043474.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500';
const myProfileName = 'James';

List<UserData> dummyUserDataListInSearch = [
  UserData('Julia','21 / 5km','Nice to meet you',[
    'https://images.pexels.com/photos/1382731/pexels-photo-1382731.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://i.pinimg.com/originals/50/9e/c6/509ec6d95eabe546113967427e70391b.jpg',
    'https://images.pexels.com/photos/1372134/pexels-photo-1372134.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/1468379/pexels-photo-1468379.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
  ],['Shop','Party','Sleep','Travel']),
  UserData('Lucy','23 / 8km','I wanna meet someone',[
    'https://images.pexels.com/photos/1539936/pexels-photo-1539936.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/2797147/pexels-photo-2797147.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.unsplash.com/photo-1515848797093-effe16ccfabb?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTl8fG5lb24lMjBnaXJsfGVufDB8fDB8&ixlib=rb-1.2.1&w=1000&q=80',
    'https://www.fabmood.com/inspiration/wp-content/uploads/2020/10/blonde-hair-color-13.jpg'
  ],['Game','Movie','Netflix','Talk']),
  UserData('Amanda','26 / 12km','Hellllooo',[
    'https://images.pexels.com/photos/1642228/pexels-photo-1642228.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/4723520/pexels-photo-4723520.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/247878/pexels-photo-247878.jpeg?cs=srgb&dl=pexels-pixabay-247878.jpg&fm=jpg'
  ],['Sports','Watch','Walk','Sleep']),
  UserData('Helen','22 / 6km','I am boring',[
    'https://i.pinimg.com/originals/e8/cc/e4/e8cce4252525b456ffe98dc025362ee8.jpg',
    'https://i.pinimg.com/236x/b8/e7/c8/b8e7c8b9dac88d97e4df0ce67a4704d9--ph.jpg',
    'https://www.itl.cat/pngfile/big/77-770860_download-wallpaper-chinese-girl-free.jpg',
  ],['Movie','Sleep','Travel','Party']),
];

List<UserData> dummyUserDataListInLounge() {
  return [
    UserData('Jessi','21 / 11km','I haven’t dated much in recent years because I’ve been so focused on my career.',[
      'https://cdn.pixabay.com/photo/2018/01/13/19/39/fashion-3080644_1280.jpg'
    ],['Travel','Party','Sleep']),
    UserData('Lucy','23 / 4km','If I could play one sport professionally, it would be soccer because I feel like it’s the least harmful.',[
      'https://cdn.pixabay.com/photo/2017/06/24/02/56/art-2436545_1280.jpg'
    ],['Game','Business','Meet']),
    UserData('Lia','22 / 42km','My family. I know it sounds corny, but I’m not ashamed to say it.',[
      'https://cdn.pixabay.com/photo/2017/09/01/21/53/blue-2705642_1280.jpg'
    ],['Sleep','Movie','Netflix']),
    UserData('Daisy','26 / 3km','I legitimately like romantic comedies.',[
      'https://images.pexels.com/photos/1319911/pexels-photo-1319911.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
    ],['Boring','Car','Sports']),
  ];
}

List<BottomButtonData> bottomIconDataList = [
  BottomButtonData(FontAwesomeIcons.redoAlt,Colors.yellow[800]),
  BottomButtonData(FontAwesomeIcons.times,Colors.redAccent),
  BottomButtonData(FontAwesomeIcons.solidStar,Colors.blue[400]),
  BottomButtonData(FontAwesomeIcons.solidHeart,Colors.green[400]),
  BottomButtonData(FontAwesomeIcons.bolt,Colors.purple[400]),
];