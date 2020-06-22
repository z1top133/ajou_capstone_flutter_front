import 'package:flutter/material.dart';
import 'package:trafit/util/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

ApiService apiService = new ApiService();

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _useridControl = new TextEditingController();
  final TextEditingController _usernameControl = new TextEditingController();
  final TextEditingController _emailControl = new TextEditingController();
  final TextEditingController _passwordControl = new TextEditingController();
  final TextEditingController _introduceControl = new TextEditingController();
  final TextEditingController _emailcodeControl = new TextEditingController();
  final TextEditingController _ageControl = new TextEditingController();
  TextEditingController _genderControl = new TextEditingController();
  List<int> ageList = [1980];
  int idCheck = 0;
  int genderCheck = 0;
  String dropdownValue_age = '20';
  String dropdownValue_gender = '남';
  int emailauthCheck =0;
  bool emailCheck = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.0, 0, 20, 0),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              top: 25.0,
            ),
            child: Text(
              "Create an account",
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),

          SizedBox(height: 30.0),
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
                    Icon(
                      Icons.mail_outline,
                    ),
                    SizedBox(width: 15.0),
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
                          hintText: "ID",
                          hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                        maxLines: 1,
                        controller: _useridControl, //이메일 컨트롤러
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0,0.0,20.0,0.0),
                        child: RaisedButton(
                          child: Text(
                            "중복 확인".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async{
                            String abc = await apiService.Id_check(_useridControl.text);
//                            String abc = '중복되지 않음';
                            if(abc == '중복되지 않음'){
                              idCheck = 0;
                              Fluttertoast.showToast(
                                msg: "가입 가능한 아이디 입니다.",
                                toastLength: Toast.LENGTH_LONG,
                              );
                            }
                            else{
                              Fluttertoast.showToast(
                                msg: "중복된 아이디입니다.",
                                toastLength: Toast.LENGTH_LONG,
                              );
                            }
                          },
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
              child: TextField(
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
                  hintText: "Username",
                  prefixIcon: Icon(
                    Icons.perm_identity,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
                maxLines: 1,
                controller: _usernameControl, //유저이름 컨트롤러
              ),
            ),
          ),
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
              child: TextField(
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
                  hintText: "Password",
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
                obscureText: true,
                maxLines: 1,
                controller: _passwordControl, //비밀번호 컨트롤러
              ),
            ),
          ),
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
                    Icon(
                      Icons.mail_outline,
                    ),
                    SizedBox(width: 15.0),
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
                          hintText: "Email",
                          hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                        maxLines: 1,
                        controller: _emailControl, //이메일 컨트롤러
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0,0.0,20.0,0.0),
                        child: RaisedButton(
                          child: Text(
                            "인증번호 전송".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async {
                            String ajouEmail = _emailControl.text;
                            if(ajouEmail.split('@')[1] != 'ajou.ac.kr'){
                              emailCheck = true;
                              Fluttertoast.showToast(
                                msg: "학교 이메일을 입력하세요!",
                                toastLength: Toast.LENGTH_LONG,
                              );

                            }
                            if(emailCheck) {
                              String abc = await apiService.emailAuth(_emailControl.text);
                              print(abc);
                            }
                          },
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                    Icon(
                      Icons.mail_outline,
                    ),
                    SizedBox(width: 15.0),
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
                          hintText: "인증 코드",
                          hintStyle: TextStyle(
                            fontSize: 15.0,
                            color: Colors.grey,
                          ),
                        ),
                        maxLines: 1,
                        controller: _emailcodeControl, //이메일 컨트롤러
                      ),
                    ),
                    Container(
                      width: 80,
                      height: 30,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0.0,0.0,20.0,0.0),
                        child: RaisedButton(
                          child: Text(
                            "인증".toUpperCase(),
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () async{
                            String message = await apiService.emailauthCheck(_emailcodeControl.text);
                            if(message=='인증성공'){
                              emailauthCheck = 1;
                              Fluttertoast.showToast(
                                msg: "인증 성공!!",
                                toastLength: Toast.LENGTH_LONG,
                              );

                            }

                          },
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

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
                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.perm_identity,
                    ),
                    SizedBox(width: 15.0),
                    Text(
                      "Gender",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    SizedBox(width: 15.0),
                    DropdownButton<String>(
                      value: dropdownValue_gender,
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
                          dropdownValue_gender = newValue;
                          if(dropdownValue_gender=='남')genderCheck = 0;
                          else genderCheck =1;
                        });
                      },
                      items: <String>['남', '여']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
                padding: const EdgeInsets.fromLTRB(10.0, 0, 0, 0),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.perm_identity,
                    ),
                    SizedBox(width: 15.0),
                    Text(
                      "Age",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    SizedBox(width: 35.0),
                    DropdownButton<String>(
                      value: dropdownValue_age,
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
                          dropdownValue_age = newValue;
                        });
                      },
                      items: <String>['20', '21','22','23','24','25','26','27','28','29','30','31','32','33','34','35']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
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
              child: TextField(
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
                  hintText: "Introduce",
                  prefixIcon: Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey,
                  ),
                ),
                maxLines: 1,
                controller: _introduceControl, //이메일 컨트롤러
              ),
            ),
          ),
          SizedBox(height: 40.0),
          Container(
            height: 50.0,
            child: RaisedButton(
              child: Text(
                "회원가입".toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () async{//중복체크 했고, 인증 완료 되었을 때 가입 가능한 조건문
                if(emailauthCheck==1) {
                  Map<String, dynamic> response = await apiService.register(
                      _useridControl.text,
                      _usernameControl.text,
                      _emailControl.text,
                      _passwordControl.text,
                      genderCheck,
                      int.parse(dropdownValue_age),
                      _introduceControl.text,
                      null,
                      null,
                      null);
                  Fluttertoast.showToast(
                    msg: response['message'],
                    toastLength: Toast.LENGTH_LONG,
                  );
                }
                
//                user.add(
//                  {
//                    "id": "$_useridControl",
//                    "email": "$_emailControl",
//                    "password": "$_passwordControl",
//                    "introduce": null,
//                    "age":"$dropdownValue_age",
//                    "gender": "$dropdownValue_gender",
//                    "email_auth_flag":"true",
//                    "room_num":"1",//속해 있는 채팅방 번호
//                    "mbti": null,
//                  }
//                );

                //회원가입 정보 User.dart의 user에 저장 후 json 변환
//                Navigator.of(context).push(
//                  MaterialPageRoute(
//                    builder: (BuildContext context) {
//                      return MainScreen();
//                    },
//                  ),
//                );
              },
              color: Theme.of(context).accentColor,
            ),
          ),
          SizedBox(height: 10.0),
          Divider(
            color: Theme.of(context).accentColor,
          ),
          SizedBox(height: 10.0),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Row(
                children: <Widget>[],
              ),
            ),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }

  void _handleSubmitted(String value) {
    _emailcodeControl.clear();
  }
}