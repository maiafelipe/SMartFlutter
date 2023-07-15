import 'package:smart/models/dao/compra_dao.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as p;

/// Classe [DBProvider].
///
/// Deverá configuar e manter ligação com recurso de BD em [Sqflite].
///
/// Singleton: pemite a criação de uma única intancia dessa classe.
///
/// Pode deve ser chamada por qualquer DAO que manipule o banco de dados.
///
/// Autor: Felipe.
class DBProvider {
  /// Instância única dessa classe.
  /// Qualquer solicitação de uma nova instância deve retornar esse objeto static.
  /// Pode ser null por conta do ?.
  /// Garante o comportamento Singleton.
  static DBProvider? _db;

  /// Construtor privado para a classe.
  /// Assim não é possível instânciar livremente.
  /// Garante o comportamento Singleton.
  DBProvider._();

  /// Metodo getInstance.
  /// Método que pode ser chamado (sem instanciação) para solicitar uma instância dessa classe.
  /// Caso a instância já exista ela é retornada.
  /// Caso a instância ainda não existe, ela é criada antes.
  /// Garante o comportamento Singleton.
  static DBProvider getInstance() {
    return _db ??= DBProvider._();
  }

  /// Armazena a conexão com o banco de dados.
  /// Não pode ser null, mas pode ser inicializada posteriormente (late).
  late Database _database;

  /// Regista a inicialização do _database.
  /// Quando a inicialização ocorrer, passar para true.
  bool ensureInitialized = false;

  /// Retorna a instância do [Database].
  /// Caso ainda não esteja inicializado, a inicialização deve ocorrer.
  /// Pode demorar, por isso é async.
  /// É necessário esperar pela inicialização para continuar, por isso o await.
  Future<Database> get database async {
    if (!ensureInitialized) {
      _database = await initDB();
      ensureInitialized = true;
    }
    return _database;
  }

  /// Configura toda a inicialização do banco.
  /// É configurado o caminho, o nome e os comportamentos para criação e atualização.
  Future<Database> initDB() async {
    return openDatabase(
      p.join(await getDatabasesPath(), 'smart_database.db'),
      onCreate: (db, version) {
        return db.execute(
          CompraDAO.tableCompra,
        );
      },

      /// TODO: necessário definir comportamento UPGRADE.
      version: 10,
    );
  }
}
