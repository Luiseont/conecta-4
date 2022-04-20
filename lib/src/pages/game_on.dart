import 'package:flutter/material.dart';

class GameOn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GameOn();
  }
}

class _GameOn extends State<GameOn> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: const Text('game on'),
      ),
    );
  }
}
