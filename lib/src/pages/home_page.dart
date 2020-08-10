import 'package:flutter/material.dart';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:sqlite/src/bloc/scans_bloc.dart';

import 'package:sqlite/src/pages/direcciones_page.dart';
import 'package:sqlite/src/pages/mapas_page.dart';
import 'package:sqlite/src/providers/db_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final scansBloc = new ScansBloc();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLite simple"),
        actions: <Widget>[
          IconButton(icon: Icon( Icons.delete_forever ), onPressed: scansBloc.deleteAllScans)
        ],
      ),
      body: _callPage(currentIndex),
      bottomNavigationBar: _crearBottonNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: _scanQR,
        child: Icon(Icons.filter_center_focus),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _crearBottonNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text("Mapas")
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.brightness_5),
          title: Text("Direcciones")
          )
      ],
    );
  }

  _scanQR() async {

    // https://translate.google.com/
    // geo:6.377462919931003,-75.44612660845645
    String futureString = '';

    try {
      futureString = await BarcodeScanner.scan();
    } catch (e) {
      futureString = e.toString();
    }

    try {
      if( futureString != null ) {
        final scan = ScanModel(
          valor: futureString
        );
        scansBloc.addScan(scan);
      }
    } catch (e) {
      print(e);
    }

  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
        case 1:
        return DireccionesPage();
      default:
      return MapasPage();
    }
  }

}