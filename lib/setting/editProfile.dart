import 'dart:io';
import 'package:datingappmain/commons/constData.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  EditProfile(this.userName,
      this.userIntro,
      this.userThumbnail);

  String userName;
  String userIntro;
  String userThumbnail;
  @override
  State createState() => new _EditProfile();
}

enum GenderEnum { man, woman }

class _EditProfile extends State<EditProfile> {
  GenderEnum _userGender = GenderEnum.man;
  String _selectDateString = '1996-06-11';
  List<File> _imageList = List<File>.generate(4,(file) => File(''));

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime(DateTime.now().year-22, DateTime.now().month),
        firstDate: DateTime(DateTime.now().year-60, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(DateTime.now().year-18, DateTime.now().month, DateTime.now().day));
    if (picked != null && picked != DateTime.now())
      setState(() {
        _selectDateString = "${picked.toLocal()}".split(' ')[0];
      });
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile',style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black, //change
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image:NetworkImage('https://i.pinimg.com/564x/40/97/a9/4097a9be2792b98cd3c1ed69088ec42f.jpg'),
              fit: BoxFit.cover)
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _userForm(),
                _userPhotos(size),
                _userIntro()
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _userIntro() {
    return Padding(
      padding: const EdgeInsets.only(top:8.0,bottom:28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:18.0,top:6.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Introduce',
                style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
                width: 380,
                height: 200,
                child: Card(child:
                Padding(
                  padding: const EdgeInsets.only(left:16.0,right:16.0,top:8.0,bottom:8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Type about you'
                    ),
                  controller: TextEditingController(text: widget.userIntro),
                  ),
                )
                )
            ),
          ),
        ],
      ),
    );
  }

  Widget _userPhotos(Size size) {
    return Padding(
      padding: const EdgeInsets.only(top:28.0,bottom:28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:18.0,top: 6.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Text('Your photos',
                style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new GestureDetector(
                    onTap: () {
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Container(
                        width: size.width * 0.4,
                        height: size.width * 0.5,
                        child:Card(
                            child:Image.network(widget.userThumbnail,fit: BoxFit.fill,)
                        ),),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new GestureDetector(
                    onTap: () {
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Container(
                        width: size.width * 0.4,
                        height: size.width * 0.5,
                        child:Card(
                            child: Image.network('https://cdn.pixabay.com/photo/2016/03/27/17/40/black-and-white-1283231_1280.jpg',fit: BoxFit.fill,)
                        ),),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new GestureDetector(
                  onTap: () {
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      width: size.width * 0.4,
                      height: size.width * 0.5,
                      child:Card(
                          child: (_imageList[2].path != '')
                              ? Image.file(_imageList[2],fit: BoxFit.fill,)
                              : Icon(Icons.add_photo_alternate,
                              size: 110,color: Colors.grey[700])
                      ),),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: new GestureDetector(
                  onTap: () {
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Container(
                      width: size.width * 0.4,
                      height: size.width * 0.5,
                      child:Card(
                          child: (_imageList[3].path != '')
                              ? Image.file(_imageList[3],fit: BoxFit.fill,)
                              : Icon(Icons.add_photo_alternate,
                              size: 110,color: Colors.grey[700])
                      ),),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _userForm() {
    return Padding(
      padding: const EdgeInsets.only(left:18.0,top: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Personal Information',
            style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
          Padding(
            padding: const EdgeInsets.only(left:8.0,top: 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  width: 360,
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        icon:Icon(Icons.account_circle),
                        labelText: 'Name',
                        hintText: 'Type Name'
                    ),
                    validator: (String value) {
                      if (value.trim().isEmpty) {
                        return 'Name is required';
                      }else {
                        return null;
                      }
                    },
                    controller: TextEditingController(text: myProfileName),
                  ),
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Icon(Icons.wc,color: Colors.grey,),
                    Radio(
                      value: GenderEnum.man,
                      groupValue: _userGender,
                      onChanged: (GenderEnum value) {
                        setState(() {
                          _userGender = value;
                        });
                      },
                    ),
                    new GestureDetector(
                      onTap: () {
                        setState(() {
                          _userGender = GenderEnum.man;
                        });
                      },
                      child: Text('Man'),
                    ),
                    SizedBox(width: 20,),
                    Radio(
                      value: GenderEnum.woman,
                      groupValue: _userGender,
                      onChanged: (GenderEnum value) {
                        setState(() {
                          _userGender = value;
                        });
                      },
                    ),
                    new GestureDetector(
                      onTap: () {
                        setState(() {
                          _userGender = GenderEnum.woman;
                        });
                      },
                      child: Text('Woman'),
                    ),
                  ],
                ),
                Divider(),
                SizedBox(
                  width: 360,
                  child:
                  Row(
                    children: <Widget>[
                      Icon(Icons.cake,color: Colors.grey,),
                      Padding(
                        padding: const EdgeInsets.only(left:14.0),
                        child: Container(
                          width: 260,
                          child: RaisedButton(
                            onPressed: () {
                              _selectDate(context);
                            },
                            child: Text(_selectDateString),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}