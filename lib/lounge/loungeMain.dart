import 'package:datingappmain/commons/userProfile.dart';
import 'package:flutter/material.dart';

class LoungeMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoungeMain();
}

class _LoungeMain extends State<LoungeMain> {
  List<_Dummy> _dummyData() {
    return [
      _Dummy(imageURL: 'https://cdn.pixabay.com/photo/2018/01/13/19/39/fashion-3080644_1280.jpg',
          title: 'Jessi',
          subtitle: '21 / 11km',
          explain: 'I haven’t dated much in recent years because I’ve been so focused on my career. Now I’m ready to meet the person who will pull my head out of the books and bring me a bit of happiness.'),
      _Dummy(imageURL: 'https://cdn.pixabay.com/photo/2017/06/24/02/56/art-2436545_1280.jpg',
          title: 'Lucy',
          subtitle: '23 / 4km',
          explain: 'If I could play one sport professionally, it would be soccer because I feel like it’s the least harmful. (Football is terrifying.) Which sport would you play? Which sport do you play?  '),
      _Dummy(imageURL: 'https://cdn.pixabay.com/photo/2017/09/01/21/53/blue-2705642_1280.jpg',
          title: 'Lia',
          subtitle: '22 / 42km',
          explain: 'My family. I know it sounds corny, but I’m not ashamed to say it. Family comes first. Blood is thicker than water and all that. We’ve been through a lot together and in those hard moments our strength together is what gets us through. No doubt about it.'),
      _Dummy(imageURL: 'https://images.pexels.com/photos/1319911/pexels-photo-1319911.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          title: 'Daisy',
          subtitle: '26 / 3km',
          explain: 'I legitimately like romantic comedies. I grew up with three sisters and too man females and aunts. I was outnumbered. Plus, they have great dialogue and plot structure. '),
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
                        builder: (context) => UserProfile(data.title,data.subtitle,data.explain,data.imageURL,false)),
                  );
                },
                child: _GridDemoPhotoItem(
                  photo: data,
                ),
              );
            }).toList()),
      ),
    );
  }
}

class _GridDemoPhotoItem extends StatelessWidget {
  _GridDemoPhotoItem({
    Key key,
    @required this.photo,
  }) : super(key: key);

  final _Dummy photo;

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
              child: Image.network(photo.imageURL,
                height: 300,
                fit: BoxFit.cover,
                width: size.width,),
            ),
            Positioned(
              bottom: 8,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0,0,4.0,4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(photo.title,
                      style: TextStyle(fontWeight: FontWeight.bold,
                        fontSize: 26,color: Colors.white,shadows: [ Shadow(blurRadius: 1.0,color: Colors.black,offset: Offset(0.6,0.6))]),),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0,top: 10.0),
                      child: Text(photo.subtitle,
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

class _Dummy {
  _Dummy({
    this.imageURL,
    this.title,
    this.subtitle,
    this.explain
  });

  final String imageURL;
  final String title;
  final String subtitle;
  final String explain;
}