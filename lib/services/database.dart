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

  /// Contem a versão do banco que será utilizada.
  /// Modificar essa variável para cima aciona o comportamento onUpgrade.
  int bdVersion = 13;

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
        return _scriptsCreate(db, version);
      },
      onUpgrade: (db, oldVersion, newVersion) {
        db.execute(CompraDAO.compraDropSQL);
        return _scriptsUpgrade(db, oldVersion, newVersion);
      },
      version: bdVersion,
    );
  }

  /// Scripts para a criação inicial do banco de dados.
  /// O parâmetros [db] carrega a conexão com o banco que será utilizada e [version] a versão do mesmo.
  Future<void> _scriptsCreate(Database db, int version) async{
    return db.execute(CompraDAO.compraCreateSQL);
  }

  /// Scripts para upgrade do banco de dados.
  /// Será executado apenas quando a versão do banco for alterada.
  /// O parâmetros [db] carrega a conexão com o banco que será utilizada.
  /// Os parâmetros [oldVersion] e [newVersion] o controle da versão modificada.
  Future<void> _scriptsUpgrade (Database db, int oldVersion, int newVersion) async {
    await db.execute(CompraDAO.compraDropSQL);
    return db.execute(CompraDAO.compraCreateSQL);
  }
}
