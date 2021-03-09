import 'package:cached_network_image/cached_network_image.dart';
import 'package:datingappmain/commons/constData.dart';
import 'package:datingappmain/commons/fullPhoto.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:scrolling_page_indicator/scrolling_page_indicator.dart';

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

class _SearchMain extends State<SearchMain> with WidgetsBindingObserver, AutomaticKeepAliveClientMixin<SearchMain>{

  @override
  bool get wantKeepAlive => true;

  bool _isLike;
  int _currentIndex = 0;
  double _xPosition = 0.0;
  PageController _pageController;

  List<UserData> _dummyUserDataList = [
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
      'https://www.wallpapertip.com/wmimgs/155-1553432_beautiful-chinese-girl.jpg',
      'https://www.itl.cat/pngfile/big/77-770860_download-wallpaper-chinese-girl-free.jpg',
    ],['Movie','Sleep','Travel','Party']),
  ];

  List<BottomButtonData> _bottomIconDataList = [
    BottomButtonData(FontAwesomeIcons.redoAlt,Colors.yellow[800]),
    BottomButtonData(FontAwesomeIcons.times,Colors.redAccent),
    BottomButtonData(FontAwesomeIcons.solidStar,Colors.blue[400]),
    BottomButtonData(FontAwesomeIcons.solidHeart,Colors.green[400]),
    BottomButtonData(FontAwesomeIcons.bolt,Colors.purple[400]),
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
                return _dummyUserDataList.length == index ? Text('No user') :
                Stack(
                  children: <Widget>[
                    PageView(
                      controller: _pageController = PageController(),
                      children: _userProfile(size, index),
                      scrollDirection: Axis.vertical,
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
          padding: const EdgeInsets.fromLTRB(12.0,8,12,8),
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

  List<Widget> _userProfile(Size size, int index,){
    List<Widget> _returnWidgetList = [];
    // String userImage in _dummyUserDataList[index].userImages
    for(int i=0 ; i < _dummyUserDataList[index].userImages.length ; i++){
      Widget _userWidget = Stack(
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
                  imageUrl: _dummyUserDataList[index].userImages[i],
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
                  context, MaterialPageRoute(builder: (context) => FullPhoto(imageUrlList: _dummyUserDataList[index].userImages,initIndex: i,)));
            },
          ),
          Positioned(
              bottom: 4,
              left: 4,
              child: _userInformation(_dummyUserDataList[index])
          ),
          Positioned(
            right: 12,
            top:30,
            child: ScrollingPageIndicator(
                dotColor: Colors.white,
                dotSelectedColor: Colors.deepPurple,
                dotSize: 6,
                dotSelectedSize: 10,
                dotSpacing: 16,
                controller: _pageController,
                itemCount: _dummyUserDataList[index].userImages.length,
                orientation: Axis.vertical
            ),
          ),
        ],
      );
      _returnWidgetList.add(_userWidget);
    }
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
          onPressed: () {
            if(data.iconData == FontAwesomeIcons.times){
              _cardController.triggerLeft();
            }else if(data.iconData == FontAwesomeIcons.solidHeart){
              _cardController.triggerRight();
            }else if(data.iconData == FontAwesomeIcons.solidStar){
              _cardController.triggerUp();
            }
          },
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
}