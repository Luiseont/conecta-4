import 'package:flutter/widgets.dart';
import 'package:conecta/src/pages/home.dart';
import 'package:conecta/src/pages/game_on.dart';

Map<String, WidgetBuilder> appRoutes() {
  return {
    '/': (BuildContext context) => Home(),
    'start': (BuildContext context) => GameOn()
  };
}

Widget defaultRoute() {
  return Home();
}
