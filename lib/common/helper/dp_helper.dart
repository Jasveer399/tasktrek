import 'package:flutter/rendering.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:tasktrek/common/models/task_model.dart';

class DBHelper {
  static Future<void> createtable(sql.Database database) async {
    await database.execute("CREATE TABLE todos("
        "id INTEGER PRIMARY KEY AUTOINCREMENT,"
        "title STRING, desc TEXT,date STRING,"
        "startTime STRING, endTime STRING,"
        "remind INTEGER, repeat STRING,"
        "iscomplested INTEGER)");

    await database.execute("CREATE TABLE user("
        "id INTEGER PRIMARY KEY AUTOINCREMENT DEFAULT 0,"
        " isVerified INTEGER)");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'tasktrek',
      version: 1,
      onCreate: (sql.Database database, version) async {
        await createtable(database);
      },
    );
  }

  static Future<int> createItem(Task task) async {
    final db = await DBHelper.db();

    final id = await db.insert('todos', task.toJson(),
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<int> createuser(int isVerified) async {
    final db = await DBHelper.db();

    final data = {
      "id": 1,
      "isverified": isVerified,
    };

    final id = await db.insert('user', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getuser() async {
    final db = await DBHelper.db();
    return db.query('user', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DBHelper.db();
    return db.query('todos', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DBHelper.db();
    return db.query('todos', where: "id=?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(
    int id,
    String title,
    String desc,
    int isCompleted,
    String date,
    String startTime,
    String endTime,
  ) async {
    final data = {
      "id": id,
      "title": title,
      "desc": desc,
      "iscomplested": isCompleted,
      "date": date,
      "startTime": startTime,
      "endtime": endTime,
    };
    final db = await DBHelper.db();
    final results =
        await db.update('todos', data, where: "id=?", whereArgs: [id]);
    return results;
  }

  static Future<void> deleteItem(int id) async {
    final db = await DBHelper.db();

    try {
      db.delete('todos', where: 'id=?', whereArgs: [id]);
    } catch (e) {
      debugPrint('$e');
    }
  }
}
