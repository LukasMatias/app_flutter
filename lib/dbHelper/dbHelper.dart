import 'dart:async';
import 'dart:io';
import 'package:loja_virtual/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  String userTable = 'user';
  String colId = 'id';
  String colNome = 'nome';
  String colEmail = 'email';
  String colTel = 'telefone';
  String colEndereco = 'endereco';
  String colCpf = 'cpf';
  String colData = 'data';
  String colCategoria = 'categoria';

  DbHelper._createInstance();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createInstance();
    }
    return _dbHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'user.db';

    var userDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return userDatabase;
  }

  void _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $userTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colNome TEXT, $colEmail TEXT,'
        '$colTel TEXT, $colEndereco TEXT, $colCpf TEXT, $colData TEXT, $colCategoria TEXT)');
  }

  Future<int> insertUser(User user) async {
    Database db = await this.database;

    var result = await db.insert(userTable, user.toMap());

    return result;
  }

  Future<User> getUser(int id) async {
    Database db = await this.database;

    List<Map> maps = await db.query(userTable,
        columns: [colId, colNome, colEmail, colTel, colEndereco, colCpf],
        where: "$colId = ?",
        whereArgs: [id]);

    if (maps.length > 0) {
      return User.FromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateUser(User user) async {
    Database db = await this.database;

    var result = await db.update(userTable, user.toMap(),
        where: '$colId = ?', whereArgs: [user.id]);
    return result;
  }

  Future<int> deleteUser(int id) async {
    Database db = await this.database;

    var result =
        await db.delete(userTable, where: '$colId = ?', whereArgs: [id]);

    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;

    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $userTable');

    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future close() async {
    Database db = await this.database;
    db.close();
  }
}
