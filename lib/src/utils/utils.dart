import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:sqlite/src/models/scan_model.dart';

launchURL( BuildContext context, ScanModel scan) async {
  const url = 'https://flutter.dev';
  switch (scan.tipo) {
    case 'http':
      if (await canLaunch(scan.valor)) {
        await launch(scan.valor);
      } else {
        throw 'Could not launch ${scan.valor}';
      }
      break;
    case 'geo':
    default:
      Navigator.pushNamed(context, 'map', arguments: scan);
  }

  
}
