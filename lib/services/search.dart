import 'dart:developer';

import 'package:english_address_converter/models/jp_address.dart';
import 'package:english_address_converter/models/kr_address.dart';
import 'package:english_address_converter/services/database.dart';
import 'package:sqflite/sqflite.dart';

class SearchModel {
  String _trimInputValue(String inputValue) {
    return inputValue.replaceAll(RegExp("\\s"), "");
  }

  Future<List<JPAddress>> searchJapanAddress(String inputValue) async {
    try {
      inputValue = _trimInputValue(inputValue);
      List<JPAddress> todos = [];

      final Database db = await DatabaseService.initDb();

      List<Map> maps = await db.query('jp_address',
          columns: ['*'],
          orderBy: 'address1',
          where: 'address1 like ? or address2 like ?',
          whereArgs: ['%$inputValue%', '%$inputValue%']);

      for (var map in maps) {
        todos.add(JPAddress.fromJson(map));
      }
      return todos;
    } catch (error) {
      log('################################ $error');
      return [];
    }
  }

  Future<List<KRAddress>> searchKoreaAddress(String inputValue) async {
    try {
      inputValue = _trimInputValue(inputValue);

      List<KRAddress> todos = [];
      final Database db = await DatabaseService.initDb();
      List<Map> maps = await db.query('kr_address',
          columns: ['*'],
          orderBy: 'address1',
          where: 'address1 like ?',
          whereArgs: ['%$inputValue%']);
      for (var map in maps) {
        todos.add(KRAddress.fromJson(map));
      }
      return todos;
    } catch (error) {
      log('################################ $error');
      return [];
    }
  }
}
