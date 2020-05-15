import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final String img;
  final String name;
  final String comment;

  Chat({
    Key key,
    @required this.img,
    @required this.name,
    @required this.comment,
  }) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 4.0,
        child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 200,
                  child: ListView(
                    children: <Widget>[
                      CircleAvatar(
                          radius: 35.0,
                          backgroundImage: AssetImage(
                            "${widget.img}",
                          )),
                      Center(
                        child: Text(
                          "${widget.name}",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 17,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        "${widget.comment}",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                      ),
                      FlatButton(
                        child: Text(
                            "채팅방 입장",
                          style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 17,
                        ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
