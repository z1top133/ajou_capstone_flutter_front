import 'package:flutter/material.dart';
import 'package:trafit/screens/Mbti_jp_screen.dart';
import 'package:trafit/util/MBTI_TF.dart';
import 'package:trafit/util/mbti_result_percentage.dart';
import 'package:trafit/widgets/mbti_list_card.dart';



class Mbti_tf extends StatefulWidget {

  final String E_I;
  final String N_S;
  Mbti_tf(this.E_I,this.N_S);

  @override
  _Mbti_tfState createState() => _Mbti_tfState();
}

class _Mbti_tfState extends State<Mbti_tf> {
  int sum_A = 0;
  int sum_B = 0;
  String F_T = "F";
  @override
  Widget build(BuildContext context) {
    for(int i=0; i<sum_a.length; i++){
      sum_a[i]=3;
      sum_b[i]=0;
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
                    itemCount: mbti_tf == null ? 0 : mbti_tf.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map comment_ = mbti_tf[index];
                      return Mbti_list(
                          comment: comment_['comment'],
                          index: index
                      );
                    }),
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
                    F_T= "F";
                    else
                    F_T ="T";
                    print(sum_a);
                    print(sum_b);
                    print(F_T);
                    result_percentage[2] =(sum_A / (sum_A+sum_B) *100).round();
                    Navigator.of(context).push(
                    MaterialPageRoute(
                    builder: (BuildContext context) {
                    return Mbti_jp(widget.E_I,widget.N_S, F_T);
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
