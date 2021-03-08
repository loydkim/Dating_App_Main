import 'package:datingappmain/commons/constData.dart';
import 'package:datingappmain/commons/fullPhoto.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';

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

class SearchMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchMain();
}

class _SearchMain extends State<SearchMain> with WidgetsBindingObserver{

  bool _isLike;
  int _currentIndex = 0;
  double _xPosition = 0.0;

  List<UserData> _dummyUserDataList = [
    UserData('Julia','21 / 5km','Nice to meet you',[
      'https://images.pexels.com/photos/1382731/pexels-photo-1382731.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    ],['Shop','Party','Sleep','Travel']),
    UserData('Lucy','23 / 8km','I wanna meet someone',[
      'https://images.pexels.com/photos/1308881/pexels-photo-1308881.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    ],['Game','Movie','Netflix','Talk']),
    UserData('Amanda','26 / 12km','Hellllooo',[
      'https://images.pexels.com/photos/1391498/pexels-photo-1391498.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    ],['Sports','Watch','Walk','Sleep']),
  ];

  List<BottomButtonData> _bottomIconDataList = [
    BottomButtonData(FontAwesomeIcons.solidFlag,Colors.yellow[800]),
    BottomButtonData(FontAwesomeIcons.times,Colors.redAccent),
    BottomButtonData(FontAwesomeIcons.hotjar,Colors.indigo),
    BottomButtonData(FontAwesomeIcons.solidHeart,Colors.green[800]),
    BottomButtonData(FontAwesomeIcons.vial,Colors.brown[600]),
  ];


  CardController _cardController = CardController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height*0.88,
            width: MediaQuery.of(context).size.width*1.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.transparent,
            ),
            child: TinderSwapCard(
              orientation: AmassOrientation.BOTTOM,
              totalNum: _dummyUserDataList.length,
              stackNum: 3,
              swipeEdge: 4.0,
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height * 0.85,
              minWidth: MediaQuery.of(context).size.width * 0.84,
              minHeight: MediaQuery.of(context).size.height * 0.7,
              cardController: _cardController,
              cardBuilder: (context,index){
                return Stack(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        height: size.height,
                        width: size.width-14,
                        color: Colors.white,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: Image.network(_dummyUserDataList[index].userImages.first, fit: BoxFit.cover,),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => FullPhoto(url: user1Image)));
                      },
                    ),
                    Positioned(
                      bottom: 4,
                      left: 4,
                      child: _userInformation(_dummyUserDataList[index])
                    ),
                    Positioned(
                      top:54,
                      right:36,
                      child: _isLike != null && !_isLike && index == _currentIndex?
                      AnimatedOpacity(
                        opacity: _xPosition,
                        duration: Duration(milliseconds: 500),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                left: 1.0,
                                top: 2.0,
                                child: FaIcon(
                                  FontAwesomeIcons.ban,
                                  color: Colors.black54,
                                  size: 76,
                                )
                            ),
                            FaIcon(
                              FontAwesomeIcons.ban,
                              color: Colors.redAccent,
                              size: 76,
                            )
                          ],
                        ),


                      ) : Container(),
                    ),
                    Positioned(
                      top:50,
                      left:40,
                      child: _isLike != null && _isLike && index == _currentIndex?
                      AnimatedOpacity(
                        opacity: _xPosition,
                        duration: Duration(milliseconds: 500),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                                left: 1.0,
                                top: 2.0,
                                child: FaIcon(
                                  FontAwesomeIcons.kissWinkHeart,
                                  color: Colors.black54,
                                  size: 76,
                                )
                            ),
                            FaIcon(
                              FontAwesomeIcons.kissWinkHeart,
                              color: Colors.green[800],
                              size: 76,
                            )
                          ],
                        ),
                      ) : Container(),
                    )
                  ],
                );
              },

              swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
                if (align.x < 0) {
                  //Card is LEFT swiping
                  if(align.x < -3){
                    _isLike = false;
                  }
                  if(-(align.x * 0.1) > 1){
                    _xPosition = 1;
                  }else{
                    _xPosition = -(align.x * 0.1);
                  }
                } else if (align.x > 0) {
                  //Card is RIGHT swiping
                  if(align.x > 3){
                    _isLike = true;
                  }
                  if((align.x * 0.1) > 1){
                    _xPosition = 1;
                  }else{
                    _xPosition = (align.x * 0.1);
                  }
                }else{
                  _xPosition = 0;
                }
              },
              swipeCompleteCallback: (CardSwipeOrientation orientation, int index) {
                print('orientation is $orientation and index is $index');
                if(orientation == CardSwipeOrientation.LEFT || orientation == CardSwipeOrientation.RIGHT){
                  _currentIndex = index+1;
                }
                _isLike = null;
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _bottomIconDataList.map(_bottomButtonWidget).toList(),
          ),
        )
      ],
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
            size: 30.0,
          ),
          shape: new CircleBorder(),
          elevation: 2.0,
          fillColor: Colors.white,
          padding: const EdgeInsets.all(16.0),
        ),
      ),
    );
  }
}