import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:trafit/providers/app_provider.dart';
import 'package:trafit/screens/splash.dart';
import 'package:trafit/util/MyIP.dart';
import 'package:trafit/util/api_service.dart';
import 'package:trafit/util/const.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

ApiService apiService = new ApiService();
SharedPreferences sharedPreferences;
//Directory tempDir;

Future<Map<String, dynamic>> call() async{
  //tempDir = await getTemporaryDirectory();
  sharedPreferences = await SharedPreferences.getInstance();
  String id = sharedPreferences.getString('id');

  return apiService.show_profile(id);
}

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Widget photo;
  bool x = false;
  Future<Map<String, dynamic>> response;
  @override
  void initState(){
    super.initState();
    response = call();
  }

  @override
  Widget build(BuildContext context) {
    
    return FutureBuilder<Map<String, dynamic>>(
      future: response,
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot){
          if(snapshot.hasData){
            if(!x){
              if(sharedPreferences.getString('img') == 'x'){
                photo = Image.asset('assets/mbti/' + sharedPreferences.getString('mbti') +'.png');
              }
              else{
                photo = CachedNetworkImage(imageUrl: 'http://$myIP:3001/${sharedPreferences.getString('img')}');
              }
            }
            
            return Scaffold(
      body: Padding(
        padding: EdgeInsets.fromLTRB(10.0,0,10.0,0),

        child: ListView(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  padding: EdgeInsets.only(left: 1.0, right: 1.0),
                  child: FlatButton(
                    child: photo,
                    onPressed: () => onPhoto(ImageSource.gallery),
                  )
//                  Image.asset(
//                    "assets/cm4.jpeg",
//                    fit: BoxFit.cover,
//                    width: 100.0,
//                    height: 100.0,
//                  ),
                ),
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            snapshot.data['username'],
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            snapshot.data['email'],
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          InkWell(
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (BuildContext context){
                                    return SplashScreen();
                                  },
                                ),
                              );
                            },
                            child: Text("Logout",
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

                    ],
                  ),
                  flex: 3,
                ),
              ],
            ),

            Divider(),
            Container(height: 15.0),

            Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                "Account Information".toUpperCase(),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            ListTile(
              title: Text(
                "Full Name",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                "Jane Mary Doe",
              ),

              trailing: IconButton(
                icon: Icon(
                  Icons.edit,
                  size: 20.0,
                ),
                onPressed: (){
                },
                tooltip: "Edit",
              ),
            ),

            ListTile(
              title: Text(
                "Email",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                snapshot.data['email'],
              ),
            ),

            ListTile(
              title: Text(
                "Phone",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                "+1 816-926-6241",
              ),
            ),

            ListTile(
              title: Text(
                "Address",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                "1278 Loving Acres RoadKansas City, MO 64110",
              ),
            ),

            ListTile(
              title: Text(
                "Gender",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                "Female",
              ),
            ),

            ListTile(
              title: Text(
                "Date of Birth",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),

              subtitle: Text(
                "April 9, 1995",
              ),
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
                value: Provider.of<AppProvider>(context).theme == Constants.lightTheme
                    ? false
                    : true,
                onChanged: (v) async{
                  if (v) {
                    Provider.of<AppProvider>(context, listen: false)
                        .setTheme(Constants.darkTheme, "dark");
                  } else {
                    Provider.of<AppProvider>(context, listen: false)
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
          }
          else{
            return Text('Calculating answer...');
          }
      },
    );
  }

  void onPhoto(ImageSource source) async {
    File f = await ImagePicker.pickImage(source: source, maxWidth: 320, maxHeight: 240, imageQuality: 100);
    setState(() => {
      x = true,
      photo = Image.memory(f.readAsBytesSync())
    });
    Map<String, dynamic> response = await apiService.upload(f, sharedPreferences.getString('id'));
    Fluttertoast.showToast(
      msg: response['message'],
      toastLength: Toast.LENGTH_LONG,
    );
    sharedPreferences.setString('img', response['img']);
  }
}
