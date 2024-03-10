import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Zikir {
  int id;
  String nameLatin;
  String nameArabic;
  int currentCount;
  int totalCount;

  Zikir({
    required this.id,
    required this.nameLatin,
    required this.nameArabic,
    required this.currentCount,
    required this.totalCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameLatin': nameLatin,
      'nameArabic': nameArabic,
      'currentCount': currentCount,
      'totalCount': totalCount,
    };
  }

  static Zikir fromMap(Map<String, dynamic> map) {
    return Zikir(
      id: map['id'],
      nameLatin: map['nameLatin'],
      nameArabic: map['nameArabic'],
      currentCount: map['currentCount'],
      totalCount: map['totalCount'],
    );
  }
}

class ZikirDatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  _initDB() async {
    String path = join(await getDatabasesPath(), 'zikir.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE zikirler(
            id INTEGER PRIMARY KEY,
            nameLatin TEXT,
            nameArabic TEXT,
            currentCount INTEGER,
            totalCount INTEGER
          )
        ''');
      },
    );
  }

  Future<void> ekle(Zikir zikir) async {
    final db = await database;
    await db.insert('zikirler', zikir.toMap());
  }

  Future<void> sil(int id) async {
    final db = await database;
    await db.delete('zikirler', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> guncelle(Zikir zikir) async {
    final db = await database;
    await db.update('zikirler', zikir.toMap(),
        where: 'id = ?', whereArgs: [zikir.id]);
  }

  Future<List<Zikir>> getZikirler() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('zikirler');

    return List.generate(maps.length, (i) {
      return Zikir.fromMap(maps[i]);
    });
  }
}

class Dua {
  int id;
  String nameLatin;
  String nameArabic;
  String dua;
  Dua({
    required this.id,
    required this.nameLatin,
    required this.nameArabic,
    required this.dua,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameLatin': nameLatin,
      'nameArabic': nameArabic,
      'dua': dua,
    };
  }

  static Dua fromMap(Map<String, dynamic> map) {
    return Dua(
      id: map['id'],
      nameLatin: map['nameLatin'],
      nameArabic: map['nameArabic'],
      dua: map['dua'],
    );
  }
}
