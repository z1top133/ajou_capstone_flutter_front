import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'MyIP.dart';

const Map<String, String> headers1 = {"Content-type": "application/json"};

String _hostname() {
  if (Platform.isAndroid)
    return 'http://$myIP:3001';
  else if(Platform.isIOS) {
    return 'http://$myIP:3001';
  }
    return 'http://localhost:3000';
}

class ApiService{

  Map<String,dynamic> makeJson(String toJson){
    return jsonDecode(toJson);
  }

  Future<Map<String, dynamic>> register(_id ,_username, _email, _password, _gender, _age, _introduce, _emailFlag, _roomNum, _mbti) async{

    Map<String, dynamic> pass = {//변수를 json으로
      'id' : _id,
      'username' : _username,
      'email': _email,
      'password': _password,
      'gender': _gender,
      'age': _age,
      'introduce': _introduce,
      '_email_auth_flag': _emailFlag,
      'room_num': _roomNum,
      'mbti': _mbti
    };
    print(pass);
    Response response = await post(_hostname()+ '/register', headers: headers1, body: jsonEncode(pass));
    int statusCode = response.statusCode;
    String body = response.body.toString();
    print('Status: $statusCode, $body');
    return jsonDecode(response.body);//json으로 파싱
  }
  Future<Map<String,dynamic>> login(_id, _password) async{

    Map<String, dynamic> pass = {//변수를 json으로
      'id': _id,
      'password': _password,
    };

    Response response = await post(_hostname()+'/login_check', headers: headers1, body: jsonEncode(pass));

    return jsonDecode(response.body);//json으로 파싱
  }

  Future<String> Id_check(_id) async{

    Map<String, dynamic> pass = {//변수를 json으로
      'id': _id
    };

    Response response = await post(_hostname()+'/id_check', headers: headers1, body: jsonEncode(pass));
    String abc = response.body.toString();
    return abc;//json으로 파싱
  }

  Future<String> emailAuth(_email) async{

    Map<String, dynamic> pass = {//변수를 json으로
      'email': _email
    };

    Response response = await post('http://49.50.174.200:3001/emailauth', headers: headers1, body: jsonEncode(pass));
    String abc = response.body.toString();
    return abc;//json으로 파싱
  }
  Future<String> emailauthCheck(_code) async{

    Map<String, dynamic> pass = {//변수를 json으로
      'authCode': _code
    };

    Response response = await post('http://49.50.174.200:3001/emailauth/authprocess', headers: headers1, body: jsonEncode(pass));
    String emailauthMessage = response.body.toString();
    print(response.body);
    return emailauthMessage;//json으로 파싱
  }



  Future<List> test1(_id) async{
    Map<String, dynamic> pass = {//변수를 json으로
      'id' : _id,
    };

    Response response = await post(_hostname()+'/test1', headers: headers1, body: jsonEncode(pass));
    print(response);
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> mbti_set(_id, mbti) async{
    Map<String, dynamic> pass = {//변수를 json으로
      'id' : _id,
      'mbti': mbti
    };

    Response response = await post(_hostname()+'/mbti_set', headers: headers1, body: jsonEncode(pass));
    
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> post_room(_img ,_id, _username, _comment, _category, _date, _mbti , _startDate, _endDate) async{
    
    Map<String, dynamic> pass = {//변수를 json으로
      'id' : _id,
      'username': _username,
      'comment': _comment,
      'category': _category,
      'date': _date,
      'mbti': _mbti,
      'img': _img,
      'start_date':_startDate,
      'end_date':_endDate
    };

    Response response = await post(_hostname()+'/post_room', headers: headers1, body: jsonEncode(pass));

    return jsonDecode(response.body);
  }

  Future<List> show_room(_category) async{
    Map<String, dynamic> pass = {//변수를 json으로
      'category': _category
    };

    Response response = await post(_hostname()+'/show_room', headers: headers1, body: jsonEncode(pass));
    
    return jsonDecode(response.body);
  }//카테고리 별 채팅방 불러오기
  Future<List> user_in_room(_roomNumber) async{
    Map<String, dynamic> pass = {//변수를 json으로
      'room_num':_roomNumber
    };

    Response response = await post(_hostname()+'/user_in_room', headers: headers1, body: jsonEncode(pass));

    return jsonDecode(response.body);
  }//user가 속한 채팅방만 불러오기

  Future<List> search_room(_keyword, _date) async{
    Map<String, dynamic> pass = {//변수를 json으로
      'keyword': _keyword,
      'date': _date
    };

    Response response = await post(_hostname()+'/search_room', headers: headers1, body: jsonEncode(pass));

    return jsonDecode(response.body);
  }//채팅방 검색

  Future<Map<String, dynamic>> upload(File file, String id) async{
    final length = await file.length();

    var request = new MultipartRequest('POST', Uri.parse(_hostname()+'/upload'));
    request.fields['id'] =  id;
    request.files.add(new MultipartFile('image', file.readAsBytes().asStream(), length, filename: "profile.jpg"));
    Response response = await Response.fromStream(await request.send());

    return jsonDecode(response.body);
  }

  Future<List> enter_room(int num, String id, String username, String mbti, String img, String token) async{
    Map<String, dynamic> pass = {//변수를 json으로
      'id': id,
      'username': username,
      'mbti': mbti,
      'room': num,
      'img': img,
      'token': token
    };

    Response response = await post(_hostname()+'/enter_room', headers: headers1, body: jsonEncode(pass));
    
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> report(String id, String toid, String type, String comment, String date) async{
    Map<String, dynamic> pass = {//변수를 json으로
      'id': id,
      'toid': toid,
      'type': type,
      'comment': comment,
      'date': date
    };

    Response response = await post(_hostname()+'/report', headers: headers1, body: jsonEncode(pass));
    
    return jsonDecode(response.body);
  }

  sendMessage(_token, _message, _name) async{
    Map<String, dynamic> pass = {
      'token': _token,
      'message' : _message,
      'name' : _name
    };

    Response response = await post(_hostname()+'/send_message', headers: headers1, body: jsonEncode(pass));
  }

  leaveRoom(_id, _room_num, int room, bool isBoss) async{
    Map<String, dynamic> pass = {
      'id': _id,
      'room_num': _room_num,
      'room': room,
      'isboss': isBoss
    };

    Response response = await post(_hostname() + '/leave_room', headers: headers1, body: jsonEncode(pass));
  }


  Future<Map<String, dynamic>> comments(String id, String username, String mbti, String img, String toid, String comment) async{
    Map<String, dynamic> pass = {//변수를 json으로
      'id': id,
      'toid': toid,
      'username': username,
      'comment': comment,
      'mbti': mbti,
      'img': img
    };

    Response response = await post(_hostname()+'/comments', headers: headers1, body: jsonEncode(pass));
    
    return jsonDecode(response.body);
  }

  Future<List> show_comment(String id) async{
    Map<String, dynamic> pass = {//변수를 json으로
      'id': id
    };

    Response response = await post(_hostname()+'/show_comment', headers: headers1, body: jsonEncode(pass));

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> room_info(int room) async{
    Map<String, dynamic> pass = {//변수를 json으로
      'room': room
    };

    Response response = await post(_hostname()+'/room_info', headers: headers1, body: jsonEncode(pass));

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> deny_check(int room, String id) async{
    Map<String, dynamic> pass = {//변수를 json으로
      'room': room,
      'id': id
    };

    Response response = await post(_hostname()+'/deny_check', headers: headers1, body: jsonEncode(pass));

    return jsonDecode(response.body);
  }

}
