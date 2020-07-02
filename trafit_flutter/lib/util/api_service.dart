import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

const Map<String, String> headers1 = {"Content-type": "application/json"};

String _hostname() {
  if (Platform.isAndroid)
    return 'http://218.148.42.126:3001';
  else
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

    Response response = await post(_hostname()+'http://49.50.174.200:3000/emailauth', headers: headers1, body: jsonEncode(pass));
    String abc = response.body.toString();
    return abc;//json으로 파싱
  }
  Future<String> emailauthCheck(_code) async{

    Map<String, dynamic> pass = {//변수를 json으로
      'authCode': _code
    };

    Response response = await post(_hostname()+'http://49.50.174.200:3000/emailauth/authprocess', headers: headers1, body: jsonEncode(pass));
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

  Future<Map<String, dynamic>> post_room(_id, _username, _comment, _category) async{
    Map<String, dynamic> pass = {//변수를 json으로
      'id' : _id,
      'username': _username,
      'comment': _comment,
      'category': _category
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
  }

  Future<bool> upload(File file) async{
    final length = await file.length();

    var request = new MultipartRequest('POST', Uri.parse(_hostname()+'/upload'));
    request.files.add(new MultipartFile('image', file.readAsBytes().asStream(), length, filename: "profile.jpg"));
    Response response = await Response.fromStream(await request.send());

    return true;
  }
}
