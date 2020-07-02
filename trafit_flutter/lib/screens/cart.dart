import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:trafit/screens/checkout.dart';
import 'package:trafit/util/travel_spots.dart';
import 'package:trafit/widgets/cart_item.dart';
=======
import 'package:restaurant_ui_kit/screens/checkout.dart';
import 'package:restaurant_ui_kit/util/travel_spots.dart';
import 'package:restaurant_ui_kit/widgets/cart_item.dart';
import 'pacakage:trafit';

>>>>>>> Stashed changes

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with AutomaticKeepAliveClientMixin<CartScreen >{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),
        child: ListView.builder(
          itemCount: travel_spots == null ? 0 :travel_spots.length,
          itemBuilder: (BuildContext context, int index) {
//                Food food = Food.fromJson(foods[index]);
            Map food = travel_spots[index];
//                print(foods);
//                print(foods.length);
            return CartItem(
              img: food['img'],
              isFav: false,
              name: food['name'],
              rating: 5.0,
              raters: 23,
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        tooltip: "Checkout",
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context){
                return Checkout();
              },
            ),
          );
        },
        child: Icon(
          Icons.arrow_forward,
        ),
        heroTag: Object(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
