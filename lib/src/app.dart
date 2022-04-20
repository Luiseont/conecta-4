import 'package:flutter/material.dart';
import 'package:conecta/src/utils/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Conecta 4",
      initialRoute: '/',
      routes: appRoutes(),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            builder: (BuildContext build) => defaultRoute());
      },
    );
  }
}
