import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trafit/util/MyIP.dart';
import 'package:trafit/util/api_service.dart';

class CommentPage extends StatefulWidget{
  final String id;
  

  CommentPage(this.id);

  CommentScreen createState() => CommentScreen();
  
}

class CommentScreen extends State<CommentPage>{
  Future<List> comment;
  ApiService apiService = new ApiService();
  @override
  void initState(){
    comment = apiService.show_comment(widget.id);
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: comment,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if(snapshot.hasData){
          return body(snapshot.data);
        }
        else{
          return Text("준비중");
        }
      },
    );
    
  }

  Widget body(List comments){
    
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height*.4,
        width: MediaQuery.of(context).size.width*.7,
        child: ListView.builder(
        padding: const EdgeInsets.all(7.0),
        itemCount: comments.length,
        itemBuilder: (_, i) {
          ImageProvider c;
          if(comments[i]['img'] == 'x'){
            c = AssetImage('assets/mbti/' + comments[i]['mbti'] + '.png');
          }
          else{
            c = CachedNetworkImageProvider('http://$myIP:3001/${comments[i]['img']}');
          }
          return Container(
            padding: const EdgeInsets.fromLTRB(3, 7, 3, 7),
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 17,
                      backgroundImage: c,
                    ),
                    Text(comments[i]['id'], style: TextStyle(fontSize: 9),),
                    Text(comments[i]['mbti'], style: TextStyle(fontSize: 7),)
                  ],
                ),
                SizedBox(width: 15,),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width*.5
                  ),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                  color: Colors.cyan[300],
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                      topLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)
                    ),
                  ),
                  child: Text(comments[i]['comment']),
                )
              ],
            ),
          );
        },
      ),
      )
    );
  }
}

