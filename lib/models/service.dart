import 'package:zikirmatik/models/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ZikirService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    String path = join(await getDatabasesPath(), 'zikir2.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE zikirler(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nameLatin TEXT,
            nameArabic TEXT,
            currentCount INTEGER,
            totalCount INTEGER,
            forgiven TEXT
          )
        ''');
      },
    );
  }

  Future<bool> insertZikir(Zikir zikir) async {
    try {
      final db = await database;
      await db.insert('zikirler', zikir.toMap(),
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
      return Zikir.fromMap(maps[i]);
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
