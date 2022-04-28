import 'package:map_together/model/request/login.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  var _db;
  final String _dbName = 'maptogether.db';
  final String _tableLoginData = 'loginData';

  Future<Database> get database async {
    if (_db != null) return _db;
    _db = openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) => _initDB(db),
      version: 1
    );
    return _db;
  }

  Future<void> _initDB(Database db) async {
    await db.execute('''
    CREATE TABLE $_tableLoginData(
          idx INTEGER PRIMARY KEY,
          userIdx INTEGER,
          loginId TEXT,
          loginType TEXT,
          osType TEXT,
          deviceId TEXT
        )
    ''');
  }

  Future<int> insertLoginData(Login loginData) async {
    final db = await database;
    return await db.insert(_tableLoginData, loginData.toJson()).catchError((e) {
      print("insertLoginData error:: $e");
    });
  }

  Future<Login?> getLoginData() async {
    final db = await database;
    final res = await db.query(_tableLoginData, orderBy: 'idx DESC', limit: 1);
    return res.isNotEmpty ? Login.fromJson(res.first) : null;
  }
}