import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trafit/screens/cart.dart';
import 'package:trafit/screens/home.dart';
import 'package:trafit/screens/notifications.dart';
import 'package:trafit/screens/profile.dart';
import 'package:trafit/util/const.dart';
import 'package:trafit/widgets/badge.dart';
import 'package:trafit/screens/user_in_chat.dart';
import 'package:trafit/screens/search_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()=>Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            Constants.appName,
          ),
          elevation: 0.0,
          actions: <Widget>[
          ],
        ),

        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            Home(),
            userInChatScreen(),
            chatSearchScreen(""),
            CartScreen(),
            Profile(),
          ],
        ),

        bottomNavigationBar: BottomAppBar(
          child: new Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(width:7),
              IconButton(
                icon: Icon(
                  Icons.home,
                  size: 24.0,
                ),
                color: _page == 0
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(0),
              ),

              IconButton(
                icon:Icon(
                  Icons.message,
                  size: 24.0,
                ),
                color: _page == 1
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(1),
              ),

//              IconButton(
//                icon: Icon(
//                  Icons.search,
//                  size: 24.0,
//                  color: Theme.of(context).primaryColor,
//                ),
//                color: _page == 2
//                    ? Theme.of(context).accentColor
//                    : Theme
//                    .of(context)
//                    .textTheme.caption.color,
//                onPressed: ()=>_pageController.jumpToPage(2),
//              ),

//              IconButton(
//                icon: IconBadge(
//                  icon: Icons.search,
//                  size: 24.0,
//                ),
//                color: _page == 3
//                    ? Theme.of(context).accentColor
//                    : Theme
//                    .of(context)
//                    .textTheme.caption.color,
//                onPressed: ()=>_pageController.jumpToPage(2),
//              ),
              IconButton(
                icon: Icon(
                  Icons.search,
                  size: 24.0,
                ),
                color: _page == 2
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(2),
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  size: 24.0,
                ),
                color: _page == 4
                    ? Theme.of(context).accentColor
                    : Theme
                    .of(context)
                    .textTheme.caption.color,
                onPressed: ()=>_pageController.jumpToPage(4),
              ),

              SizedBox(width:7),
            ],
          ),
          color: Theme.of(context).primaryColor,
          shape: CircularNotchedRectangle(),
        ),
//        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
//        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//        floatingActionButton: FloatingActionButton(
//          elevation: 4.0,
//          child: Icon(
//            Icons.search,
//          ),
//          onPressed: ()=>_pageController.jumpToPage(2),
//        ),//검색 아이콘(center)

      ),
    );
  }

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    firebaseCloudMessaging_Listeners();
    _firebaseMessaging.configure(
      // 앱이 실행중일 경우
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }
  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token){
      print('token:'+token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true)
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings)
    {
      print("Settings registered: $settings");
    });
  }


}
