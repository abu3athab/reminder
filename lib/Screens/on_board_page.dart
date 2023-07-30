import 'package:flutter/material.dart';

class OnBoardPage extends StatefulWidget {
  OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              height: 10,
              width: 60,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
            ),
            Container(
              height: 10,
              width: 60,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
            ),
            Container(
              height: 10,
              width: 60,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
            ),
          ],
        )
      ]),
    );
  }
}
