import 'package:repaso_flutter/data/sqlite_manager.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../domain/conversion.dart';

/// Gestiona la interacción con la base de datos.
///
/// Se pueden realizar operaciones CRUD como las siguientes:
/// * [createDDL()]
/// * [getAll()]
/// * [insert()]
abstract class ConversionService {
  static const String _table = "conversions";

  /// Crea la tabla de conversiones si no existe.
  ///
  /// * [Database db] en la que se realiza la operación.
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

  /// Obtiene todas las conversiones
  ///
  /// Si no hay ninguna, se devuelve una lista vacía.
  static Future<List<Conversion>> getAll() async {
    final List<Conversion> conversions = [];
    final db = await SqliteManager.getConnection();
    final results = await db.query(_table);
    for (Map<String, Object?> result in results) {
      conversions.add(Conversion.fromMap(result));
    }

    return conversions;
  }

  /// Inserta una conversión en la base de datos,
  ///
  /// Devuelve el id generado, si es menor o igual a 0 significa que no
  /// se ha podido realizar la operación con éxito.
  static Future<int> insert(Conversion conversion) async {
    final db = await SqliteManager.getConnection();
    return await db.insert(_table, conversion.toMap());
  }

  /// Elimina una conversión de la base de datos.
  ///
  /// Se elimina un registro en función de su [id]
  /// Devuelve un `bool` con el resultado de la operación.
  static Future<bool> delete(int id) async {
    final db = await SqliteManager.getConnection();
    return await db.delete(_table, where: "id = ?", whereArgs: [id]) > 0;
  }
}