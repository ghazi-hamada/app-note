import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDB {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDB();
      return _db;
    } else {
      return _db;
    }
  }

  Future<Database> intialDB() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, "ghazi.db");
    Database myDB = await openDatabase(path, onCreate: _onCreate, version: 3);
    return myDB;
  }

  // _onUpgrade(Database db, int oldversion, int newversion) async {
  //   print('_onUpgrade===================');
  //   await db.execute("ALTER TABLE notes ADD COLUMN color TEXT");
  // }

  _onCreate(Database db, int cersion) async {
    Batch batch = db.batch();
    batch.execute("""
    CREATE TABLE "notes"(
      "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
      "title" TEXT NOT NULL,
      "note" TEXT NOT NULL,
      "color" TEXT
      )
    """);
    await batch.commit();
    print("onCreate==================================");
  }

  // SELECT
  Future<List<Map<String, Object?>>> redData(String sql) async {
    Database? myda = await db;
    List<Map<String, Object?>> response = await myda!.rawQuery(sql);
    return response;
  }

  // DELETE
  Future<int> daleteData(String sql) async {
    Database? myda = await db;
    int response = await myda!.rawDelete(sql);
    return response;
  }

  // UODATE
  Future<int> updateData(String sql) async {
    Database? myda = await db;
    int response = await myda!.rawUpdate(sql);
    return response;
  }

  // INSERT
  Future<int> insertData(String sql) async {
    Database? myda = await db;
    int response = await myda!.rawInsert(sql);
    return response;
  }

  //DELETE DATABASE
  myDeleteDatabase() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'ghazi.db');
    await deleteDatabase(path);
  }
//==============================================================================

  // SELECT
  Future<List<Map<String, Object?>>> red(String sql) async {
    Database? myda = await db;
    List<Map<String, Object?>> response = await myda!.query(sql);
    return response;
  }

  // DELETE
  Future<int> dalete(
    String sql,
    String? where,
  ) async {
    Database? myda = await db;
    int response = await myda!.delete(sql);
    return response;
  }

  // UODATE
  Future<int> update(
    String sql,
    Map<String, Object?> values,
  ) async {
    Database? myda = await db;
    int response = await myda!.update(sql, values);
    return response;
  }

  // INSERT
  Future<int> insert(String table, Map<String, Object?> values) async {
    Database? myda = await db;
    int response = await myda!.insert(table, values);
    return response;
  }
}
