import 'package:flutter/foundation.dart';
import 'package:english_address_converter/models/jp_address.dart';
import 'package:english_address_converter/models/kr_address.dart';
import 'package:english_address_converter/utils/app_config.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SearchModel {
  late Database db;

  String _trimInputValue(String inputValue) {
    return inputValue.replaceAll(RegExp("\\s"), "");
  }

  Future initDb() async {
    try {
      var dbDir = await getDatabasesPath();
      var dbPath = join(dbDir, AppConfig.dbFileName);

      db = await openDatabase(dbPath);
    } catch (error) {
      debugPrint('################################ $error');
    }
  }

  Future<List<JPAddress>> searchJapanAddress(String inputValue) async {
    try {
      inputValue = _trimInputValue(inputValue);
      List<JPAddress> todos = [];
      List<Map> maps = await db.query('jp_address',
          columns: ['*'],
          orderBy: 'address',
          where: 'address like ?',
          whereArgs: ['%$inputValue%']);
      for (var map in maps) {
        todos.add(JPAddress.fromJson(map));
      }
      return todos;
    } catch (error) {
      debugPrint('################################ $error');
      return [];
    }
  }

  Future<List<KRAddress>> searchKoreaAddress(String inputValue) async {
    try {
      inputValue = _trimInputValue(inputValue);

      List<KRAddress> todos = [];
      List<Map> maps = await db.query('kr_address',
          columns: ['*'],
          orderBy: 'address',
          where: 'address like ?',
          whereArgs: ['%$inputValue%']);
      for (var map in maps) {
        todos.add(KRAddress.fromJson(map));
      }
      return todos;
    } catch (error) {
      debugPrint('################################ $error');
      return [];
    }
  }
}
