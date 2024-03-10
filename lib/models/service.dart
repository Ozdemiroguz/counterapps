import 'package:zikirmatik/models/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ZikirService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    String path = join(await getDatabasesPath(), 'zikir.db');
    return openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE zikirler(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          nameLatin TEXT,
          nameArabic TEXT,
          currentCount INTEGER,
          totalCount INTEGER
        )
      ''');
    });
  }

  Future<bool> insertZikir(Zikir zikir) async {
    try {
      final db = await database;
      Map<String, dynamic> zikirMap = zikir.toMap();
      zikirMap.remove('id');
      await db.insert('zikirler', zikirMap,
          conflictAlgorithm: ConflictAlgorithm.replace);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Zikir>> getZikirler() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('zikirler');
    return List.generate(maps.length, (i) {
      return Zikir(
        id: maps[i]['id'],
        nameLatin: maps[i]['nameLatin'],
        nameArabic: maps[i]['nameArabic'],
        currentCount: maps[i]['currentCount'],
        totalCount: maps[i]['totalCount'],
      );
    });
  }

  Future<bool> updateZikir(Zikir zikir) async {
    try {
      final db = await database;
      await db.update('zikirler', zikir.toMap(),
          where: 'id = ?', whereArgs: [zikir.id]);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteZikir(int id) async {
    try {
      final db = await database;
      await db.delete('zikirler', where: 'id = ?', whereArgs: [id]);
      return true;
    } catch (e) {
      return false;
    }
  }
}
