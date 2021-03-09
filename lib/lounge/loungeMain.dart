import 'package:cached_network_image/cached_network_image.dart';
import 'package:datingappmain/commons/userProfile.dart';
import 'package:datingappmain/search/searchmain.dart';
import 'package:flutter/material.dart';

class LoungeMain extends StatefulWidget {
  @override State<StatefulWidget> createState() => _LoungeMain();
}

class _LoungeMain extends State<LoungeMain> with AutomaticKeepAliveClientMixin<LoungeMain>{

  @override
  bool get wantKeepAlive => true;

  List<UserData> _dummyData() {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0,8,8,0),
        child: GridView.count(crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            padding: const EdgeInsets.all(8),
            childAspectRatio: 0.632,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            children:_dummyData().map<Widget>( (data) {
              return new GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfile(data)),
                  );
                },
                child: _GridDemoPhotoItem(
                  userData: data,
                ),
              );
            }).toList()),
      ),
    );
  }
}

class _GridDemoPhotoItem extends StatelessWidget {
  _GridDemoPhotoItem({Key key, @required this.userData,}) : super(key: key);

  final UserData userData;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GridTile(
      child: Card(
        elevation: 6.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child:
              CachedNetworkImage(
                imageUrl: userData.userImages.first,
                placeholder: (context, url) => Container(
                  transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                  child: Container(
                      width: size.width,
                      height: 300,
                      child: Center(child: new CircularProgressIndicator())),
                ),
                errorWidget: (context, url, error) => new Icon(Icons.error),
                width: size.width,
                height: 300,
                fit: BoxFit.cover,
              ),
              // Image.network(photo.imageURL,
              //   height: 300,
              //   fit: BoxFit.cover,
              //   width: size.width,),
            ),
            Positioned(
              bottom: 8,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0,0,4.0,4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(userData.name,
                      style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 26,color: Colors.white,shadows: [ Shadow(blurRadius: 1.0,color: Colors.black,offset: Offset(0.6,0.6))]),),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0,top: 10.0),
                      child: Text(userData.information,
                          style: TextStyle(fontSize: 15,
                          color: Colors.white,
                          shadows: [ Shadow(blurRadius: 1.0,color: Colors.black,offset: Offset(0.6,0.6))]),),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),//image,
    );
  }
}