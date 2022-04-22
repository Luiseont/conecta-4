import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 200.0),
        color: const Color.fromARGB(255, 16, 113, 66),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const Image(image: AssetImage('assets/logo.png')),
                TextButton(
                  style: TextButton.styleFrom(
                      fixedSize: const Size(150, 50),
                      backgroundColor: const Color.fromRGBO(110, 161, 50, 1)),
                  onPressed: () {
                    Navigator.pushNamed(context, 'start');
                  },
                  child: const Text('Jugar',
                      style: TextStyle(fontSize: 26, color: Colors.white)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
