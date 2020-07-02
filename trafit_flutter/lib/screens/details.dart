import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafit/screens/ChatPage.dart';
import 'package:trafit/screens/notifications.dart';
import 'package:trafit/screens/post_screen.dart';
import 'package:trafit/util/MyIP.dart';
import 'package:trafit/util/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

ApiService apiService = new ApiService();

Future<List> call(String category) async {
  return apiService.show_room(category);
}
=======
import 'package:restaurant_ui_kit/screens/ChatPage.dart';
import 'package:restaurant_ui_kit/screens/main_screen.dart';
import 'package:restaurant_ui_kit/screens/notifications.dart';
import 'package:restaurant_ui_kit/screens/post_screen.dart';
import 'package:restaurant_ui_kit/util/ChatRoom.dart';
import 'package:restaurant_ui_kit/util/comments.dart';
import 'package:restaurant_ui_kit/util/const.dart';
import 'package:restaurant_ui_kit/util/travel_spots.dart';
import 'package:restaurant_ui_kit/widgets/badge.dart';
import 'package:restaurant_ui_kit/widgets/chat.dart';
import 'package:restaurant_ui_kit/widgets/smooth_star_rating.dart';
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23

class ProductDetails extends StatefulWidget {
  final String _name;
  final String _img;
  final String _category;

  ProductDetails(this._name, this._img, this._category);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFav = false;
  Future<List> rooms;

  @override
  void initState() {
    super.initState();
    rooms = call(widget._category);
  }

  @override
  Widget build(BuildContext context) {
    double phoneWidth = MediaQuery.of(context).size.width;;
    double ratio = MediaQuery.of(context).devicePixelRatio;;
    return FutureBuilder<List>(
        future: rooms,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return body(snapshot.data);
          } else {
            return Text('');
          }
        });
  }

  Widget body(List rooms) {
    double phoneWidth = MediaQuery.of(context).size.width;
    double ratio = MediaQuery.of(context).devicePixelRatio;
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
//                Positioned(
//                  right: -10.0,
//                  bottom: 3.0,
//                  child: RawMaterialButton(
//                    onPressed: () {},
//                    fillColor: Colors.white,
//                    shape: CircleBorder(),
//                    elevation: 4.0,
//                    child: Padding(
//                      padding: EdgeInsets.all(5),
//                      child: Icon(
//                        isFav ? Icons.favorite : Icons.favorite_border,
//                        color: Colors.red,
//                        size: 17,
//                      ),
//                    ),
//                  ),
//                ),
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
                    "(${rooms.length}개의 게시글)",
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
                itemCount: rooms == null ? 0 : rooms.length,
                itemBuilder: (BuildContext context, int index) {
<<<<<<< HEAD
                  if (rooms.length != 0) {
                    Map chatroom = rooms[index];
                    DateTime startTime = DateTime(
                        0,
                        int.parse(chatroom['start_date'].substring(0, 2)),
                        int.parse(chatroom['start_date'].substring(2, 4)));
                    String start =
                        DateFormat('M월d일').format(startTime).toString();
                    DateTime endTime = DateTime(
                        0,
                        int.parse(chatroom['end_date'].substring(0, 2)),
                        int.parse(chatroom['end_date'].substring(2, 4)));
                    String end = DateFormat('M월d일').format(endTime).toString();
                    ImageProvider c;
                    if (chatroom['img'] == 'x') {
                      if (chatroom['bossmbti'] != null)
                        c = Image.asset(
                                'assets/mbti/' + chatroom['bossmbti'] + '.png')
                            .image;
                      else
                        c = Image.asset('assets/person.png').image;
                    } else {
                      c = CachedNetworkImageProvider(
                          'http://$myIP:3001/${chatroom['img']}');
                    }
=======
                  if (widget._category == chatrooms[index]['category']) {
                    Map chatroom = chatrooms[index];
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 4.0,
                      child: ListTile(
<<<<<<< HEAD
                        leading: Column(
                          children: <Widget>[
                            CircleAvatar(radius: 25.0, backgroundImage: c),
                            Text(
                              chatroom['bossmbti'] != null ? chatroom['bossmbti'] : 'x',
                              style: TextStyle(fontSize: 5),
                            )
                          ],
                        ),
                        title: Text("${chatroom['bossname']}님의 게시글"),
=======
                        leading: CircleAvatar(
                          radius: 25.0,
                          backgroundImage: AssetImage(
                            "${chatroom['user_photo']}",
                          ),
                        ),
                        title: Text("${chatroom['user_name']}"),
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
                        subtitle: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
<<<<<<< HEAD
                                  chatroom['date'],
=======
                                  "February 14, 2020",
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
<<<<<<< HEAD
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Text('여행일:  ',
                                      style: TextStyle(color: Colors.black)),
                                  Text("$start 부터 $end 까지",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                            SizedBox(height: 3.0),
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Text('내용:  ',
                                      style: TextStyle(color: Colors.black)),
                                  Container(
                                    width: phoneWidth * ratio / 5.0,
                                    child: Text(chatroom['comment'],
                                        style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 70.0, 0),
                              child: Container(
                                width: 100,
                                child: FlatButton(
                                    child: Text(
                                      "채팅방 입장",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white,
                                      ),
                                    ),
                                    color: Colors.indigo[300],
                                    onPressed: () async {
                                      SharedPreferences sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      Map<String, dynamic> isDeny =
                                          await apiService.deny_check(
                                              chatroom['room_num'],
                                              sharedPreferences
                                                  .getString('id'));
                                      if (isDeny['message']) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('알림'),
                                                content: Text('강퇴된 채팅방입니다.'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: Text('닫기'),
                                                  )
                                                ],
                                              );
                                            });
                                      } else {
                                        String roomNumber = sharedPreferences
                                            .getString('room_num');
                                        if (roomNumber == null)
                                          roomNumber =
                                              "${chatroom['room_num']}";
                                        else
                                          roomNumber = roomNumber +
                                              ",${chatroom['room_num']}";
                                        sharedPreferences.setString(
                                            'room_num', roomNumber);

                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (BuildContext context) {
                                              return ChatPage(
                                                  chatroom['room_num'],
                                                  widget._category);
                                            },
                                          ),
                                        );
                                      }
                                    }),
                              ),
                            ),
=======
                            SizedBox(height: 7.0),
                            Text(
                              "${chatroom["comment"]}",
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
                                            return ChatPage();
                                          },
                                        ),
                                      );
                                    }),
                              ),
                            ),
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
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
          color: Colors.indigo[300],
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return Postscreen(
                      widget._img, widget._name, widget._category);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
