import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import '../model/add_task_model.dart';

class DBHelper {
  static Database? _db;
  static final int _version = 1;
  static final String tableName = "UserTasks";

  static Future<void> dbInit() async {
    if (_db != null) {
      return;
    }
    try {
      //database is created
      String _path = await getDatabasesPath() + "UserTasks.db";
      _db =
          await openDatabase(_path, version: _version, onCreate: (db, version) {
        //table is created in database
        return db.execute("CREATE TABLE $tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "title STRING, note TEXT, date STRING,"
            "startTime STRING, endTime STRING,"
            "remind INTEGER, repeat STRING,"
            "color INTEGER, isCompleted INTEGER)");
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //insert mathod

  static Future<int> insert(TaskModel? task) async {
    return await _db?.insert(tableName, task!.toJson()) ?? 1;
  }

  static Future<List<Map<String,dynamic>>> query()async{
    return await _db!.query(tableName);
  }
  static delete(TaskModel task)async{
   await _db!.delete(tableName, where: 'id=?', whereArgs: [task.id]);

  }
  static update(int id)async{
    await _db!.rawQuery('''UPDATE UserTasks
    SET isCompleted=?
    WHERE id=?
    ''',[1,id]);


  }
}
