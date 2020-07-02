import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:trafit/screens/ChatPage.dart';

final String TableName = 'Message';

class DBHelper {

  DBHelper._();
  static final DBHelper _db = DBHelper._();
  factory DBHelper() => _db;

  static Database _database;

  Future<Database> get database async {
    if(_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'MyMessageDB4.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TableName(
            room INTEGER,
            id TEXT,
            username TEXT,
            mbti TEXT,
            img TEXT,
            message TEXT,
            type TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion){}
    );
  }
  
    //Create
  createData(List<ChatMessage> message) async {
    final db = await database;
    for(int i = message.length -1; i>= 0; i--){
      await db.rawInsert('INSERT INTO $TableName(room, id, username, mbti, img, message, type) VALUES(?, ?, ?, ?, ?, ?, ?)', [message[i].data['room'], message[i].data['id'], message[i].data['username'], message[i].data['mbti'], message[i].data['img'], message[i].data['message'], message[i].data['type']]);
    }
  }

  //Read
  getMessage(int room, String id) async {
    final db = await database;
    var res = await db.rawQuery('SELECT * FROM $TableName WHERE room = ?', [room]);
    List<Map<String, dynamic>> messages = new List<Map<String,dynamic>>();
    if(res.length == 0){
      return null;
    }
    else{
      for(int i=0;i<res.length; i++){
        Map<String, dynamic> data = {
          'id': res[i]['id'],
          'username': res[i]['username'],
          'mbti': res[i]['mbti'],
          'img': res[i]['img'],
          'message': res[i]['message'],
          'type': res[i]['type']
        };
        messages.insert(0, data);
        
      }
      return messages;
    }
  }

  //Delete
  deleteMessage(int room) async {
    final db = await database;
    var res = db.rawDelete('DELETE FROM $TableName WHERE id = ?', [room]);
    return res;
  }

  //Delete All
  deleteAllMessage() async {
    final db = await database;
    db.rawDelete('DELETE FROM $TableName');
  }

}