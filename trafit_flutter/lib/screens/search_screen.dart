import 'package:calendar_strip/calendar_strip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafit/screens/ChatPage.dart';
import 'package:trafit/util/MyIP.dart';
import 'package:trafit/util/api_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:trafit/util/travel_spots.dart';

ApiService apiService = new ApiService();
SharedPreferences sharedPreferences;
String userName;
String searchKeyword = "";
String searchMonth;
String searchDay;
Future<List> call() async {
  //tempDir = await getTemporaryDirectory();

  return apiService.search_room("123", "123");
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


  List response;
  bool _isComposing = false;

  DateTime _currentDate = DateTime.now().subtract(Duration(days: 2));
  DateTime _currentDate2 = DateTime.now().subtract(Duration(days: 2));
  String _currentMonth = DateFormat.yM().format(DateTime.now());
  DateTime _targetDateTime = DateTime(2020, 6, 3);

//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

  @override
  void initState() {
    DateTime now = DateTime.now();
    if(now.month<10)searchMonth =DateFormat('0M').format(now).toString();
    else searchMonth =DateFormat('M').format(now).toString();

    if(now.day<10)searchDay =DateFormat('0d').format(now).toString();
    else searchDay =DateFormat('d').format(now).toString();

    print(searchMonth + searchDay);
    super.initState();
    rooms = call();
  }

  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      todayBorderColor: Colors.indigo[300],
      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() {
          _currentDate2 = date;
          if (date.month < 10) {
            searchMonth = '0' + date.month.toString();
          } else
            searchMonth = date.month.toString();
          if (date.day < 10) {
            searchDay = '0' + date.day.toString();
          } else
            searchDay = date.day.toString();
          print("asvas" + searchMonth + searchDay);
//          searchMonth = date.month.toString();
//          searchDay = date.day.toString();
//          print(int.parse(searchMonth + searchDay));
        });
        events.forEach((event) => print(event.title));
      },
      showOnlyCurrentMonthDate: false,
      staticSixWeekFormat: true,
      weekendTextStyle: TextStyle(
        color: Colors.red,
      ),
      thisMonthDayBorderColor: Colors.indigo[300],
      weekFormat: true,
