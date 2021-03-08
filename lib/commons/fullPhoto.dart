import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class FullPhoto extends StatefulWidget {
  final String url;

  FullPhoto({Key key, @required this.url}) : super(key: key);
  @override
  State createState() => new _FullPhoto();
}

class _FullPhoto extends State<FullPhoto> {
  List<String> imageListStrings = ['https://cdn.pixabay.com/photo/2020/04/04/05/48/ornamental-cherry-5000946_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/11/16/10/27/girl-1828538_1280.jpg',
  'https://cdn.pixabay.com/photo/2016/01/19/17/48/woman-1149911_1280.jpg'];

  int currentIndex;

  @override
  void initState() {
    imageListStrings[0] = widget.url;
    currentIndex = 0;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      imageProvider: NetworkImage(imageListStrings[index]),
                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 1.5,
                    );
                  },
                  itemCount: imageListStrings.length,
                  loadingBuilder: (context, event) => Center(
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        value: event == null
                            ? 0
                            : event.cumulativeBytesLoaded / event.expectedTotalBytes,
                      ),
                    ),
                  ),
                  backgroundDecoration: BoxDecoration(
                    color: Colors.black,
                  ),
                  onPageChanged: onPageChanged,
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "${currentIndex + 1} / ${imageListStrings.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      decoration: null,
                    ),
                  ),
                )
              ],
            )
        ),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

}