import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:trafit/screens/main_screen.dart';
import 'package:trafit/util/api_service.dart';
import 'package:trafit/util/mbti_result.dart';
import 'package:trafit/util/mbti_result_percentage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class result_screen extends StatefulWidget {
  String E_I;
  String N_S;
  String T_F;
  String J_P;

  result_screen(this.E_I, this.N_S, this.T_F, this.J_P);

  @override
  _result_screenState createState() => _result_screenState();
}

class _result_screenState extends State<result_screen> {
  String mbti_keyword;
  String mbti_comment;
  String mbti_hit_it_off;

  @override
  Widget build(BuildContext context) {
    for(int i=0; i<mbti_result.length; i++){
      Map result = mbti_result[i];
      if(widget.E_I + widget.N_S + widget.T_F + widget.J_P==result['mbti']){
        mbti_keyword = result['keyword'];
        mbti_comment = result['comment'];
        mbti_hit_it_off = result['hit_it_off'];
      }
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
          "결과"
        ),
        elevation: 0.0,
        actions: <Widget>[
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio,
        child: Center(
          child: ListView(
            children: <Widget>[
              Center(
                child: Text(
                  "당신의 성격 유형은 " + widget.E_I + widget.N_S + widget.T_F + widget.J_P+"입니다."
                  ,style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                  ),
                ),
              ),
              Card(
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: 4.0,
                child: Container(
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(100.0, 10.0, 0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            Text(result_percentage[0].toString()+ "%"),
                            Text("내향형"  ,style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                            ),),
                          ],
                        ),
                      ),
                      LinearPercentIndicator(
                        width: 120.0,
                        lineHeight: 10.0,
                        percent: result_percentage_float[0],
                        backgroundColor: Colors.grey,
                        progressColor: Colors.blue,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            Text((100-result_percentage[0]).toString()+ "%"),
                            Text("외향형"
                              ,style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: 4.0,
                child: Container(
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(100.0, 10.0, 0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            Text(result_percentage[1].toString()+ "%"),
                            Text("직관형"
                              ,style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ),),
                          ],
                        ),
                      ),
                      LinearPercentIndicator(
                        width: 120.0,
                        lineHeight: 10.0,
                        percent: result_percentage_float[1],
                        backgroundColor: Colors.grey,
                        progressColor: Colors.blue,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 20.0, 0.0),
                              child: Text((100-result_percentage[1]).toString()+ "%"),
                            ),
                            Text("현실주의형"
                              ,style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: 4.0,
                child: Container(
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(70.0, 10.0, 0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(28.0, 0.0, 0.0, 0.0),
                              child: Text(result_percentage[2].toString()+ "%"),
                            ),
                            Text("원칙주의형"
                              ,style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ),),
                          ],
                        ),
                      ),
                      LinearPercentIndicator(
                        width: 120.0,
                        lineHeight: 10.0,
                        percent: result_percentage_float[2],
                        backgroundColor: Colors.grey,
                        progressColor: Colors.blue,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
                              child: Text((100-result_percentage[2]).toString()+ "%"),
                            ),
                            Text("이성적 사고형"
                              ,style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: 4.0,
                child: Container(
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(100.0, 10.0, 0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            Text(result_percentage[3].toString()+ "%"),
                            Text("탐색형"
                              ,style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ),),
                          ],
                        ),
                      ),
                      LinearPercentIndicator(
                        width: 120.0,
                        lineHeight: 10.0,
                        percent: result_percentage_float[3],
                        backgroundColor: Colors.grey,
                        progressColor: Colors.blue,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                        child: Column(
                          children: <Widget>[
                            Text((100-result_percentage[3]).toString()+ "%"),
                            Text("계획형"
                              ,style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 15,
                              ),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                elevation: 4.0,
                child: Column(
                  children: <Widget>[
                    Center(child:
                    Text(widget.E_I + widget.N_S + widget.T_F + widget.J_P+"형"
                      ,style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),
                    )
                    ),
                    SizedBox(height: 10.0),
                    Center(child: Text('$mbti_keyword'
                      ,style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),)
                    ),
                    SizedBox(height: 10.0),
                    Center(child: Text('$mbti_comment'
                      ,style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),)),
                    SizedBox(height: 10.0),
                    Center(child: Text('당신과 잘 맞는 유형은 $mbti_hit_it_off 입니다'
                      ,style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                      ),)),
                  ],
                ),
              ),
              Center(
                child: Card(
                  shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  elevation: 4.0,
                  child: FlatButton(
                    child: Text("결과 제출"),
                    onPressed: () async{
                      ApiService apiService = new ApiService();
                      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                      String id = sharedPreferences.getString('id');
                      sharedPreferences.setString('mbti', widget.E_I + widget.N_S + widget.T_F + widget.J_P);

                      final byteData = await rootBundle.load('assets/mbti/'+widget.E_I + widget.N_S + widget.T_F + widget.J_P+'.png');
                      Directory tempDir = await getTemporaryDirectory();
                      File(tempDir.path + '/profile.jpg').writeAsBytesSync(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

                      Map<String, dynamic> response = await apiService.mbti_set(id , widget.E_I + widget.N_S + widget.T_F + widget.J_P);

                      Fluttertoast.showToast(
                        msg: response['message'],
                        toastLength: Toast.LENGTH_LONG,
                      );
                      //user[0]['mbti']=widget.E_I + widget.N_S + widget.T_F + widget.J_P;
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return MainScreen();
                          },
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
