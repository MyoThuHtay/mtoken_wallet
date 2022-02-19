import 'package:mtoken_wallet/models/wallet_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class WalletDatabase {
  static final WalletDatabase instance = WalletDatabase._init();

  static Database? _database;
  WalletDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('wallets.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
CREATE TABLE $walletTables ( 
  ${WalletFields.id} $idType,
  ${WalletFields.isCreated} $boolType, 
  ${WalletFields.wallets} $textType,
  ${WalletFields.private} $textType,
  ${WalletFields.public} $textType,
  ${WalletFields.phrase} $textType,
  ${WalletFields.xpud} $textType
  )
''');

  }

  Future<Wallets> create(Wallets wallet) async {
    final db = await instance.database;
    final id = await db.insert(walletTables, wallet.toJson(),conflictAlgorithm: ConflictAlgorithm.replace);
    return wallet.copy(id: id);
  }

  Future<Wallets> readWallet(String? public) async {
    final db = await instance.database;

    final maps = await db.query(
      walletTables,
      columns: WalletFields.values,
      where: ' ${WalletFields.public} = ?',
      whereArgs: [public],
    );
    if (maps.isNotEmpty) {
      return Wallets.fromJson(maps.first);
    } else {
      throw Exception('ID $public NOT FOUND');
    }
  }

  Future<List<Wallets>> readAllWallets() async {
    final db = await instance.database;
    const orderBy = '${WalletFields.id} ASC';
    final result = await db.query(walletTables, orderBy: orderBy);

    return result.map((json) => Wallets.fromJson(json)).toList();
  }

  Future<int> update(Wallets wallet) async {
    final db = await instance.database;
    return db.update(walletTables, wallet.toJson(),conflictAlgorithm: ConflictAlgorithm.replace,
        where: '${WalletFields.id} = ?', whereArgs: [wallet.id]);
  }

  Future<int> delete(int? id) async {
    final db = await instance.database;
    return await db
        .delete(walletTables, where: '${WalletFields.id} = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }


}
