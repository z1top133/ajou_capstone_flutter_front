import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:trafit/util/mbti_result_percentage.dart';
=======
import 'package:restaurant_ui_kit/util/mbti_result_percentage.dart';
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23


class Mbti_list extends StatefulWidget {
  final String comment;
  final int index;
  Mbti_list({
    Key key,
    @required this.comment,
    @required this.index,
  }) : super(key: key);

  @override
  _Mbti_listState createState() => _Mbti_listState();
}

class _Mbti_listState extends State<Mbti_list> {
  int result_A = 0;
  int result_B = 0;
  int check = 0;
  int ischecked = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Card(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              elevation: 4.0,
              child: Container(
                width: 400,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
                    child: Column(
                            children: <Widget>[
                              SizedBox(height: 10.0),
                              Text(
                                "${widget.comment}",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15,
<<<<<<< HEAD
                                  color: Colors.blueGrey[700]
=======
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("동의",
<<<<<<< HEAD
                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.lightGreen[700])
                                  ),
                                  SizedBox(width: 10,),
                                  Transform.scale(
                                    scale: 1.65,
                                    child: Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: 0,
                                    groupValue: check,
                                    activeColor: Colors.lightGreen[700],
=======
                                    style: TextStyle(fontSize: 10)
                                  ),
                                  Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: 0,
                                    groupValue: check,
                                    activeColor: Colors.red,
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
                                    onChanged: (int value) {
                                      setState(() {
                                        check = value;
                                        ischecked++;
                                        if(ischecked != 0) {
                                          sum_a[widget.index] = 3;
                                          sum_b[widget.index] = 0;
                                        }
                                      });
                                    },
                                  ),
<<<<<<< HEAD
                                  ),
                                  Transform.scale(
                                    scale: 1.3,
                                    child: Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: 1,
                                    groupValue: check,
                                    activeColor: Colors.lightGreen[700],
=======
                                  Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: 1,
                                    groupValue: check,
                                    activeColor: Colors.red,
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
                                    onChanged: (int value) {
                                      setState(() {
                                        check = value;
                                        ischecked++;
                                        if(ischecked != 0) {
                                          sum_a[widget.index] = 2;
                                          sum_b[widget.index] = 0;
                                        }
                                      });
                                    },
                                  ),
<<<<<<< HEAD
                                  ),
                                  
                                  Transform.scale(
                                    scale: 1.0,
                                    child: Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: 2,
                                    groupValue: check,
                                    activeColor: Colors.lightGreen[700],
=======
                                  Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: 2,
                                    groupValue: check,
                                    activeColor: Colors.red,
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
                                    onChanged: (int value) {
                                      setState(() {
                                        check = value;
                                        ischecked++;
                                        if(ischecked != 0) {
                                          sum_a[widget.index] = 1;
                                          sum_b[widget.index] = 0;
                                        }
                                      });
                                    },
                                  ),
<<<<<<< HEAD
                                  ),
                                  
                                  Transform.scale(
                                    scale: 1.0,
                                    child: Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: 3,
                                    groupValue: check,
                                    activeColor: Colors.brown[700],
=======
                                  Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: 3,
                                    groupValue: check,
                                    activeColor: Colors.red,
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
                                    onChanged: (int value) {
                                      setState(() {
                                        check = value;
                                        ischecked++;
                                        if(ischecked != 0) {
                                          sum_a[widget.index] = 0;
                                          sum_b[widget.index] = 1;
                                        }
                                      });
                                    },
                                  ),
<<<<<<< HEAD
                                  ),
                                  
                                  Transform.scale(
                                    scale: 1.3,
                                    child: Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: 4,
                                    groupValue: check,
                                    activeColor: Colors.brown[700],
=======
                                  Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: 4,
                                    groupValue: check,
                                    activeColor: Colors.red,
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
                                    onChanged: (int value) {
                                      setState(() {
                                        check = value;
                                        ischecked++;
                                        if(ischecked != 0) {
                                          sum_a[widget.index] = 0;
                                          sum_b[widget.index] = 2;
                                        }
                                      });
                                    },
                                  ),
<<<<<<< HEAD
                                  ),
                                  
                                  Transform.scale(
                                    scale: 1.65,
                                    child: Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: 5,
                                    groupValue: check,
                                    activeColor: Colors.brown[700],
=======
                                  Radio(
                                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    value: 5,
                                    groupValue: check,
                                    activeColor: Colors.red,
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
                                    onChanged: (int value) {
                                      setState(() {
                                        check = value;
                                        ischecked++;
                                        if(ischecked != 0) {
                                          sum_a[widget.index] = 0;
                                          sum_b[widget.index] = 3;
                                        }
                                        print(result_A);
                                      });
                                    },
                                  ),
<<<<<<< HEAD
                                  ),
                                  SizedBox(width: 10,),
                                  Text("비동의",
                                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.brown[700])
=======
                                  Text("비동의",
                                      style: TextStyle(fontSize: 10)
>>>>>>> 7b79f081ace62148a95778bc249d687905f1da23
                                  )
//                          Radio(
//                            value: SingingCharacter.lafayette,
//                            groupValue: _character,
//                            onChanged: (SingingCharacter value) {
//                              setState(() {
//                                _character = value;
//                              });
//                            },
//                          ),

                                ],
                              )
//                      CircularCheckBox(
//                        value: someBooleanValue,
//                        materialTapTargetSize: MaterialTapTargetSize.padded,
//                        onChanged: (bool x){
//                          someBooleanValue = !someBooleanValue;
//                        },
//                      )
                            ],
                          ),
                    ),
              ),
            ),
        ],
      ),
    );

  }

//  void abc() {
//    setState(() {
//      widget.result+=3;
//      print(widget.result);
//    });
//  }
}
