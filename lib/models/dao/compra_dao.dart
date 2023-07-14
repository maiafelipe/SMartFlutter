import 'package:smart/models/compra.dart';
import 'package:smart/services/database.dart';
import 'package:sqflite/sqflite.dart';

class CompraDAO {
  static const String tableCompra =
      "CREATE TABLE compra(id INTEGER PRIMARY KEY AUTOINCREMENT, descricao TEXT, local TEXT, status TEXT)";

  static Future<int> insertCompra(Compra compra) async {
    DBProvider dbp = DBProvider.getInstance();
    Database db = await dbp.database;
    int id = await db.insert(
      'compra',
      compra.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return id;
  }

  static Future<List<Compra>> selectAllCompras() async {
    DBProvider dbp = DBProvider.getInstance();
    Database db = await dbp.database;
    final List<Map<String, dynamic>> maps = await db.query('compra');
    return List.generate(maps.length, (i) {
      return Compra(
        maps[i]["descricao"],
        maps[i]["local"],
        id: maps[i]["id"],
      );
    });
  }

  static Future<void> deleteCompra(int id) async {
    DBProvider dbp = DBProvider.getInstance();
    Database db = await dbp.database;
    await db.delete(
      'compra',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
