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
  static const String tableCompra = "compra";
  static const String columnId = "id_compra";
  static const String columnDescricao = "descricao";
  static const String columnLocal = "local";
  static const String columnStatus = "status";

  /// Comando SQL para criação da tabela compra.
  static const String compraCreateSQL =
      "CREATE TABLE $tableCompra($columnId INTEGER PRIMARY KEY AUTOINCREMENT, $columnDescricao TEXT, $columnLocal TEXT, $columnStatus TEXT)";
  
  static const String compraDropSQL =
      "DROP TABLE IF EXISTS $tableCompra";

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
      tableCompra,
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
    final List<Map<String, dynamic>> maps = await db.query(tableCompra);
    return List.generate(maps.length, (i) {
      return Compra(
        maps[i][columnDescricao],
        maps[i][columnLocal],
        id: maps[i][columnId],
        status: maps[i][columnStatus] == describeEnum(CompraStatus.disable)
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
      tableCompra,
      where: "$columnId=?",
      whereArgs: [id],
      limit: 1,
    );
    if (maps.isNotEmpty) {
      return Compra(
        maps.first[columnDescricao],
        maps.first[columnLocal],
        id: maps.first[columnId],
        status: maps.first[columnStatus] == describeEnum(CompraStatus.disable)
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
      tableCompra,
      where: '$columnId = ?',
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
      tableCompra,
      compra.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
      where: '$columnId = ?',
      whereArgs: [compra.id],
    );
    return count;
  }
}
