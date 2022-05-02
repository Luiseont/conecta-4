import 'dart:math';

import 'package:flutter/material.dart';

class GameOn extends StatefulWidget {
  const GameOn({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _GameOn();
  }
}

class _GameOn extends State<GameOn> {
  //Contadores para el puntaje
  Map scores = {'Player1': 0, 'Player2': 0};

  //colores de los jugadores.
  Color player1 = Colors.red;
  Color player2 = Colors.yellow;

  //Controla el jugador tiene el turno actual.
  int currentTurn = 1;

  //Variables para determinar tamanio del tablero
  final int ejeX = 6;
  final int ejeY = 7;

  //tablero de juego.
  Map<int, Map<int, int>> tab = {};

  // funciones core;
  void onTap(x, y) => setState(() {
        var index = tab[x]
            ?.entries
            .firstWhere((element) => (element.value == 0) ? true : false);
        tab[x]?[index!.key] = currentTurn;
        checkWinner();
      });

  void reiniciaTablero() => setState(() {
        tab = {
          0: {5: 0, 4: 0, 3: 0, 2: 0, 1: 0, 0: 0},
          1: {5: 0, 4: 0, 3: 0, 2: 0, 1: 0, 0: 0},
          2: {5: 0, 4: 0, 3: 0, 2: 0, 1: 0, 0: 0},
          3: {5: 0, 4: 0, 3: 0, 2: 0, 1: 0, 0: 0},
          4: {5: 0, 4: 0, 3: 0, 2: 0, 1: 0, 0: 0},
          5: {5: 0, 4: 0, 3: 0, 2: 0, 1: 0, 0: 0},
          6: {5: 0, 4: 0, 3: 0, 2: 0, 1: 0, 0: 0},
        };
        currentTurn = 1;
      });

  void reiniciaMarcador() => setState(() {
        scores['Player1'] = 0;
        scores['Player2'] = 0;
      });

  void checkWinner() {
    if (checkY() || checkX()) {
      String winner = (currentTurn == 1) ? 'Player1' : 'Player2';
      scores[winner]++;
      reiniciaTablero();
    } else if (checkTie()) {
      reiniciaTablero();
    } else {
      currentTurn = (currentTurn == 1) ? 2 : 1;
    }
  }

  //fin funciones core

  //funciones aux

  Color getColor(x, y) {
    return (tab[x]?[y] == 0)
        ? Colors.grey
        : (tab[x]?[y] == 1)
            ? player1
            : player2;
  }

  bool checkTie() {
    return false;
  }

  bool checkY() {
    bool win = false;
    for (int y = 0; y < ejeY; y++) {
      var result = tab[y]
          ?.entries
          .toList()
          .where((element) => (element.value == currentTurn) ? true : false);

      //print("resultado de la line $y = $result");
      if (result?.length == 4) {
        win = validaContinuidad(result);
        break;
      }
    }

    return win;
  }

  bool checkX() {
    bool win = false;

    for (int x = ejeX - 1; x > 0; x--) {
      Map<int, int> currnet = {};
      for (int y = 0; y < ejeY; y++) {
        if (tab[y]?[x] == currentTurn) {
          currnet.addEntries({y: x}.entries);
        }
        //print("coordenada $y - $x valor: ${tab[y]?[x]}");
      }
      if (currnet.length == 4) {
        win = validaContinuidad(currnet.entries);
        break;
      }
    }

    return win;
  }

  bool validaContinuidad(Iterable<MapEntry<int, int>>? toValidate) {
    int count = 0;

    toValidate?.forEach((element) {
      int prev = element.key - 1;
      if (prev - element.key == 1 || prev - element.key == -1) {
        count++;
      }
    });

    return (count == 4) ? true : false;
  }

  // funiones render
  Widget renderTablero() {
    return SizedBox(
      height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var rows = 0; rows < ejeY; rows++)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var cols = 0; cols < ejeX; cols++) points(rows, cols)
              ],
            )
        ],
      ),
    );
  }

  Widget points(x, y) {
    return GestureDetector(
        onTap: () {
          if (tab[x]?[y] == 0) {
            onTap(x, y);
          }
        },
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            child: Container(
              width: 40,
              height: 40,
              color: getColor(x, y),
            )));
  }

  Widget botones() {
    return Padding(
      padding: const EdgeInsets.only(top: 55),
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          TextButton(
              style: TextButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.45, 40),
                  backgroundColor: const Color.fromRGBO(0, 200, 242, 0.80)),
              onPressed: () => reiniciaTablero(),
              child: const Text("Reiniciar partida",
                  style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)))),
          TextButton(
              style: TextButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.45, 40),
                  backgroundColor: const Color.fromRGBO(68, 128, 138, 1)),
              onPressed: () => reiniciaMarcador(),
              child: const Text("Reinicia contador",
                  style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)))),
        ],
      ),
    );
  }

  Widget marcador() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          decoration: BoxDecoration(
              color: (currentTurn == 1)
                  ? Colors.red
                  : const Color.fromARGB(255, 115, 32, 26),
              borderRadius:
                  const BorderRadius.horizontal(left: Radius.circular(20))),
          width: 200,
          height: 60,
          child: Center(
            child: Text(
              '${scores['Player1']}',
              style: const TextStyle(fontSize: 30),
            ),
          ),
        ),
        Container(
            decoration: BoxDecoration(
                color: (currentTurn == 2)
                    ? Colors.yellow
                    : const Color.fromARGB(255, 134, 124, 28),
                borderRadius:
                    const BorderRadius.horizontal(right: Radius.circular(20))),
            width: 200,
            height: 60,
            child: Center(
              child: Text(
                '${scores['Player2']}',
                style: const TextStyle(fontSize: 30, color: Colors.black),
              ),
            ))
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    reiniciaTablero();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 16, 113, 66),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Column(
                children: [marcador()],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: Column(
                children: [renderTablero()],
              ),
            ),
            Column(
              children: [botones()],
            )
          ],
        ),
      ),
    );
  }
}
