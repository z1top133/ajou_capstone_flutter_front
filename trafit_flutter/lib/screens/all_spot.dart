import 'package:flutter/material.dart';
import 'package:trafit/screens/notifications.dart';
import 'package:trafit/util/travel_spots.dart';
import 'package:trafit/widgets/badge.dart';
import 'package:trafit/widgets/grid_product.dart';


class DishesScreen extends StatefulWidget {
  @override
  _DishesScreenState createState() => _DishesScreenState();
}

class _DishesScreenState extends State<DishesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: ()=>Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "모든 여행지",
        ),
        elevation: 0.0,
        actions: <Widget>[
        ],
      ),

      body: Padding(
          padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView(

          children: <Widget>[

            Divider(),

            GridView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.4),
              ),
              itemCount: travel_spots == null ? 0 : travel_spots.length,
              itemBuilder: (BuildContext context, int index) {
                Map food = travel_spots[index];
                return GridProduct(
                  img: food['img'],
                  isFav: false,
                  name: food['name'],
                  category: food['category'],
                  rating: 5.0,
                  raters: 23,
                );
              },
            ),

          ],
        ),
      ),
    );
  }
}
