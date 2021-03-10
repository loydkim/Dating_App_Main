import 'package:cached_network_image/cached_network_image.dart';
import 'package:datingappmain/commons/constData.dart';
import 'package:datingappmain/commons/userProfile.dart';
import 'package:datingappmain/search/searchmain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart' as frs;

class SettingMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingMain();
}

class _SettingMain extends State<SettingMain>  with AutomaticKeepAliveClientMixin<SettingMain>{

  @override
  bool get wantKeepAlive => true;

  double _animatedHeight = 0;
  bool _manValue = false;
  bool _womanValue = true;

  double _lowerValue = 18.0;
  double _upperValue = 30.0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0,10,0,0),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child:
                CachedNetworkImage(
                  imageUrl: myProfileImage,
                  placeholder: (context, url) => Container(
                    transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                    child: Container(
                      width: 60,
                      height: 80,
                      child: Center(child: new CircularProgressIndicator())),
                  ),
                  errorWidget: (context, url, error) => new Icon(Icons.error),
                  width: 60,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text('James',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(
                  builder: (context) => UserProfile(
                    UserData(
                        myProfileName,
                        '22',
                        'I legitimately like romantic comedies.',
                        [myProfileImage],
                        ['Sports','Movie','Netflix']
                      ),
                      ParentClassType.EditProfile
                    )
                  ),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,10,0,0),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Icon(Icons.build, size: 34,color: Colors.blue[900],),
              ),
              title: Text('Search Setting',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              onTap: () {
                setState(() {
                  _animatedHeight!=0.0?_animatedHeight=0.0:_animatedHeight=140.0;
                });
              },
            ),
          ),
          new AnimatedContainer(duration: const Duration(milliseconds: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(28.0,10,10,10),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.wc,size: 26,),
                      Text("Gender",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      Checkbox(
                      value: _manValue,
                      onChanged: (bool newValue) {
                          setState(() {
                            _manValue = newValue;
                          });
                        },
                      ),
                      GestureDetector(
                          child: Text("Man",style: TextStyle(fontSize: 18)),
                          onTap: () {
                            setState(() {
                              _manValue = !_manValue;
                            });
                          },),
                      Padding(
                        padding: const EdgeInsets.only(left:12.0),
                        child: Checkbox(
                          value: _womanValue,
                          onChanged: (bool newValue) {
                            setState(() {
                              _womanValue = newValue;
                            });
                          },
                        ),
                      ),
                      GestureDetector(child: Text("Woman",style: TextStyle(fontSize: 18)),
                        onTap: () {
                          setState(() {
                            _womanValue = !_womanValue;
                          });
                        },),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(28.0,10,10,10),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exposure,size: 26),
                      Padding(
                        padding: const EdgeInsets.only(left:4.0,right:16),
                        child: Text("Age",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                      ),
                      Text("${_lowerValue.toInt()} ",style: TextStyle(fontSize: 16)),
                      Expanded(
                        child: frs.RangeSlider(
                          min: 18.0,
                          max: 60.0,
                          lowerValue: _lowerValue,
                          upperValue: _upperValue,
                          divisions: 42,
                          showValueIndicator: true,
                          valueIndicatorMaxDecimals: 1,
                          onChanged: (double newLowerValue, double newUpperValue) {
                            setState(() {
                              _lowerValue = newLowerValue;
                              _upperValue = newUpperValue;
                            });
                          },
                          onChangeEnd: (double newLowerValue, double newUpperValue) {
                            print('Ended with values: $newLowerValue and $newUpperValue');
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: Text(" ${_upperValue.toInt()}",style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            height: _animatedHeight,
            width: 100.0,
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.fromLTRB(0,10,0,0),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Icon(Icons.lock_open, size: 40,color: Colors.red[900]),
              ),
              title: Text('Log Out',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
              onTap: () {
                _showDialog();
              },
            ),
          ),
        ],
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
          title: new Text("Do you want to log out?"),
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