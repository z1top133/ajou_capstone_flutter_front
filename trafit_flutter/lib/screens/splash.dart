import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trafit/screens/main_screen.dart';
import 'package:trafit/screens/walkthrough.dart';
import 'package:trafit/util/MyIP.dart';
import 'package:trafit/util/MySocket.dart';
import 'package:trafit/util/const.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTimeout(SharedPreferences value) {
    if(value.getString('id') == null){
      return Timer(Duration(seconds: 2), changeScreen);
    }
    else{
      return Timer(Duration(seconds: 2), changeScreen1);
    }
  }

  changeScreen() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Walkthrough();
        },
      ),
    );
  }
  changeScreen1() async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return MainScreen();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    SharedPreferences.getInstance().then((value) => {
      startTimeout(value)
    });
    
  }

  @override
  Widget build(BuildContext context) {
    socketIO = SocketIOManager().createSocketIO(
      'http://$myIP:3002',
      '/',
    );
    socketIO.init();
    socketIO.connect();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        margin: EdgeInsets.only(left: 40.0, right: 40.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'assets/travel.png',
                width: 150,
                height: 150,
              ),
              SizedBox(width: 40.0),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                  top: 15.0,
                ),
                child: Text(
                  'Welcome to Trafit',
//                  "${Constants.appName}",
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
