import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqlite/src/models/scan_model.dart';
export 'package:sqlite/src/models/scan_model.dart';

class DBProvider {
  static Database _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDB();
    }

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final String path = join( documentsDirectory.path, 'ScansDB.db' );

    

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){ },
      onCreate: _onCreate
    );

  }

  _onCreate(Database db, int version) async {
    try {
      await db.execute(
          'CREATE TABLE Scans('
          ' id INTEGER PRIMARY KEY,'
          ' tipo TEXT,'
          ' valor TEXT'
          ')'
        );
    } catch (e) {
      throw e;
    }
  }

  nuevoScanRaw( ScanModel nuevoScan) async {
    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO Scans(id, tipo, valor) "
      "VALUES ( ${ nuevoScan.id } , '${ nuevoScan.tipo }' , '${ nuevoScan.valor }' )"
    );

    return res;
  }

  nuevoScan ( ScanModel nuevoScan ) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    return res;
  }

  // SELECT
  Future<ScanModel> getScanId(int id) async{
    final db = await database;
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans () async {
    final db = await database;
    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty ? res.map(
      (c) => ScanModel.fromJson(c)
    ).toList() : [];

    return list;

  }

  Future<List<ScanModel>> getScansByTipo (String tipo) async {
    final db = await database;
    final res = await db.query('Scans', where: 'tipo=?', whereArgs: [tipo]);

    List<ScanModel> list = res.isNotEmpty ? res.map(
      (c) => ScanModel.fromJson(c)
    ).toList() : [];

    return list;

  }

  //UPDATE
  Future<int> updateScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.update(
      'Scans',
      nuevoScan.toJson(),
      where: 'id=?',
      whereArgs: [nuevoScan.id]
      );
    return res;
  }

  //DELETE
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete(
      'Scans',
      where: 'id=?',
      whereArgs: [id]
    );
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.delete('Scans');
    return res;
  }

}
