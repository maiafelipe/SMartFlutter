import 'package:flutter/foundation.dart';
import 'package:smart/models/compra.dart';
import 'package:smart/services/database.dart';
import 'package:sqflite/sqflite.dart';

/// Classe [CompraDAO].
///
/// Contem uma coleção de operações e constantes para facilitar comunição com banco de dados envolvimento o modelo [Compra].
/// 
/// Todas essas constantes e operações devem ser acessadas sem instanciar essa classe, são static.
/// 
/// Talvez desse para deixar fora de uma classe, mas sou programador Java, paciência.
///
/// Autor Felipe.
class CompraDAO {
  /// Comando SQL para criação da tabela compra.
  static const String tableCompra =
      "CREATE TABLE compra(id INTEGER PRIMARY KEY AUTOINCREMENT, descricao TEXT, local TEXT, status TEXT)";

  /// Operação de inserir uma compra no banco.
  /// Recebe a [compra] como um parâmetro e retorna o id que a compra receberá na inserção.
  /// O atributo [compra.id] deve ser nulo para que a compra receba um id automaticamente pelo banco.
  /// O id será embalado em um [Future] isso quer dizer que quem receber deverá esperar a conclusão da operação para poder utiliza-lo.
  /// ```dart
  /// Future<int> id = CompraDAO.insertCompra(compra);
  /// id.then((value) {
  ///    compra.id = value;
  /// });
  /// ```
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

  /// Operação seleção para todas as compras no banco.
  /// Não possui parâmetros de entrada.
  /// Retorna uma [List] embalada em um [Future] com todas as compras.
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

  /// Operação seleção para uma compra específica no banco.
  /// Recebe o [id] que será um [int] para o identificador da compra desejada.
  /// Retorna uma [Compra] embalada em um [Future] que pode ser nula caso não encontre a compra com o [id] desejado.
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

  /// Operação deleção para uma compra específica no banco.
  /// Recebe o [id] que será um [int] para o identificador da compra desejada.
  /// Retorna um [Future] vazio.
  static Future<void> deleteCompra(int id) async {
    DBProvider dbp = DBProvider.getInstance();
    Database db = await dbp.database;
    await db.delete(
      'compra',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Operação de atualização para uma compra específica no banco.
  /// Recebe uma [compra] que será atualizada.
  /// Atualiza apenas a compra com o [compra.id] especificado.
  /// Retorna um [int] embalado em um [Future] com a contagem de modificações.
  static Future<int> updateCompra(Compra compra) async {
    DBProvider dbp = DBProvider.getInstance();
    Database db = await dbp.database;
    int count = await db.update(
      'compra',
      compra.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: 'id = ?',
      whereArgs: [compra.id],
    );
    return count;
  }
}
