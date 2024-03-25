import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictacto/comp/tiles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> tiles = List.filled(9, 0);
  List<double> width = List.filled(9, 0);
  int turn = 0, wins = 0, los = 0;

  bool playable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Tic-Tac-Toe",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueGrey),
                )),
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue), color: Colors.white),
              padding: const EdgeInsets.all(20),
              child: AspectRatio(
                aspectRatio: 1,
                child: GridView.count(
                  crossAxisCount: 3,
                  children: [
                    for (var i = 0; i < 9; i++)
                      InkWell(
                        onTap: () {
                          if (tiles[i] == 0 && playable) {
                            setState(() {
                              tiles[i] = 1;
                              width[i] = 120;
                              if (isWinning(1, tiles)) {
                                wins++;
                                playable = false;
                              } else {
                                runAi(tiles);
                              }
                            });
                          }
                        },
                        child: TilesView(tlist: tiles, pos: i, sizW: width),
                      )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            isWinning(1, tiles)
                ? Text("You Won!", style: tsty(Colors.green))
                : isWinning(2, tiles)
                    ? Text("Your Lost!", style: tsty(Colors.red))
                    : (checkDone(tiles))
                        ? Text('Your Move', style: tsty(Colors.blue))
                        : Text('Retury', style: tsty(Colors.cyanAccent)),
            const SizedBox(height: 50),
            Text("Played: $turn, Win: $wins, Los: $los",
                style: tsty(Colors.blueGrey)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            turn++;
            tiles = List.filled(9, 0);
            width = List.filled(9, 0);
            if (turn % 2 != 0) randomMove(tiles);
            playable = true;
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.replay_outlined),
      ),
    );
  }

  TextStyle tsty(Color clr) => TextStyle(fontSize: 30, color: clr);

  bool checkDone(List<int> til) {
    bool done = til.any((element) => element == 0);
    return done;
  }

  void randomMove(List<int> til) async {
    int num = Random().nextInt(9);
    tiles[num] = 2;
    width[num] = 120;
  }

  void runAi(List<int> til) async {
    await Future.delayed(const Duration(milliseconds: 500));
    int? winning;
    int? blocking;
    int? normal;
    for (var i = 0; i < 9; i++) {
      var val = til[i];
      if (val > 0) {
        continue;
      }
      var future = [...til]..[i] = 2;
      if (isWinning(2, future)) {
        winning = i;
      }
      future[i] = 1;
      if (isWinning(1, future)) {
        blocking = i;
      }
      normal = i;
    }
    var move = winning ?? blocking ?? normal;
    if (move != null) {
      setState(() {
        til[move] = 2;
        width[move] = 120;

        if (isWinning(2, til)) {
          los++;
          playable = false;
        }
      });
    }
  }

  int chekTrue(int ply, List<int> til) {
    int res = -1;
    if (til[0] == ply && til[1] == ply && til[2] == ply) res = 0;
    if (til[3] == ply && til[4] == ply && til[5] == ply) res = 1;
    if (til[6] == ply && til[7] == ply && til[8] == ply) res = 2;
    if (til[0] == ply && til[3] == ply && til[6] == ply) res = 3;
    if (til[1] == ply && til[4] == ply && til[7] == ply) res = 4;
    if (til[2] == ply && til[5] == ply && til[8] == ply) res = 5;
    if (til[0] == ply && til[4] == ply && til[8] == ply) res = 6;
    if (til[6] == ply && til[4] == ply && til[2] == ply) res = 7;
    return res;
  }

  List<int> getPint(int num) {
    List<List<int>> res = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [6, 4, 2]
    ];
    return res[num];
  }

  bool isWinning(int val, List<int> til) {
    return chekTrue(val, til) >= 0 ? true : false;
  }
}
