import 'package:flutter/material.dart';
import 'package:trafit/screens/Mbti_ns_screen.dart';
import 'package:trafit/util/MBTI_EI.dart';
import 'package:trafit/util/mbti_result_percentage.dart';
import 'package:trafit/widgets/mbti_list_card.dart';


class Mbti_ei extends StatefulWidget {
  final String title;
  int result = 0;

  Mbti_ei(this.title, this.result);

  @override
  _Mbti_eiState createState() => _Mbti_eiState();
}

class _Mbti_eiState extends State<Mbti_ei> {
  int sum_A = 0;
  int sum_B = 0;
  String E_I = "E";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_backspace,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
              "성격 유형검사"
          ),
          elevation: 0.0,
          actions: <Widget>[
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width * MediaQuery.of(context).devicePixelRatio,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
            child: ListView(
              children: <Widget>[
                ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: mbti_ej == null ? 0 : mbti_ej.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map comment_ = mbti_ej[index];
                      return Mbti_list(
                        comment: comment_['comment'],
                        index: index,
                      );
                    }),
                SizedBox(height: 5.0),
                Center(
                  child: Card(
                    shape:
                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                    elevation: 4.0,
                    child: FlatButton(
                      child: Text("다음 >"),
                          onPressed: () {
                    for(int i=0; i<sum_a.length; i++){
                    sum_A += sum_a[i];
                    sum_B += sum_b[i];
                    }
                    if(sum_A>sum_B)
                    E_I = "I";
                    else
                    E_I = "E";
                    print(sum_a);
                    print(sum_b);
                    print(E_I);
                    result_percentage[0] = (sum_A / (sum_A+sum_B) *100).round();
                    Navigator.of(context).push(
                    MaterialPageRoute(
                    builder: (BuildContext context) {
                    return Mbti_ns(E_I);
                    },
                    ),
                    );
                    },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
