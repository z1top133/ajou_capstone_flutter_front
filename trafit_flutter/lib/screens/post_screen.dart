import 'package:flutter/material.dart';
import 'package:restaurant_ui_kit/screens/details.dart';
import 'package:restaurant_ui_kit/screens/notifications.dart';
import 'package:restaurant_ui_kit/util/ChatRoom.dart';
import 'package:restaurant_ui_kit/util/comments.dart';

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

  @override
  Widget build(BuildContext context) {
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
            backgroundImage: AssetImage(
              "assets/jeewon.jpg", //로그인 사용자 프로필 사진
            ),
          ),
          title: Text("이지원"), //로그인 사용자 이름
          subtitle: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  SizedBox(width: 6.0),
                  Text(
                    "February 14, 2020", //현재 날짜
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
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 70.0, 0),
                child: FlatButton(
                  child: Text(
                    "저장",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  onPressed: () {
                    _addpost(widget._category);
                    Navigator.pop(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ProductDetails(widget._img, widget._name, widget._category);
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
    );
  }

  void _addpost(String category) {
    String _comment = _commentControl.text;
    String name = "sdsdfs";
    setState(() {
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
    });
  }
}
