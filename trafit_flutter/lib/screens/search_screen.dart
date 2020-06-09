import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafit/screens/ChatPage.dart';
import 'package:trafit/util/MyIP.dart';
import 'package:trafit/util/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trafit/util/travel_spots.dart';

ApiService apiService = new ApiService();
SharedPreferences sharedPreferences;
String userName;

Future<List> call() async {
  //tempDir = await getTemporaryDirectory();

  return apiService.search_room("123","123");
}

class chatSearchScreen extends StatefulWidget {
  final String _keyword;
  chatSearchScreen(this._keyword);
  @override
  _chatSearchScreenState createState() => _chatSearchScreenState();
}

class _chatSearchScreenState extends State<chatSearchScreen> {
  bool isFav = false;
  Future<List> rooms;
  Future<List> rooms2;
  final TextEditingController _searchControl = new TextEditingController();
  String searchMonth = '01';
  String searchDay = '01';
  String serchKeyword = "" ;
  List response;
  @override
  void initState() {
    super.initState();
    rooms = call();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
        future: rooms,
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            return body(snapshot.data);
          } else {
            return Text('Calculating answer...');
          }
        });
  }

  Widget body(List rooms) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 10.0),
            Card(
              elevation: 3.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(13.0, 0, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: TextField(
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(0.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintText: "Search...",
                            hintStyle: TextStyle(
                              fontSize: 15.0,
                              color: Colors.grey,
                            ),
                          ),
                          maxLines: 1,
                          controller: _searchControl, //이메일 컨트롤러
                          onChanged: (text) {
                            serchKeyword = _searchControl.text;
                          },
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 40,
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(40.0, 0.0, 0.0, 20.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.search,
                              size: 24.0,
                            ),
//              icon: IconBadge(
//                icon: Icons.notifications,
//                size: 22.0,
//              ),
                            onPressed: () {
                              setState(() {
                                serchKeyword = _searchControl.text;
                              });


                            },
                            tooltip: "Notifications",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              elevation: 6.0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                  child: Row(
                    children: [
                      Text("원하는 날짜"),
                      SizedBox(width: 20),
                      DropdownButton<String>(
                        value: searchMonth,
                        autofocus: false,
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.grey),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            searchMonth = newValue;
                          });
                        },
                        items: <String>[
                          '01',
                          '02',
                          '03',
                          '04',
                          '05',
                          '06',
                          '07',
                          '08',
                          '09',
                          '10',
                          '11',
                          '12'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      SizedBox(width: 20),
                      DropdownButton<String>(
                        value: searchDay,
                        autofocus: false,
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.grey),
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            searchDay = newValue;
                          });
                        },
                        items: <String>[
                          '01',
                          '02',
                          '03',
                          '04',
                          '05',
                          '06',
                          '07',
                          '08',
                          '09',
                          '10',
                          '11',
                          '12',
                          '13',
                          '14',
                          '15',
                          '16',
                          '17',
                          '18',
                          '19',
                          '20',
                          '21',
                          '22',
                          '23',
                          '24',
                          '25',
                          '26',
                          '27',
                          '28',
                          '29',
                          '30',
                          '31'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 5.0),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "검색결과",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              itemCount: rooms == null ? 0 : rooms.length,
              itemBuilder: (BuildContext context, int index) {
                Map chatroom = rooms[index];
                if(chatroom['start_date'] == null) chatroom['start_date'] = '0101';
                if(chatroom['end_date'] == null) chatroom['end_date'] = '0101';
                if (rooms.length != 0 && chatroom['comment'].toString().contains(serchKeyword) && int.parse(chatroom['start_date'].toString()) <= int.parse(searchMonth+searchDay) && int.parse(chatroom['end_date'].toString()) >= int.parse(searchMonth+searchDay) ) {
                  ImageProvider c;
                  String spot = travel_spots[int.parse(chatroom['category'])-1]['name'];
                  if (chatroom['img'] == 'x') {
                    c = Image.asset(
                            'assets/mbti/' + chatroom['bossmbti'] + '.png')
                        .image;
                  } else {
                    c = CachedNetworkImageProvider(
                        'http://$myIP:3001/${chatroom['img']}');
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
                          Row(
                            children: [
                              Text('여행지:  '),
                              Text("$spot"),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Text('여행일:  '),
                              Text("${chatroom['start_date']} ~ ${chatroom['end_date']}"),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0.0, 0.0, 70.0, 0.0),
                            child: Text("${chatroom['comment']}"),
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
                  return SizedBox(height: 0);
              },
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
