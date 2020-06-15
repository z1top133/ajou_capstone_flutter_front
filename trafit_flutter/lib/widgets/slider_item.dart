import 'package:flutter/material.dart';
import 'package:trafit/screens/details.dart';

class SliderItem extends StatelessWidget {
  final String name;
  final String img;
  final bool isFav;
  final double rating;
  final int raters;
  final String category;

  SliderItem(
      {Key key,
      @required this.name,
      @required this.img,
      @required this.isFav,
      @required this.rating,
      @required this.raters,
      @required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListView(
        shrinkWrap: true,
        primary: false,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height / 3.2,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset(
                    "$img",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
//              Positioned(
//                right: -10.0,
//                bottom: 3.0,
//                child: RawMaterialButton(
//                  onPressed: () {},
//
//                  shape: CircleBorder(),
//                  elevation: 10.0,
//                  child: Padding(
//                    padding: EdgeInsets.all(5),
//
//                  ),
//                ),
//              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.0, top: 8.0),
            child: Text(
              "$name",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
              ),
              maxLines: 2,
            ),
          ),
//          Padding(
//            padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
//            child: Row(
//              children: <Widget>[
////                SmoothStarRating(
////                  starCount: 5,
////                  color: Constants.ratingBG,
////                  allowHalfRating: true,
////                  rating: rating,
////                  size: 10.0,
////                ),
//
//              ],
//            ),
//          ),
        ],
      ),
      onTap: () async{
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ProductDetails('$name', '$img','$category');
            },
          ),
        );
      },
    );
  }
}
