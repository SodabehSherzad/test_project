import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'home.dart';
import 'category.dart';
import 'sub_category.dart';

class DatabaseHelper {
  Database database;

  Future initDb() async {
    final dbPath = await getDatabasesPath();
    final String path = join(dbPath, 'makeup.db');

    final exist = await databaseExists(path);

    if (exist) {
      print("db exist");

      database = await openDatabase(path);
    } else {
      print("db copy");

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join('assets', 'makeup.db'));
      List<int> bytes =
      data.buffer.asInt8List(data.offsetInBytes, data.lengthInBytes);

      await File(path).writeAsBytes(bytes, flush: true);

      print("copied");
    }

    database = await openDatabase(path);
  }

  Future closeDB() async {
    database.close();
  }
}