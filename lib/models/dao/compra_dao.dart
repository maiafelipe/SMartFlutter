import 'package:flutter/foundation.dart';
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
        status: maps[i]["status"] == describeEnum(CompraStatus.disable)
            ? CompraStatus.disable
            : CompraStatus.active,
      );
    });
  }

  static Future<Compra?> selectCompra(int id) async {
    DBProvider dbp = DBProvider.getInstance();
    Database db = await dbp.database;
    final List<Map<String, dynamic>> maps = await db.query(
      "compra",
      where: "id=?",
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return Compra(
        maps.first["descricao"],
        maps.first["local"],
        id: maps.first["id"],
        status: maps.first["status"] == describeEnum(CompraStatus.disable)
            ? CompraStatus.disable
            : CompraStatus.active,
      );
    }
    return null;
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

  static Future<int> updateCompra(Compra compra) async {
    DBProvider dbp = DBProvider.getInstance();
    Database db = await dbp.database;
    int id = await db.update(
      'compra',
      compra.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: 'id = ?',
      whereArgs: [compra.id],
    );
    return id;
  }
}
