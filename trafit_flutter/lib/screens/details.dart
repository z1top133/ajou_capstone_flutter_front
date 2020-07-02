import 'package:flutter/material.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:restaurant_ui_kit/screens/ChatPage.dart';
import 'package:restaurant_ui_kit/screens/main_screen.dart';
import 'package:restaurant_ui_kit/screens/notifications.dart';
import 'package:restaurant_ui_kit/screens/post_screen.dart';
import 'package:restaurant_ui_kit/util/ChatRoom.dart';
import 'package:restaurant_ui_kit/util/api_service.dart';
import 'package:restaurant_ui_kit/util/comments.dart';
import 'package:restaurant_ui_kit/util/const.dart';
import 'package:restaurant_ui_kit/util/travel_spots.dart';
import 'package:restaurant_ui_kit/widgets/badge.dart';
import 'package:restaurant_ui_kit/widgets/chat.dart';
import 'package:restaurant_ui_kit/widgets/smooth_star_rating.dart';

class ProductDetails extends StatefulWidget {
  final String _name;
  final String _img;
  final String _category;
  final List<dynamic> rooms;

  ProductDetails(this._name, this._img, this._category, this.rooms);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>{
  SocketIO socketIO;
  bool isFav = false;
  ApiService apiService = new ApiService();
  List<dynamic> room;

  @override
  void initState(){
    socketIO = SocketIOManager().createSocketIO(
      'http://49.50.174.200:3001',
      '/',
    );
    socketIO.init();
    print('init');
    socketIO.connect();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print(widget._name);
    //print(widget._img);
    //print(widget.rooms[0]['comment']);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(
            Icons.keyboard_backspace,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "동행 게시판",
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              size: 24.0,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return Notifications();
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 3.2,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      widget._img,
//                      "${foods[0]['img']}",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: -10.0,
                  bottom: 3.0,
                  child: RawMaterialButton(
                    onPressed: () {},
                    fillColor: Colors.white,
                    shape: CircleBorder(),
                    elevation: 4.0,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              widget._name + ' 동행 게시판',
//              "${foods[0]['name']}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 5.0, top: 2.0),
              child: Row(
                children: <Widget>[
//                  SmoothStarRating(
//                    starCount: 5,
//                    color: Constants.ratingBG,
//                    allowHalfRating: true,
//                    rating: 5.0,
//                    size: 10.0,
//                  ),
//                  SizedBox(width: 10.0),
                  Text(
                    "(23개의 게시글)",
                    style: TextStyle(
                      fontSize: 11.0,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              "게시글",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
              maxLines: 2,
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
              child: ListView.builder(
                

                shrinkWrap: true,
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                itemCount: chatrooms == null ? 0 : widget.rooms.length,
                itemBuilder: (BuildContext context, int index) {     
                  //print(widget._category);
                  //print(widget.rooms[index]['category']);           
                  if (widget.rooms.length != 0) {
                    Map chatroom = widget.rooms[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 4.0,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: AssetImage(
                            chatroom['user_photo'],
                          ),
                        ),
                        title: Text("${chatroom['user_name']}"),
                        subtitle: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  "February 14, 2020",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 7.0),
                            Text(
                              "${chatroom['comment']}"
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 70.0, 0),
                              child: Container(
                                child: FlatButton(
                                    child: Text(
                                      "채팅방 입장",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: Theme.of(context).accentColor,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return ChatPage(chatroom['room_num']);
                                          },
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else
                    return SizedBox(height: 0.0);
                },
              ),
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50.0,
        child: RaisedButton(
          child: Text(
            "게시글 작성하기",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          color: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.pop(context);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Postscreen(
                      widget._img, widget._name, widget._category, widget.rooms);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
