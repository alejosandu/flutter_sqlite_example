import 'package:flutter/material.dart';
import 'package:sqlite/src/pages/home_page.dart';
import 'package:sqlite/src/pages/mapa_page.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => HomePage(),
  "map": (BuildContext context) => MapaPage()
};