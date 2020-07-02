import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:restaurant_ui_kit/screens/login.dart';
import 'package:restaurant_ui_kit/screens/main_screen.dart';
import 'dart:convert';

import 'package:restaurant_ui_kit/util/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String _name = "username";

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
String username;

class ChatPage extends StatelessWidget {
  int num;
  ChatPage(this.num);
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'France',
      home: ChatScreen(num),
      // defaultTargetPlatform을 사용하기 위해서는 foundation.dart 패키지의 추가 필요
      theme: defaultTargetPlatform == TargetPlatform.android
          ? kIOSTheme
          : kDefaultTheme,
    );
  }
}

class ChatScreen extends StatefulWidget {
  final int num;
  ChatScreen(this.num);
  
  ChatScreenState createState() => ChatScreenState();
}

// 화면 구성용 상태 위젯. 애니메이션 효과를 위해 TickerProviderStateMixin를 가짐
class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  SocketIO socketIO;
  SharedPreferences sharedPreferences;
  String id;
  

  // 입력한 메시지를 저장하는 리스트
  final List<ChatMessage> _message = <ChatMessage>[];
  
  // 텍스트필드 제어용 컨트롤러
  final TextEditingController _textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // 텍스트필드에 입력된 데이터의 존재 여부
  bool _isComposing = false;

  @override
  void initState() {
    /*ApiService apiService = new ApiService();
    
    apiService.test2(3).then((result) {
      debugPrint(result['message']);
    });*/
    SharedPreferences.getInstance().then((value) => {
      
    });

    socketIO = SocketIOManager().createSocketIO(
      //'http://172.30.1.18:3001',
      'http://49.50.174.200:3001',
      //'https://trafit2186.herokuapp.com/',
      '/',
    );
    socketIO.init();

    socketIO.subscribe('receive_message', (jsonData) {

      //Convert the JSON data received into a Map
      Map<String, dynamic> data = json.decode(jsonData);
      String text = data['message'];
      debugPrint(text);
      // 입력받은 텍스트를 이용해서 리스트에 추가할 메시지 생성
      ChatMessageR message = ChatMessageR(
        text: text,
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


    socketIO.connect();
    //print(widget.num);
    _loadAsync();

    super.initState();
  }

  _loadAsync() async{
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      id = sharedPreferences.getString('id');
      username = sharedPreferences.getString('username');
    });
    socketIO.sendMessage('joinRoom', json.encode({'id': id, 'room': widget.num}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('France'),
        // appBar 하단의 그림자 정도
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 6.0,
      ),
      body: Container(

        child: Column(
          children: <Widget>[
            /*RaisedButton(
              child: Text('RaisedButton'),
              onPressed: () => {
              socketIO.sendMessage(
              'kickip', json.encode({'id': 'dudwns'}))
              },
            ),*/
            // 리스트뷰를 Flexible로 추가.
            Flexible(
              // 리스트뷰 추가
              child: ListView.builder(
                //shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                // 리스트뷰의 스크롤 방향을 반대로 변경. 최신 메시지가 하단에 추가됨
                reverse: true,
                itemCount: _message.length,
                itemBuilder: (_, index) => _message[index],
                controller: scrollController,
              ),
            ),
            // 구분선
            Divider(height: 1.0),
            // 메시지 입력을 받은 위젯(_buildTextCompose)추가
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _buildTextComposer(),
            )
          ],
        ),
        // iOS의 경우 데코레이션 효과 적용
        decoration: Theme.of(context).platform == TargetPlatform.iOS
            ? BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey[200])),
            image: DecorationImage(
              image: AssetImage('assets/paris.jpg'),
              fit: BoxFit.cover,
            )
        )
            : null,

      ),
    );
  }

  // 사용자로부터 메시지를 입력받는 위젯 선언
  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        //width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            // 텍스트 입력 필드
            Flexible(
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
                // 텍스트 필드에 힌트 텍스트 추가
                decoration:
                InputDecoration.collapsed(hintText: "Send a message"),
              ),
            ),
            // 전송 버튼
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              // 플랫폼 종류에 따라 적당한 버튼 추가
              child: Theme.of(context).platform == TargetPlatform.iOS
                  ? CupertinoButton(
                child: Text("send"),
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text)
                    : null,
              )
                  : IconButton(
                // 아이콘 버튼에 전송 아이콘 추가
                icon: Icon(Icons.send),
                // 입력된 텍스트가 존재할 경우에만 _handleSubmitted 호출
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 메시지 전송 버튼이 클릭될 때 호출
  void _handleSubmitted(String text) {
    //ApiService apiService = new ApiService();
    //apiService.chat("재형", "1번");
    // 텍스트 필드의 내용 삭제
    _textController.clear();
    // _isComposing을 false로 설정
    setState(() {
      _isComposing = false;
    });
    socketIO.sendMessage(
        'send_message', json.encode({'message': text, 'id': id}));
    // 입력받은 텍스트를 이용해서 리스트에 추가할 메시지 생성
    ChatMessageS message = ChatMessageS(
      text: text,
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
    //debugPrint(scrollController.position.maxScrollExtent.toString());
    // 위젯의 애니메이션 효과 발생
    message.animationController.forward();
    /*scrollController.animateTo(
      scrollController.position.maxScrollExtent+150,
      duration: Duration(milliseconds: 600),
      curve: Curves.ease
    );*/
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
  final String text;
  final AnimationController animationController;

  ChatMessage({this.text, this.animationController});
}

// 리스브뷰에 추가될 메시지 위젯
class ChatMessageR extends ChatMessage {
  final String text; // 출력할 메시지
  final AnimationController animationController; // 리스트뷰에 등록될 때 보여질 효과

  ChatMessageR({this.text, this.animationController});

  @override
  Widget build(BuildContext context) {
    // 위젯에 애니메이션을 발생하기 위해 SizeTransition을 추가
    return SizeTransition(
      // 사용할 애니메이션 효과 설정
      sizeFactor:
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      // 리스트뷰에 추가될 컨테이너 위젯
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        
        //margin: const EdgeInsets.only(left: 100),
        child: Row(
          //mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            //Flexible(child: SizedBox(width: 1)),

            Container(
              margin: const EdgeInsets.only(right: 16.0),
              // 사용자명의 첫번째 글자를 서클 아바타로 표시
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                      backgroundImage: new AssetImage('assets/mbti/ESFJ.png')
                  ),
                  Text('INFP', style: TextStyle(fontSize: 8),)
                ],
              ),
            ),
            Expanded(
              // 컬럼 추가
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 사용자명을 subhead 테마로 출력
                  Text(_name, style: TextStyle(fontSize: 9)),
                  // 입력받은 메시지 출력
                  Container(child: SizedBox(height: 7,), color: Colors.red,),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),

                    child: Text(text, style: TextStyle(fontSize: 15, fontFamily: 'RobotoSlab')),
                  ),
                  Container(child: SizedBox(height: 10,), color: Colors.red,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessageS extends ChatMessage {
  final String text; // 출력할 메시지
  final AnimationController animationController; // 리스트뷰에 등록될 때 보여질 효과

  ChatMessageS({this.text, this.animationController});

  @override
  Widget build(BuildContext context) {
    // 위젯에 애니메이션을 발생하기 위해 SizeTransition을 추가
    return SizeTransition(
      // 사용할 애니메이션 효과 설정
      sizeFactor:
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      axisAlignment: 0.0,
      // 리스트뷰에 추가될 컨테이너 위젯
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        
        //margin: const EdgeInsets.only(left: 100),
        child: Row(
          //mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Flexible(child: SizedBox(width: 1, height: 1,)),
            Expanded(
              // 컬럼 추가
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  // 사용자명을 subhead 테마로 출력
                  Text(username, style: TextStyle(fontSize: 9)),
                  // 입력받은 메시지 출력
                  Container(child: SizedBox(height: 7,), color: Colors.red,),
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    //decoration: new BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
                    child: Text(text, style: TextStyle(fontSize: 15, fontFamily: 'RobotoSlab')),
                  ),
                  Container(child: SizedBox(height: 10,), color: Colors.red,),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 16.0),
              // 사용자명의 첫번째 글자를 서클 아바타로 표시
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: new AssetImage('assets/mbti/ENFJ.png')
                  ),
                  Text('ENFJ', style: TextStyle(fontSize: 8),)
                ],
              ),
              /*child: CircleAvatar(
                backgroundImage: new AssetImage('assets/mbti/ENFJ.png')
              )*/
            ),
          ],
        ),
      ),
    );
  }
}