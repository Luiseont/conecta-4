import "package:flutter/material.dart";

class PointWidget extends StatefulWidget {
  int turn;
  Color player1;
  Color player2;
  final Function callback;

  PointWidget(
      {Key? key,
      required this.turn,
      required this.player1,
      required this.player2,
      required this.callback})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PointWidgget();
  }
}

class _PointWidgget extends State<PointWidget> {
  var key = UniqueKey();
  int playerTap = 0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        key: key,
        onTap: () {
          if (playerTap == 0) {
            setState(() {
              playerTap = widget.turn;
              widget.callback();
            });
          }
        },
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          child: Container(
              width: 40,
              height: 40,
              color: (((playerTap == 0)
                  ? Colors.grey
                  : (playerTap == 1)
                      ? widget.player1
                      : widget.player2))),
        ));
  }
}
