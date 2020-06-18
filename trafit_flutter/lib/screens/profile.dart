import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:trafit/providers/app_provider.dart';
import 'package:trafit/screens/Mbti_ei_screen.dart';
import 'package:trafit/screens/splash.dart';
import 'package:trafit/util/CommentPage.dart';
import 'package:trafit/util/MyIP.dart';
import 'package:trafit/util/api_service.dart';
import 'package:trafit/util/const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafit/util/mbti_result.dart';

ApiService apiService = new ApiService();
SharedPreferences sharedPreferences;
List<String> hits;

Future<List> call() async {
  sharedPreferences = await SharedPreferences.getInstance();
  return apiService.show_comment(sharedPreferences.getString('id'));
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget photo;
  bool x = false;
  Future<List> comments;

  @override
  void initState() {
    super.initState();
    comments = call();
  }

  @override
  Widget build(BuildContext context) {
    int index;

    return FutureBuilder<List>(
      future: comments,
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          if (sharedPreferences.getString('mbti') != null) {
            for (int i = 0; i < mbti_result.length; i++) {
              if (mbti_result[i]['mbti'] ==
                  sharedPreferences.getString('mbti')) {
                index = i;
                hits = mbti_result[i]['hit_it_off'].split(',');
                break;
              }
            }
            if (!x) {
              if (sharedPreferences.getString('img') == 'x') {
                photo = Image.asset('assets/mbti/' +
                    sharedPreferences.getString('mbti') +
                    '.png');
              } else {
                photo = CachedNetworkImage(
                    imageUrl:
                        'http://$myIP:3001/${sharedPreferences.getString('img')}');
              }
            }
          } else
            photo = Image.asset('assets/person.png');

          if (sharedPreferences.getString('mbti') == null)
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              width: 100,
                              height: 100,
                              //padding: EdgeInsets.only(left: 1.0, right: 1.0),
                              child: FlatButton(
                                child: photo,
                                onPressed: () => onPhoto(ImageSource.gallery),
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              sharedPreferences.getString('username'),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            InkWell(
                              onTap: () async {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.clear();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return SplashScreen();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "로그아웃",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).accentColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 33,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                          child: Column(
                            children: [
                              Text(
                                'mbti 검사를 하시면 동행을 찾기 더 쉬워요!!',
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.indigo
                                ),
                              ),
                              FlatButton(
                                  child: Text(
                                    "MBTI 검사하기",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white,
                                    ),
                                  ),
                                  color: Colors.indigo[300],
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return Mbti_ei("hello", 0);
                                        },
                                      ),
                                    );
                                  }),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Container(height: 3.0),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "나의 평가",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[CommentPage(snapshot.data)],
                    ),
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? SizedBox()
                        : ListTile(
                            title: Text(
                              "Dark Theme",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            trailing: Switch(
                              value: Provider.of<AppProvider>(context).theme ==
                                      Constants.lightTheme
                                  ? false
                                  : true,
                              onChanged: (v) async {
                                if (v) {
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .setTheme(Constants.darkTheme, "dark");
                                } else {
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .setTheme(Constants.lightTheme, "light");
                                }
                              },
                              activeColor: Theme.of(context).accentColor,
                            ),
                          ),
                  ],
                ),
              ),
            );
          else
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                child: ListView(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              width: 100,
                              height: 100,
                              //padding: EdgeInsets.only(left: 1.0, right: 1.0),
                              child: FlatButton(
                                child: photo,
                                onPressed: () => onPhoto(ImageSource.gallery),
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              sharedPreferences.getString('username'),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            InkWell(
                              onTap: () async {
                                SharedPreferences sharedPreferences =
                                    await SharedPreferences.getInstance();
                                sharedPreferences.clear();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return SplashScreen();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                "로그아웃",
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context).accentColor,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 33,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Text('당신의 MBTI는 '),
                                    ),
                                    Container(
                                      child: Text(
                                        sharedPreferences.getString('mbti'),
                                        style: TextStyle(
                                            color: Colors.green, fontSize: 30),
                                      ),
                                    ),
                                    Text(' 입니다.'),
                                  ],
                                ),
                              ),
                              Divider(),
                              Row(
                                children: <Widget>[
                                  Text('유형:     '),
                                  Text(
                                    mbti_result[index]['keyword'],
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                              Divider(),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width * .6),
                                child: Text(mbti_result[index]['comment']),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Container(height: 3.0),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "나와 잘 맞는 MBTI 유형",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
                        shrinkWrap: true,
                        itemCount: hits.length,
                        itemBuilder: (context, i) {
                          int index;
                          for (int x = 0; x < mbti_result.length; x++) {
                            if (mbti_result[x]['mbti'] == hits[i]) {
                              index = x;
                              break;
                            }
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/mbti/' + hits[i] + '.png'),
                                        fit: BoxFit.fill)),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    hits[i],
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.green),
                                  ),
                                  Text('(${mbti_result[index]['keyword']})',
                                      style: TextStyle(fontSize: 11)),
                                ],
                              ),
                              Text('  :  '),
                              Expanded(
                                  child: Text(
                                mbti_result[index]['comment'],
                              ))
                            ],
                          );
                        },
                      ),
                    ),
                    Divider(),
                    Container(height: 3.0),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        "나의 평가",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[CommentPage(snapshot.data)],
                    ),
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? SizedBox()
                        : ListTile(
                            title: Text(
                              "Dark Theme",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            trailing: Switch(
                              value: Provider.of<AppProvider>(context).theme ==
                                      Constants.lightTheme
                                  ? false
                                  : true,
                              onChanged: (v) async {
                                if (v) {
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .setTheme(Constants.darkTheme, "dark");
                                } else {
                                  Provider.of<AppProvider>(context,
                                          listen: false)
                                      .setTheme(Constants.lightTheme, "light");
                                }
                              },
                              activeColor: Theme.of(context).accentColor,
                            ),
                          ),
                  ],
                ),
              ),
            );
        } else {
          return Text('Calculating answer...');
        }
      },
    );
  }

  void onPhoto(ImageSource source) async {
    File f = await ImagePicker.pickImage(
        source: source, maxWidth: 320, maxHeight: 240, imageQuality: 100);
    setState(() => {x = true, photo = Image.memory(f.readAsBytesSync())});
    Map<String, dynamic> response =
        await apiService.upload(f, sharedPreferences.getString('id'));
    Fluttertoast.showToast(
      msg: response['message'],
      toastLength: Toast.LENGTH_LONG,
    );
    sharedPreferences.setString('img', response['img']);
  }
}
