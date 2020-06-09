import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:trafit/screens/main_screen.dart';
import 'package:trafit/util/MyIP.dart';
import 'dart:convert';
import 'package:trafit/util/MySocket.dart';
import 'package:trafit/util/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafit/util/travel_spots.dart';

SharedPreferences shared;
ApiService apiService = new ApiService();
List<String> idList;
List<String> nameList;
List<String> mbtiList;
String bossname;
String bossmbti;
String img;
List<String> imgList;

Future<Map<String, dynamic>> call(int num) async{
  shared = await SharedPreferences.getInstance();
  socketIO.sendMessage('joinRoom', json.encode({'id': shared.getString('id'), 'room': num}));
  return apiService.enter_room(num, shared.getString('id'), shared.getString('username'), shared.getString('mbti'), shared.getString('img'));
}

// IOS용 테마
final ThemeData kIOSTheme = ThemeData(
    primarySwatch: Colors.orange,
    primaryColor: Colors.grey[100],
    primaryColorBrightness: Brightness.light);

// 기본 테마
final ThemeData kDefaultTheme = ThemeData(
  primarySwatch: Colors.white,
  // 전송버튼에 적용할 색상으로 이용
  accentColor: Colors.orangeAccent[400],
);

class ChatPage extends StatefulWidget {
  final int num;
  final String category;
  ChatPage(this.num, this.category);

  ChatScreenState createState() => ChatScreenState();
}

// 화면 구성용 상태 위젯. 애니메이션 효과를 위해 TickerProviderStateMixin를 가짐
class ChatScreenState extends State<ChatPage> with TickerProviderStateMixin {
  // 입력한 메시지를 저장하는 리스트
  final List<ChatMessage> _message = <ChatMessage>[];
  Future<Map<String, dynamic>> userListF;

  // 텍스트필드 제어용 컨트롤러
  final TextEditingController _textController = TextEditingController();

  // 텍스트필드에 입력된 데이터의 존재 여부
  bool _isComposing = false;

  @override
  void initState() {
    userListF = call(widget.num);
    socketIO.subscribe('receive_message', (jsonData) {
      //Convert the JSON data received into a Map
      Map<String, dynamic> data = json.decode(jsonData);
      // 입력받은 텍스트를 이용해서 리스트에 추가할 메시지 생성
      ChatMessageR message = ChatMessageR(
        data: data,
        // animationController 항목에 애니메이션 효과 설정
        // ChatMessage은 UI를 가지는 위젯으로 새로운 message가 리스트뷰에 추가될 때
        // 발생할 애니메이션 효과를 위젯에 직접 부여함
        animationController: AnimationController(
          duration: Duration(milliseconds: 700),
          vsync: this,
        ),
      );
      // 리스트에 메시지 추가
      setState(() {
        _message.insert(0, message);
      });
      // 위젯의 애니메이션 효과 발생
      message.animationController.forward();
    });

    socketIO.subscribe('kickip_message', (jsonData) {
      socketIO.sendMessage('kicked', json.encode({'id' : 'hy2186', 'room' : 100000}));
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return MainScreen();
          },
        ),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userListF,
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot){
        if(snapshot.hasData){
          idList = snapshot.data['user_id'].split(',');
          nameList = snapshot.data['user_name'].split(',');
          mbtiList = snapshot.data['mbti'].split(',');
          bossname = snapshot.data['bossname'];
          bossmbti = snapshot.data['bossmbti'];
          img = snapshot.data['img'];
          imgList = snapshot.data['user_img'].split(',');
          return body();
        }
        else{
          return Text('Calculating answer...');
        }
      },
    );
  }

  Widget body(){
    ImageProvider c;
    if(img == 'x'){
      c = Image.asset('assets/mbti/' + bossmbti + '.png').image;
    }
    else{
      c = CachedNetworkImageProvider('http://$myIP:3001/$img');
    }
    return Scaffold(
      endDrawer: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * .7,
            width: MediaQuery.of(context).size.width * .5,
            child: Drawer(
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Text('Drawer Header'),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                    ),
                  ),
                  ListTile(
                    title: Text('Item 1'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Item 2'),
                    onTap: () {
                      // Update the state of the app
                      // ...
                      // Then close the drawer
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),



      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black54),
        leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
            ),
            onPressed: () => {
              Navigator.of(context).pop()
            }
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CircleAvatar(
              backgroundImage: c,
            ),
            SizedBox(width: 15),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    bossname +'님의 '+ travel_spots[int.parse(widget.category)-1]['name']+' 동행 채팅방',
                    style: Theme.of(context).textTheme.subhead,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    bossmbti,
                    style: TextStyle(fontSize: 10, color: Colors.green),
                  )
                ],
              ),
            )

          ],
        ),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
                icon: Icon(Icons.people),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip
            ),
          )
        ],
      ),

      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.12), BlendMode.dstATop),
                image: AssetImage('assets/paris.jpg')
            )
        ),
        child: Column(
          children: <Widget>[
            // 리스트뷰를 Flexible로 추가.
            Flexible(
              // 리스트뷰 추가
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                // 리스트뷰의 스크롤 방향을 반대로 변경. 최신 메시지가 하단에 추가됨
                reverse: true,
                itemCount: _message.length,
                itemBuilder: (_, index) => _message[index],
              ),
            ),
            // 구분선
            Divider(height: 1.0),
            textWindow()
          ],
        ),
      ),
    );
  }

  Widget textWindow(){
    return Container(
        margin: EdgeInsets.all(15.0),
        height: 55,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35.0),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 3),
                          blurRadius: 5,
                          color: Colors.grey
                      )]
                ),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.face), onPressed: () {}),
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        // 입력된 텍스트에 변화가 있을 때 마다
                        onChanged: (text) {
                          setState(() {
                            _isComposing = text.length > 0;
                          });
                        },
                        // 키보드상에서 확인을 누를 경우. 입력값이 있을 때에만 _handleSubmitted 호출
                        onSubmitted: _isComposing ? _handleSubmitted : null,
                        decoration: InputDecoration(
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(width: 15),
                  ],
                ),
              ),
            ),
            SizedBox(width: 15),
            Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                  color: Colors.green, shape: BoxShape.circle),
              child: InkWell(
                child: IconButton(
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: _isComposing
                      ? () => _handleSubmitted(_textController.text)
                      : null,
                ),
              ),
            )
          ],
        )
    );
  }

  // 메시지 전송 버튼이 클릭될 때 호출
  void _handleSubmitted(String text) {
    // 텍스트 필드의 내용 삭제
    _textController.clear();
    // _isComposing을 false로 설정
    setState(() {
      _isComposing = false;
    });
    Map<String, dynamic> data = {'message': text, 'id': shared.getString('id'), 'room': widget.num};
    socketIO.sendMessage(
        'send_message', json.encode(data));
    // 입력받은 텍스트를 이용해서 리스트에 추가할 메시지 생성
    ChatMessageS message = ChatMessageS(
      data: data,
      // animationController 항목에 애니메이션 효과 설정
      // ChatMessage은 UI를 가지는 위젯으로 새로운 message가 리스트뷰에 추가될 때
      // 발생할 애니메이션 효과를 위젯에 직접 부여함
      animationController: AnimationController(
        duration: Duration(milliseconds: 700),
        vsync: this,
      ),
    );
    // 리스트에 메시지 추가
    setState(() {
      _message.insert(0, message);
    });
    // 위젯의 애니메이션 효과 발생
    message.animationController.forward();
  }

  @override
  void dispose() {
    // 메시지가 생성될 때마다 animationController가 생성/부여 되었으므로 모든 메시지로부터 animationController 해제
    for (ChatMessage message in _message) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}

