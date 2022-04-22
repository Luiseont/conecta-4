import 'package:conecta/src/pages/partials/point_widget.dart';
import 'package:flutter/material.dart';

class GameOn extends StatefulWidget {
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

  List<List> tab = [
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];

  void onTap(x, y) => setState(() {
        tab[x].add(currentTurn);
        currentTurn = (currentTurn == 1) ? 2 : 1;
        print(tab);
      });

  Widget renderTablero() {
    return SizedBox(
      height: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          for (var rows = 0; rows < 7; rows++)
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var cols = 0; cols < 6; cols++) points(rows, cols)
              ],
            )
        ],
      ),
    );
  }

  Widget points(x, y) {
    return GestureDetector(
        onTap: () {
          if (tab[x].length <= 5) {
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

  Color getColor(x, y) {
    return ((tab[x].isEmpty))
        ? Colors.grey
        : (tab[x][y] == 1)
            ? player1
            : player2;
  }

  Widget botones() {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: ButtonBar(
        alignment: MainAxisAlignment.center,
        children: [
          TextButton(
              style: TextButton.styleFrom(
                  fixedSize: const Size(150, 50),
                  backgroundColor: const Color.fromRGBO(0, 200, 242, 0.80)),
              onPressed: () => setState(() {
                    tab = [
                      [],
                      [],
                      [],
                      [],
                      [],
                      [],
                      [],
                    ];
                  }),
              child: const Text("Reiniciar partida",
                  style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)))),
          TextButton(
              style: TextButton.styleFrom(
                  fixedSize: const Size(150, 50),
                  backgroundColor: const Color.fromRGBO(68, 128, 138, 1)),
              onPressed: () => setState(() {
                    scores['Player1'] = 0;
                    scores['Player2'] = 0;
                  }),
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
          width: 150,
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
            width: 150,
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
