import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Zikir {
  int id;
  String nameLatin;
  String nameArabic;
  int currentCount;
  int totalCount;
  List<String> forgiven;

  Zikir({
    required this.id,
    required this.nameLatin,
    required this.nameArabic,
    required this.currentCount,
    required this.totalCount,
    required this.forgiven,
  });

  Map<String, dynamic> toMap() {
    return {
      'nameLatin': nameLatin,
      'nameArabic': nameArabic,
      'currentCount': currentCount,
      'totalCount': totalCount,
      'forgiven': forgiven == [] ? '' : forgiven.join(','),
    };
  }

  static Zikir fromMap(Map<String, dynamic> map) {
    return Zikir(
      id: map['id'],
      nameLatin: map['nameLatin'],
      nameArabic: map['nameArabic'],
      currentCount: map['currentCount'],
      totalCount: map['totalCount'],
      //forgiven boşsa boş bir liste döndürüyor
      forgiven: map['forgiven'] == '' ? [] : map['forgiven'].split(','),
    );
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
