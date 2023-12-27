import 'package:flutter/foundation.dart';
import 'package:flutter_core/db/jp_address.dart';
import 'package:flutter_core/models/app_config.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class JaSearchModel {
  late Database db;

  Future initDb() async {
    try {
      var dbDir = await getDatabasesPath();
      var dbPath = join(dbDir, AppConfig.dbFileName);

      db = await openDatabase(dbPath);
    } catch (error) {
      debugPrint('################################ $error');
    }
  }

  Future<List<JpAddress>> searchFromZipCode(String zipcode) async {
    try {
      List<JpAddress> todos = [];
      List<Map> maps = await db.query('jp_address',
          columns: ['*'], where: 'zip like ?', whereArgs: ['%$zipcode%']);
      for (var map in maps) {
        todos.add(JpAddress.fromJson(map));
      }

      return todos;
    } catch (error) {
      debugPrint('################################ $error');
      return [];
    }
  }

  Future<List<JpAddress>> searchFromUserInput(String inputValue) async {
    try {
      List<JpAddress> todos = [];
      List<Map> maps = await db.query('jp_address',
          columns: ['*'], where: 'jp like ?', whereArgs: ['%$inputValue%']);
      for (var map in maps) {
        todos.add(JpAddress.fromJson(map));
      }
      return todos;
    } catch (error) {
      debugPrint('################################ $error');
      return [];
    }
  }
}
