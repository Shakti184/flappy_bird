import 'dart:async';

import 'package:flappy_bird/barrier.dart';
import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdY = 0,a=0.8,b=0.8+0.7,c=0.8+0.7+0.8,d=0.8+0.7+0.8+0.7;
  double initialPos = birdY;
  double height = 0;
  double time = 0;
  double gravity = -8.9;
  double velocity = 4.2;
  double birdWidth = 0.13;
  double birdHeight = 0.13;
  int score = 0;
  int highscore = 0;
  bool gameHasStarted = false;
  
  static List<double> barrierX = [a,b,c,d];
  static double barrierwidth = 0.5;
  List<List<double>> barrierHeight = [
    [0.9, 0.6],
    [0.5, 0.8],
    [0.5, 1.0],
    [1.2, 0.5],
  ];

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      height = gravity * time * time + velocity * time;
      setState(() {
        birdY = initialPos - height;
      });

      setState(() {
        if(barrierX[0]<-1.1){
          barrierX[0]+=3.0;
        }else{
          barrierX[0]-=0.02;
        }
      });

      setState(() {
        if(barrierX[1]<-1.1){
          barrierX[1]+=3.0;
        }else{
          barrierX[1]-=0.02;
        }
      });

      setState(() {
        if(barrierX[2]<-1.1){
          barrierX[2]+=3.0;
        }else{
          barrierX[2]-=0.02;
        }
      });

      setState(() {
        if(barrierX[3]<-1.1){
          barrierX[3]+=3.0;
        }else{
          barrierX[3]-=0.02;
        }
      });

      if (birdIsDead()) {
        timer.cancel();
        gameHasStarted = false;
        _showDialog();
      }

      time += 0.01;
    });
  }

  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 132, 21, 21),
            title: const Center(
              child: Text(
                "G A M E  O V E R",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            content: Text(
              "Score : " + score.toString(),
              style: const TextStyle(color: Colors.white),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding: const EdgeInsets.all(7),
                    color: const Color.fromARGB(255, 14, 0, 0),
                    child: const Text(
                      'PLAY AGAIN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }

  void resetGame() {
    if (score > highscore) {
      highscore = score;
    }
    Navigator.pop(context);
    setState(() {
      birdY = 0;
      gameHasStarted = false;
      time = 0;
      score = 0;
      barrierX[0]=a;
      barrierX[1]=b;
      barrierX[2]=c;
      barrierX[3]=d;
      initialPos = birdY;
    });
  }

  void jump() {
    setState(() {
      time = 0;
      initialPos = birdY;
      score += 1;
    });
  }

  bool birdIsDead() {
    if (birdY < -1 || birdY > 1) {
      return true;
    }
    // for (int i = 0; i < barrierX.length; i++) {
    //   if (barrierX[i] <= birdWidth &&
    //           barrierX[i] + barrierwidth >= -birdWidth &&
    //           (birdY <= -1 + barrierHeight[i][0]) ||
    //       birdY + birdHeight >= 1 - barrierHeight[i][1]) {
    //     return true;
    //   }
    // }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(children: [
          Container(
            height: 15,
            color: const Color.fromARGB(255, 124, 198, 244),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: const Color.fromARGB(255, 62, 161, 243),
              child: Center(
                child: Stack(
                  children: [
                    MyBird(
                      birdY: birdY,
                      birdHeight: birdHeight,
                      birdWidth: birdWidth,
                    ),

                    //MyCoverScreen(gameHasStarted:gameHasStarted),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(
                        barrierHeight: barrierHeight[0][0],
                        barrierWidth: barrierwidth,
                        isThisBottomBarrier: false,
                        barrierX: barrierX[0],
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(
                        barrierHeight: barrierHeight[0][1],
                        barrierWidth: barrierwidth,
                        isThisBottomBarrier: true,
                        barrierX: barrierX[0],
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(
                        barrierHeight: barrierHeight[1][0],
                        barrierWidth: barrierwidth,
                        isThisBottomBarrier: false,
                        barrierX: barrierX[1],
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(
                        barrierHeight: barrierHeight[1][1],
                        barrierWidth: barrierwidth,
                        isThisBottomBarrier: true,
                        barrierX: barrierX[1],
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(
                        barrierHeight: barrierHeight[2][0],
                        barrierWidth: barrierwidth,
                        isThisBottomBarrier: false,
                        barrierX: barrierX[2],
                      ),
                    ),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(
                        barrierHeight: barrierHeight[2][1],
                        barrierWidth: barrierwidth,
                        isThisBottomBarrier: true,
                        barrierX: barrierX[2],
                      ),
                    ),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(
                        barrierHeight: barrierHeight[3][0],
                        barrierWidth: barrierwidth,
                        isThisBottomBarrier: false,
                        barrierX: barrierX[3],
                      ),
                    ),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 0),
                      child: MyBarrier(
                        barrierHeight: barrierHeight[3][1],
                        barrierWidth: barrierwidth,
                        isThisBottomBarrier: true,
                        barrierX: barrierX[3],
                      ),
                    ),

                    Container(
                      alignment: const Alignment(0, -0.5),
                      child: Text(
                        gameHasStarted ? '' : 'T A P  T O  P L A Y',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
              
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Score",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          score.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 40),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Best",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          highscore.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 35),
                        ),
                      ],
                    ),
                    const SizedBox(
                      child:Text("Created by : Shakti_"),
                    ),
                  ],
                ),
            ),
          ),
        ]),
      ),
    );
  }
}
