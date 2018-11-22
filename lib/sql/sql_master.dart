import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'dart:io';

class SqlMaster{

  Future<String> _getDatabase() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, 'ogsusu.db');
    print(path);
    // make sure the folder exists
    if (await Directory(dirname(path)).exists()) {
      await deleteDatabase(path);
    } else {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (e) {
        print(e);
      }
    }
    return path;
  }

  delete() async{
    _getDatabase().then((path) => deleteDatabase(path));
  }

  Future<Database> open() async{
    String path = await _getDatabase();
    Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
            'CREATE TABLE IF NOT EXISTS sports_event (id INTEGER PRIMARY KEY, '
                'categoryId INTEGER, label TEXT, name TEXT, '
                'icon TEXT, description TEXT, type INTEGER, '
                'agent INTEGER, platform INTEGER, flag INTEGER)');
        await db.execute('INSERT INTO sports_event('
            'categoryId, label, name, icon, description, '
            'type, agent, platform, flag) '
            'VALUES(0, "NBA", "", "res/img/icon_nba_64.png", "", 0, 0, 0, 0)');
      });
    return database;
  }

}