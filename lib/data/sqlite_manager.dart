import 'package:path/path.dart';
import 'package:repaso_flutter/data/conversion_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Gestiona la conexión con la base de datos
///
/// En este caso utiliza sqflite_common_ffi, por lo que tiene soporte para
/// windows, mac y linux, pero no para android e ios.
abstract class SqliteManager {
  /// @nodoc
  static Database? _db;

  /// Devuelve una conexión a la base de datos
  ///
  /// Utiliza singleton, por lo que si no existe una conexión previa
  /// se crea una, pero si ya había una, se devuelve la misma.
  static Future<Database> getConnection() async {
    if (_db == null || !_db!.isOpen) return await _createConnection();
    return _db!;
  }

  /// @nodoc
  static Future<Database> _createConnection() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    final dbPath = join(await getDatabasesPath(), "conversor.db");
    _db = await databaseFactory.openDatabase(dbPath, options: OpenDatabaseOptions(
      version: 1,
      onCreate: (db, version) {
        ConversionService.createDDL(db);
      }
    ));
    return _db!;
  }
}