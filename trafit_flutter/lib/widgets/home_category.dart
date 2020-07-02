import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafit/screens/details.dart';
import 'package:trafit/screens/categories_screen.dart';
import 'package:trafit/util/api_service.dart';


class HomeCategory extends StatefulWidget {
  final IconData icon;
  final String title;
  final String items;
  final Function tap;
  final bool isHome;
  final String category_num;
  final String img;

  HomeCategory({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.items,
    @required this.category_num,
    @required this.img,
    this.tap, this.isHome})
      : super(key: key);

  @override
  _HomeCategoryState createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 0.0, right: 10.0),
                child: Icon(
                  widget.icon,
                  color: Theme.of(context).accentColor,
                ),
              ),
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Text(
                    "${widget.title}",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 17,
                    ),
                  ),

                  SizedBox(height: 5),
                ],
              ),
              SizedBox(width: 5),
            ],
          ),
        ),
      ),
      onTap: () async{
        ApiService apiService = new ApiService();
        List<dynamic> rooms = await apiService.show_room(widget.category_num);
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              //print('$name');
              print(widget.img);
              //print(category+'dd');

              return ProductDetails(widget.title, widget.img,widget.category_num);
            },
          ),
        );
      },
    );
  }
}
