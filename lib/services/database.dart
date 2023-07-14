import 'package:smart/models/dao/compra_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static DBProvider? _db;
  DBProvider._();

  static DBProvider getInstance() {
    return _db ??= DBProvider._();
  }

  late Database _database;
  bool ensureInitialized = false;

  Future<Database> get database async {
    if (!ensureInitialized) {
      _database = await initDB();
      ensureInitialized = true;
    }
    return _database;
  }

  Future<Database> initDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'smart_database.db'),
      onCreate: (db, version) {
        return db.execute(
          CompraDAO.tableCompra,
        );
      },
      version: 10,
    );
  }
}
