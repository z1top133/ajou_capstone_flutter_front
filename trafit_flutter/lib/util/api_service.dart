import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

const Map<String, String> headers1 = {"Content-type": "application/json"};

String _hostname() {
  if (Platform.isAndroid)
    return 'http://10.0.2.2:3000';
  else
    return 'http://localhost:3000';
}

class ApiService{

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

    Response response = await post(_hostname()+'/register', headers: headers1, body: jsonEncode(pass));

    return jsonDecode(response.body);//json으로 파싱
  }
  Future<Map<String, dynamic>> login(_id, _password) async{

    Map<String, dynamic> pass = {//변수를 json으로
      'id': _id,
      'password': _password,
    };

    Response response = await post(_hostname()+'/register', headers: headers1, body: jsonEncode(pass));

    return jsonDecode(response.body);//json으로 파싱
  }

  Future<List> test1(_id) async{
    Map<String, dynamic> pass = {//변수를 json으로
      'id' : _id,
    };

    Response response = await post(_hostname()+'/test1', headers: headers1, body: jsonEncode(pass));

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