abstract class ChatMessage extends StatelessWidget{
  final Map<String, dynamic> data;
  final AnimationController animationController;

  ChatMessage({this.data, this.animationController});
}

// 리스브뷰에 추가될 메시지 위젯
class ChatMessageR extends ChatMessage {
  final Map<String, dynamic> data; // 출력할 메시지
  final AnimationController animationController; // 리스트뷰에 등록될 때 보여질 효과

  ChatMessageR({this.data, this.animationController});

  @override
  Widget build(BuildContext context) {

    // 위젯에 애니메이션을 발생하기 위해 SizeTransition을 추가
    return SizeTransition(
      // 사용할 애니메이션 효과 설정
        sizeFactor:
        CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        // 리스트뷰에 추가될 컨테이너 위젯
        child: receiveMessage(context)
    );
  }

  Widget receiveMessage(BuildContext context){
    int index=idList.indexOf(data['id']);
    ImageProvider c;
    if(imgList[index] == 'x'){
      c = AssetImage('assets/mbti/'+mbtiList[index]+'.png');
    }
    else{
      c = CachedNetworkImageProvider('http://$myIP:3001/${imgList[index]}');
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 10,),
              CircleAvatar(
                backgroundImage: c,
                radius: 17,
              ),
              SizedBox(height: 3,),
              Text(nameList[index],
                style: TextStyle(fontSize: 9),)
            ],
          ),
          SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                mbtiList[index],
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.cyan[300],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)
                  ),
                ),
                child: Text(
                  data['message'],
                  style: Theme.of(context).textTheme.body2.apply(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatMessageS extends ChatMessage {
  final Map<String, dynamic> data; // 출력할 메시지
  final AnimationController animationController; // 리스트뷰에 등록될 때 보여질 효과

  ChatMessageS({this.data, this.animationController});

  @override
  Widget build(BuildContext context) {
    // 위젯에 애니메이션을 발생하기 위해 SizeTransition을 추가
    return SizeTransition(
      // 사용할 애니메이션 효과 설정
        sizeFactor:
        CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        axisAlignment: 0.0,
        // 리스트뷰에 추가될 컨테이너 위젯
        child: sendMessage(context)
    );
  }

  Widget sendMessage(BuildContext context){
    ImageProvider c;
    if(shared.getString('img') == 'x'){
      c = AssetImage('assets/mbti/'+shared.getString('mbti')+'.png');
    }
    else{
      c = CachedNetworkImageProvider('http://$myIP:3001/${shared.getString('img')}');
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                shared.getString('mbti'),
                style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
              ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * .6),
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25)
                  ),
                ),
                child: Text(
                  data['message'],
                  style: Theme.of(context).textTheme.body2.apply(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 8),
          Column(
            children: <Widget>[
              SizedBox(height: 10,),
              CircleAvatar(
                backgroundImage: c,
                radius: 17,
              ),
              SizedBox(height: 3,),
              Text(shared.getString('username'),
                style: TextStyle(fontSize: 9),)
            ],
          )

        ],
      ),
    );
  }
}