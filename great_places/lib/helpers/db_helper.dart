import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final _dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(_dbPath, 'places.db'),
        onCreate: (_db, version) {
      return _db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL, address TEXT)');
    }, version: 1);
  }

  static Future<void> insert({
    required String table,
    required Map<String, Object> data,
  }) async {
    final _db = await DBHelper.database();
    _db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData({
    required String table,
  }) async {
    final _db = await DBHelper.database();
    return _db.query(table);
  }
}
