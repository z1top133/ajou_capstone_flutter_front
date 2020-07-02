import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:trafit/screens/ChatPage.dart';
import 'package:trafit/screens/notifications.dart';
import 'package:trafit/util/MyIP.dart';
import 'package:trafit/util/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

SharedPreferences shared;
var room = 0;
//Directory dir;
Future<SharedPreferences> call() async {
  //dir = await getTemporaryDirectory();
  shared = await SharedPreferences.getInstance();
  return SharedPreferences.getInstance();
}

class Postscreen extends StatefulWidget {
  final String _name;
  final String _img;
  final String _category;
  

  Postscreen(this._name, this._img, this._category);

  @override
  _PostscreenState createState() => _PostscreenState();
}

class _PostscreenState extends State<Postscreen> {
  final TextEditingController _commentControl = new TextEditingController();
  Future<SharedPreferences> shared;
  ImageProvider imageProvider;

  int genderCheck = 0;
  String travelMonth = '01';
  String travelDay = '01';
  String startMonth = '01';
  String startDay = '01';
  String endMonth = '01';
  String endDay = '01';

  @override
  void initState() {
    super.initState();
    shared = call();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: shared,
        builder:
            (BuildContext context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            return body(snapshot.data);
          } else {
            return Text('');
          }
        });
  }

  Widget body(SharedPreferences shared) {
    ImageProvider c;

    if (shared.getString('img') == 'x') {
      if (shared.getString('mbti') != null)
        c = Image.asset('assets/mbti/' + shared.getString('mbti') + '.png').image;
      else c = Image.asset('assets/person.png').image;
    } else {
      c = CachedNetworkImageProvider(
          'http://$myIP:3001/${shared.getString('img')}');
    }
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
      body: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundImage: c,
          ),
          title: Text(shared.getString('username')), //로그인 사용자 이름
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    SizedBox(width: 6.0),
                    Text(
                      DateFormat('yy.MM.dd kk:mm').format(DateTime.now()), //현재 날짜
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 7.0),
                TextField(
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
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
                    hintText: "게시글을 작성하세요",
                    hintStyle: TextStyle(
                      fontSize: 15.0,
//                    color: Colors.black,
                    ),
                    prefixIcon: Icon(
                      Icons.edit,
//                    Icons.perm_identity,
                      color: Colors.black,
                    ),
                  ),
                  maxLines: 10,
                  controller: _commentControl,
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 20.0, 0),
                          child: Text("동행 날짜"),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 50.0, 0),
                          child: Row(
                            children: [
                              Text("시작 날짜"),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,0,0,0),
                                child: Text("월"),
                              ),
                              SizedBox(width: 65),
                              Text("일"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(80.0, 0, 0, 0),
                          child: Row(
                            children: [
                              DropdownButton<String>(
                                value: startMonth,
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
                                    startMonth = newValue;
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
                              SizedBox(width: 40),
                              DropdownButton<String>(
                                value: startDay,
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
                                    startDay = newValue;
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                          child: Row(
                            children: [
                              Text("종료 날짜"),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                                child: Text("월"),
                              ),
                              SizedBox(width: 65),
                              Text("일"),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(80.0, 0, 0, 0),
                          child: Row(
                            children: [
                              DropdownButton<String>(
                                value: endMonth,
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
                                    endMonth = newValue;
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
                              SizedBox(width: 40),
                              DropdownButton<String>(
                                value: endDay,
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
                                    endDay = newValue;
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
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 80.0, 0),
                  child: FlatButton(
                    child: Text(
                      "저장",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                    color: Theme.of(context).accentColor,
                    textColor: Colors.white,
                    onPressed: () async {
                      await _addpost(widget._category);
                      String room_num = shared.getString('room_num');
                      shared.setString('room_num', room_num + ','+ room.toString());
                      print('asdas'+room.toString());
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ChatPage(room, widget._category);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _addpost(String category) async {
    ApiService apiService = new ApiService();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String id = sharedPreferences.getString('id');
    String username = sharedPreferences.getString('username');
    String mbti = sharedPreferences.getString('mbti');
    String img = sharedPreferences.getString('img');
    String _comment = _commentControl.text;
    String date = DateFormat('yy.MM.dd kk:mm').format(DateTime.now());
    String startDate = startMonth + startDay;
    String endDate = endMonth + endDay;
    Map<String, dynamic> response = await apiService.post_room(
        img, id, username, _comment, category, date, mbti, startDate, endDate);
    Fluttertoast.showToast(
      msg: response['message'],
      toastLength: Toast.LENGTH_LONG,
    );
    room = response['room'];

    /*setState(() {
      chatrooms.add({
//        "img": "assets/cm1.jpeg",
//        "comment": "$_comment",
//        "name": "JeeWon Lee"
        "user_id": "z1top133",
        "user_photo": "assets/jeewon.jpg",
        "user_name": "이지원",
        "comment": "$_comment",
        "chatlog_flag": "sd",
        "num": "1",
        "max_num": "5",
        "category": "$category",
      });
    });*/
  }
}
