import 'package:flutter/foundation.dart';
import 'package:flutter_core/db/jp_address.dart';
import 'package:sqflite/sqflite.dart';

class JaSearchModel {
  late Database db;

  Future initDb() async {
    try {
      db = await openDatabase('address.db');
    } catch (error) {
      debugPrint('################################ $error');
    }
  }

  Future<List<JpAddress>> searchFromZipCode(String zipcode) async {
    try {
      List<JpAddress> todos = [];
      List<Map> maps = await db.query('jp_address',
          columns: ['en'], where: 'zip = ?', whereArgs: [zipcode]);
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
          columns: ['en'], where: 'ja like ?', whereArgs: ['%$inputValue%']);
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