//      firstDayOfWeek: 4,
      markedDatesMap: _markedDateMap,
      height: 80.0,
      selectedDayBorderColor: Colors.indigo[300],
      selectedDayButtonColor: Colors.indigo[300],
      selectedDateTime: _currentDate2,
      targetDateTime: _targetDateTime,
      customGridViewPhysics: NeverScrollableScrollPhysics(),
      markedDateCustomShapeBorder:
          CircleBorder(side: BorderSide(color: Colors.indigo[300])),
      markedDateCustomTextStyle: TextStyle(
        fontSize: 18,
        color: Colors.indigo[300],
      ),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.white,
      ),
      // markedDateShowIcon: true,
      // markedDateIconMaxShown: 2,
      // markedDateIconBuilder: (event) {
      //   return event.icon;
      // },
      // markedDateMoreShowTotal:
      //     true,
      todayButtonColor: Colors.red,
      selectedDayTextStyle: TextStyle(
        color: Colors.black,
      ),
      minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      maxSelectedDate: _currentDate.add(Duration(days: 360)),
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.red,
        fontSize: 16,
      ),
      onCalendarChanged: (DateTime date) {
        this.setState(() {
          _targetDateTime = date;
          _currentMonth = DateFormat.yM().format(_targetDateTime);
        });
      },
      onDayLongPressed: (DateTime date) {
        print('${date.month}');
//        print('long pressed date $date');
      },
    );

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
                          controller: _searchControl,
                          onSubmitted: (text) {
                            setState(() {
                              searchKeyword = _searchControl.text;
                            });
                          },
                          //이메일 컨트롤러
                          onChanged: (text) {
                            searchKeyword = _searchControl.text;
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
                                searchKeyword = _searchControl.text;
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
//            Card(
//              elevation: 6.0,
//              child: Container(
//                decoration: BoxDecoration(
//                  color: Colors.white,
//                  borderRadius: BorderRadius.all(
//                    Radius.circular(5.0),
//                  ),
//                ),
//                child: Padding(
//                  padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
//                  child: Row(
//                    children: [
//                      Text("원하는 날짜"),
//                      SizedBox(width: 20),
//                      DropdownButton<String>(
//                        value: searchMonth,
//                        autofocus: false,
//                        iconSize: 24,
//                        elevation: 16,
//                        style: TextStyle(color: Colors.grey),
//                        underline: Container(
//                          height: 2,
//                          color: Colors.grey,
//                        ),
//                        onChanged: (String newValue) {
//                          setState(() {
//                            searchMonth = newValue;
//                          });
//                        },
//                        items: <String>[
//                          '01',
//                          '02',
//                          '03',
//                          '04',
//                          '05',
//                          '06',
//                          '07',
//                          '08',
//                          '09',
//                          '10',
//                          '11',
//                          '12'
//                        ].map<DropdownMenuItem<String>>((String value) {
//                          return DropdownMenuItem<String>(
//                            value: value,
//                            child: Text(value),
//                          );
//                        }).toList(),
//                      ),
//                      SizedBox(width: 20),
//                      DropdownButton<String>(
//                        value: searchDay,
//                        autofocus: false,
//                        iconSize: 24,
//                        elevation: 16,
//                        style: TextStyle(color: Colors.grey),
//                        underline: Container(
//                          height: 2,
//                          color: Colors.grey,
//                        ),
//                        onChanged: (String newValue) {
//                          setState(() {
//                            searchDay = newValue;
//                          });
//                        },
//                        items: <String>[
//                          '01',
//                          '02',
//                          '03',
//                          '04',
//                          '05',
//                          '06',
//                          '07',
//                          '08',
//                          '09',
//                          '10',
//                          '11',
//                          '12',
//                          '13',
//                          '14',
//                          '15',
//                          '16',
//                          '17',
//                          '18',
//                          '19',
//                          '20',
//                          '21',
//                          '22',
//                          '23',
//                          '24',
//                          '25',
//                          '26',
//                          '27',
//                          '28',
//                          '29',
//                          '30',
//                          '31'
//                        ].map<DropdownMenuItem<String>>((String value) {
//                          return DropdownMenuItem<String>(
//                            value: value,
//                            child: Text(value),
//                          );
//                        }).toList(),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                      top: 10.0,
                      bottom: 10.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: new Row(
                      children: <Widget>[
                        Expanded(
                            child: Row(
                          children: [
                            Text(
                              _currentMonth,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 21.0,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "날짜를 선택하세요",
                              style: TextStyle(color: Colors.grey),
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
                    child: _calendarCarouselNoHeader,
                  ), //
                ],
              ),
            ),
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
                if (chatroom['start_date'] == null)
                  chatroom['start_date'] = '0101';
                if (chatroom['end_date'] == null){
                  chatroom['end_date'] = '1231';
                }
                if (rooms.length != 0 &&
                    chatroom['comment'].toString().contains(searchKeyword) &&
                    int.parse(chatroom['start_date'].toString()) <=
                        int.parse(searchMonth + searchDay) &&
                    int.parse(chatroom['end_date'].toString()) >=
                        int.parse(searchMonth + searchDay)) {
                  DateTime startTime = DateTime(0, int.parse(chatroom['start_date'].substring(0,2)), int.parse(chatroom['start_date'].substring(2,4)));
                  String start = DateFormat('M월d일').format(startTime).toString();
                  DateTime endTime = DateTime(0, int.parse(chatroom['end_date'].substring(0,2)), int.parse(chatroom['end_date'].substring(2,4)));
                  String end = DateFormat('M월d일').format(endTime).toString();
                  print("asvas" + searchMonth + searchDay);
                  ImageProvider c;
                  String spot =
                      travel_spots[int.parse(chatroom['category']) - 1]['name'];
                  if (chatroom['img'] == 'x') {
                    if (chatroom['bossmbti'] != null)
                      c = Image.asset(
                              'assets/mbti/' + chatroom['bossmbti'] + '.png')
                          .image;
                    else
                      c = Image.asset('person.png').image;
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
                         Padding(
                              padding: const EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Text('여행지:  ',style: TextStyle(color: Colors.black)),
                                  Text("$spot",style: TextStyle(color: Colors.black)),
                                ],
                              ),

                          ),
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Row(
                              children: [
                                Text('여행일:  ',style: TextStyle(color: Colors.black)),
                                Text("$start 부터 $end 까지",style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
//                          Card(
//                            child: Row(
//                              children: [
//                                Text('여행일:  '),
//                                Text("${chatroom['start_date']} ~ ${chatroom['end_date']}"),
//                              ],
//                            ),
//                          ),
                         Padding(
                              padding: EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Text('내용:  ',
                                  style: TextStyle(color: Colors.black)),
                                  Container(
                                    width: MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio / 5.0,
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
                                                chatroom['category']);
                                          },
                                        ),
                                      );
                                    }
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
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

void _handleSubmitted(String text) {
  searchKeyword = text;
}
