import 'package:flutter/material.dart';
import 'package:trafit/screens/all_spot.dart';
import 'package:trafit/util/popular_spots.dart';
import 'package:trafit/widgets/grid_product.dart';
import 'package:trafit/widgets/home_category.dart';
import 'package:trafit/widgets/slider_item.dart';
import 'package:trafit/util/travel_spots.dart';
import 'package:trafit/util/categories.dart';
import 'package:carousel_slider/carousel_slider.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin<Home> {

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }

  int _current = 0;


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(

      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "여행지",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                FlatButton(
                  child: Text(
                    "View More",
                    style: TextStyle(
//                      fontSize: 22,
//                      fontWeight: FontWeight.w800,
                      color: Theme
                          .of(context)
                          .accentColor,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return DishesScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),

            SizedBox(height: 10.0),

            //Slider Here

            CarouselSlider(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2.6,
              items: map<Widget>(
                travel_spots,
                    (index, i) {
                  Map travel_spot = travel_spots[index];
                  return SliderItem(
                    img: travel_spot['img'],
                    isFav: false,
                    name: travel_spot['name'],
                    category: travel_spot['category'],
                    rating: 5.0,
                    raters: 23,
                  );
                },
              ).toList(),
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 10),
//                enlargeCenterPage: true,
              viewportFraction: 1.0,
//              aspectRatio: 2.0,
              onPageChanged: (index) {
                setState(() {
                  _current = index;
                });
              },
            ),


            Text(
              "패키지 여행",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 10.0),

            Container(
              height: 65.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: categories == null ? 0 : categories.length,
                itemBuilder: (BuildContext context, int index) {
                  Map cat = categories[index];
                  return HomeCategory(
                    icon: cat['icon'],
                    title: cat['name'],
                    items: cat['items'].toString(),
                    category_num : cat['category_num'],
                    img: cat['img'],
                    isHome: true,
                  );
                },
              ),
            ),

            SizedBox(height: 20.0),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "인기 여행지",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),

//                FlatButton(
//                  child: Text(
//                    "View More",
//                    style: TextStyle(
////                      fontSize: 22,
////                      fontWeight: FontWeight.w800,
//                      color: Theme
//                          .of(context)
//                          .accentColor,
//                    ),
//                  ),
//                  onPressed: () {},
//                ),
              ],
            ),
            SizedBox(height: 10.0),

            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery
                    .of(context)
                    .size
                    .width /
                    (MediaQuery
                        .of(context)
                        .size
                        .height / 1.4),
              ),
              itemCount: popular_spots == null ? 0 : popular_spots.length,
              itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
                Map travel_spot = travel_spots[index];
//                print(foods);
//                print(foods.length);
                return GridProduct(
                  img: travel_spot['img'],
                  isFav: false,
                  name: travel_spot['name'],
                  category: travel_spot['category'],
                  rating: 5.0,
                  raters: 23,
                );
              },
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
