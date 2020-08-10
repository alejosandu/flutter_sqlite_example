

import 'dart:async';

import 'package:sqlite/src/providers/db_provider.dart';

class ScansBloc {
  static final ScansBloc _singleton = new ScansBloc._internal();

  factory ScansBloc (){
    return _singleton;
  }

  ScansBloc._internal() {
    // Obtener scans de la base de datos
    getAllScans();
  }

  final _scansController = StreamController<List<ScanModel>>.broadcast();

  Stream<List<ScanModel>> get scansStream => _scansController.stream;
  // Stream<List<ScanModel>> get scansStream => _scansController.stream;

  dispose() {
    _scansController?.close();
  }

  getAllScans () async {
    _scansController.sink.add( await DBProvider.db.getAllScans() );
  }

  getScansByType (String tipo) async {
    _scansController.sink.add( await DBProvider.db.getScansByTipo(tipo) );
  }

  addScan ( ScanModel scan) async {
    await DBProvider.db.nuevoScan(scan);
    getAllScans();
  }

  deleteScan (int id) async {
    await DBProvider.db.deleteScan(id);
    getAllScans();
  }

  deleteAllScans() async {
    await DBProvider.db.deleteAll();
    getAllScans();
  }

}