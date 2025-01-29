import 'package:path/path.dart';
import 'package:repaso_flutter/data/conversion_service.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

abstract class SqliteManager {
  static Database? _db;

  static Future<Database> getConnection() async {
    if (_db == null || !_db!.isOpen) return await _createConnection();
    return _db!;
  }

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