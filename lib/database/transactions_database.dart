import 'dart:io';

import 'package:expense/models/transaction.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:sqflite/sql.dart';

class TransactionDatabase {
  static const _databaseName = "transactions";
  static const _databaseVersion = 1;

  TransactionDatabase._privateConstructor();
  static final TransactionDatabase db = TransactionDatabase._privateConstructor();
  static sqlite.Database? _database;

  Future<sqlite.Database> get database async {
    return _database ??= await _initDatabase();
  }

  Future<sqlite.Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName + ".db");
    return await sqlite.openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(sqlite.Database db, int version) async {
    await db.execute(
        "CREATE TABLE transactions(id INTEGER PRIMARY KEY, title TEXT, description TEXT, amount REAL, date INTEGER)");
  }

  Future<int> insert(Transaction transaction) async {
    final db = await database;
    return await db.insert(_databaseName, transaction.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Transaction>> transactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_databaseName);

    return List.generate(maps.length, (index) => Transaction.fromMap(maps[index]));
  }
}
