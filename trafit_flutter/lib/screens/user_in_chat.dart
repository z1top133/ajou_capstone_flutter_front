import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafit/screens/ChatPage.dart';
import 'package:trafit/util/MyIP.dart';
import 'package:trafit/util/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trafit/util/travel_spots.dart';

ApiService apiService = new ApiService();
SharedPreferences sharedPreferences;
String userName ;
Future<List> call() async{
  sharedPreferences = await SharedPreferences.getInstance();
  String _roomNumber = sharedPreferences.getString('room_num');
  userName = sharedPreferences.getString('username');
  print(_roomNumber);
  return apiService.user_in_room(_roomNumber);
}

class userInChatScreen extends StatefulWidget {
  @override
  _userInChatScreenState createState() => _userInChatScreenState();
}

class _userInChatScreenState extends State<userInChatScreen> {
  bool isFav = false;
  Future<List> rooms;

  @override
  void initState(){
    super.initState();
    rooms = call();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List>(
        future: rooms,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot){
          if(snapshot.hasData){
            return body(snapshot.data);
          }
          else{
            return Text('Calculating answer...');
          }
        }
    );
  }


  Widget body(List rooms){
    return Scaffold(
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
                      "assets/paris.jpg",
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
              userName + '님의 참여 채팅방',
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
                  if (rooms.length != 0) {
                    Map chatroom = rooms[index];
                    String spot = travel_spots[int.parse(chatroom['category'])-1]['name'];
                    ImageProvider c;
                    if(chatroom['img'] == 'x'){
                      c = Image.asset('assets/mbti/' + chatroom['bossmbti']+ '.png').image;
                    }
                    else{
                      c = CachedNetworkImageProvider('http://$myIP:3001/${chatroom['img']}');
                    }
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      elevation: 4.0,
                      child: ListTile(
                        leading: CircleAvatar(radius: 25.0, backgroundImage: c),
                        title: Text("${chatroom['bossname']}"),
                        subtitle: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  chatroom['date'],
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              elevation: 2.5,
                              margin: EdgeInsets.all(3),
                              child: Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    Text('여행지:  '),
                                    Text("$spot"),
                                  ],
                                ),
                              ),
                            ),
                            Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                elevation: 2.5,
                                margin: EdgeInsets.all(3),
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Row(
                                    children: [
                                      Text('여행일:  '),
                                      Text("${chatroom['start_date']} ~ ${chatroom['end_date']}"),
                                    ],
                                  ),
                                )
                            ),
//                          Card(
//                            child: Row(
//                              children: [
//                                Text('여행일:  '),
//                                Text("${chatroom['start_date']} ~ ${chatroom['end_date']}"),
//                              ],
//                            ),
//                          ),
                            Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                elevation: 2.5,
                                margin: EdgeInsets.all(3),
                                child: Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Row(
                                    children: [
                                      Text('내용:  '),
                                      Text(chatroom['comment']),
                                    ],
                                  ),
                                )
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
                                    color: Colors.indigo[300],
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (BuildContext context) {
                                            return ChatPage(chatroom['room_num'], chatroom['category']);
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
    );
  }
}
