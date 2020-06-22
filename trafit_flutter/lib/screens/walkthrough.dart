import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:trafit/screens/join.dart';


class Walkthrough extends StatefulWidget {
  @override
  _WalkthroughState createState() => _WalkthroughState();
}

class _WalkthroughState extends State<Walkthrough> {

  List pageInfos = [
    {
      "title": "안전한 동행",
      "body": "사회에서 보장된 신분을 통해 최소한의 신원을 보장합니다. 개인 정보를 가장 최소한으로 사용하며 그 사람의 보안을 확인하도록 합니다.",
      "img": "assets/on1.png",
    },
    {
      "title": "신속한 동행",
      "body": "실시간 통신을 통해 즉각적인 계획 수립과 수정을 이뤄드립니다. 이러한 방식을 통해 실시간으로 여행의 계획을 수립할 수 있으며 토론하여 그를 수정하도록 합니다.",
      "img": "assets/on2.png",
    },
    {
      "title": "마음에 맞는 동행",
      "body": "MBTI 검사를 통해 자신과 마음에 맞는 동행을 우선적으로 구해드립니다. 만약 마음에 맞는 방이 없다면 필터를 통해 푸시 알림을 설정할 수 있습니다.",
      "img": "assets/on3.png",
    },
  ];
  @override
  Widget build(BuildContext context) {
    List<PageViewModel> pages = [
      for(int i = 0; i<pageInfos.length; i++)
        _buildPageModel(pageInfos[i])
    ];

    return WillPopScope(
      onWillPop: ()=>Future.value(false),
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: EdgeInsets.all(10.0),
          child: IntroductionScreen(
            pages: pages,
            onDone: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return JoinApp();
                  },
                ),
              );
            },
            onSkip: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context){
                    return JoinApp();
                  },
                ),
              );
            },
            showSkipButton: true,
            skip: Text("Skip"),
            next: Text(
              "Next",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor,
              ),
            ),
            done: Text(
              "Done",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).accentColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildPageModel(Map item){
    return PageViewModel(
      title: item['title'],
      body: item['body'],
      image: Image.asset(
        item['img'],
        height: 185.0,
      ),
      decoration: PageDecoration(
        titleTextStyle: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).accentColor,
        ),
        bodyTextStyle: TextStyle(fontSize: 15.0),
//        dotsDecorator: DotsDecorator(
//          activeColor: Theme.of(context).accentColor,
//          activeSize: Size.fromRadius(8),
//        ),
        pageColor: Theme.of(context).primaryColor,
      ),
    );
  }
}