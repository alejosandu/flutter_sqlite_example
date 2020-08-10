import 'package:flutter/material.dart';

// import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:sqlite/src/models/scan_model.dart';


class MapaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final ScanModel scan = ModalRoute.of(context).settings.arguments; 

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: (){},
          )
        ],
      ),
      body: _crearFlutterMap(scan)
    );
  }

  Widget _crearFlutterMap( ScanModel scan ) {

    return Center(
      child: Text(scan.valor),
    );

    // FlutterMap(options: null)

    // return FlutterMap(
    //   options: MapOptions(
    //     center: scan.getLatLng(),
    //     zoom: 10
    //   ),
    //   layers: [
    //     _crearMapa(),
    //   ],
    // );

  }

  _crearMapa() {

    // return TileLayerOptions(
    //   urlTemplate: 'https://api.mapbox.com/v4/'
    //   '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
    //   additionalOptions: {
    //     'accessToken': 'pk.eyJ1IjoiYWxlam9zYW5kdSIsImEiOiJja2IxZXUzNnYwa2RhMnRzNXhqOWt2YXBpIn0.wkySbZPkp1K5MkMiHuRY6Q',
    //     'id': 'mapbox.streets'
    //   }
    // );


  }

}
