import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../constant/strings.dart';

class SqlDB {
//===================================Init DataBase==============================
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB();
      return _db;
    } else {
      return _db;
    }
  }

  initDB() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, AppStrings.dataBaseName);
    Database db = await openDatabase(
      path,
      onCreate: onCreateDB,
      version: 4,
      onUpgrade: onUpgradeDB,
    );
    return db;
  }

//=================================Create DataBase==============================
  onCreateDB(Database db, int version) async {
    Batch batch = db.batch();
    batch.execute('''
    CREATE TABLE "${AppStrings.tableName}" (
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "title" TEXT NOT NULL,
      "color" TEXT NOT NULL,
      "note" TEXT NOT NULL
  )
''');
    await batch.commit();
    print("onCreateDB");
  }

//===============================Upgrade DataBase===============================
  onUpgradeDB(Database db, int oldVersion, int newVersion) async {
    print("onUpgradeDB");
  }

//===================================Select=====================================
  readData(String sql) async {
    Database? myDB = await db;
    List<Map> response = await myDB!.rawQuery(sql);
    return response;
  }

//===================================Delete=====================================
  deleteData(String sql) async {
    Database? myDB = await db;
    int response = await myDB!.rawDelete(sql);
    return response;
  }

//===================================Update=====================================
  updateData(String sql) async {
    Database? myDB = await db;
    int response = await myDB!.rawUpdate(sql);
    return response;
  }

//===================================Insert=====================================
  insertData(String sql) async {
    Database? myDB = await db;
    int response = await myDB!.rawInsert(sql);
    return response;
  }

//==============================Delete Database=================================
  deleteDB() async {
    var databasePath = await getDatabasesPath();
    String path = join(databasePath, AppStrings.dataBaseName);
    return deleteDatabase(path);
  }

//==============================================================================
//=============================Shortcuts Methods================================
//===================================Select=====================================
  readDataShortcut(String table) async {
    Database? myDB = await db;
    List<Map> response = await myDB!.query(table);
    return response;
  }

//===================================Delete=====================================
  deleteDataShortcut({required String table, required String id}) async {
    Database? myDB = await db;
    int response = await myDB!.delete(table, where: id);
    return response;
  }

//===================================Update=====================================
  updateDataShortcut({
    required String table,
    required Map<String, Object> values,
    required String id,
  }) async {
    Database? myDB = await db;
    int response = await myDB!.update(table, values, where: id);
    return response;
  }

//===================================Insert=====================================
  insertDataShortcut(String table, Map<String, Object> values) async {
    Database? myDB = await db;
    int response = await myDB!.insert(table, values);
    return response;
  }
//==============================================================================
//==============================================================================
//==============================================================================
//==============================================================================
//==============================================================================
}
