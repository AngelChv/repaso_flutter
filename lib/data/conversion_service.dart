import 'package:repaso_flutter/data/sqlite_manager.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../domain/conversion.dart';

abstract class ConversionService {
  static const String _table = "conversions";

  static createDDL(Database db) {
    db.execute("""
      CREATE TABLE IF NOT EXISTS conversions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        operation TEXT,
        result REAL
      );
      """
    );
  }

  static Future<List<Conversion>> getAll() async {
    final List<Conversion> conversions = [];
    final db = await SqliteManager.getConnection();
    final results = await db.query(_table);
    for (Map<String, Object?> result in results) {
      conversions.add(Conversion.fromMap(result));
    }

    return conversions;
  }

  static Future<bool> insert(Conversion conversion) async {
    final db = await SqliteManager.getConnection();
    return await db.insert(_table, conversion.toMap()) > 0;
  }

  static Future<bool> delete(int id) async {
    final db = await SqliteManager.getConnection();
    return await db.delete(_table, where: "id = ?", whereArgs: [id]) > 0;
  }
}