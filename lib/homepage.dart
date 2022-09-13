import 'dart:async';

import 'package:flappy_bird/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdY=0;
  double initialPos=birdY;
  double height=0;
  double time=0;
  double gravity=-4.9;
  double velocity=2.5;

  bool gameHasStarted=false;

  static List<double> barrierX=[2,2+1.5];
  static double barrierwidth=0.5;
  List<List<double>>barrierHeight=[
    [0.6,0.4],
    [0.4,0.6],
  ];

  void startGame(){
    gameHasStarted=true;
    Timer.periodic(const Duration(milliseconds: 50),(timer){
      height = gravity*time*time+velocity*time;
      setState(() {
        birdY=initialPos-height;
      });
      
      if(birdIsDead()){
        timer.cancel();
        gameHasStarted=false;
        _showDialog();
      }

      time+=0.01;
    });
  }

  void _showDialog(){
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 129, 24, 24),
          title: const Center(
            child: Text(
              "G A M E  O V E R",
              style: TextStyle(color: Colors.white,),
            ),
            ),
            actions: [
              GestureDetector(
                onTap: resetGame,
                child: ClipRRect(borderRadius: BorderRadius.circular(5),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  color: const Color.fromARGB(255, 14, 0, 0),
                  child: const Text(
                    'PLAY AGAIN',
                    style: TextStyle(color: Colors.white),
                    )
                ),
              ),
            )
          ],
        );
      }
    );
  }

  void resetGame(){
    Navigator.pop(context);
    setState(() {
      birdY=0;
      gameHasStarted=false;
      time=0;
      initialPos=birdY;
    });
  }

  void jump(){
    setState(() {
      time=0;
      initialPos=birdY;
    });
  }
  
  bool birdIsDead(){
    if(birdY<-1||birdY>1){
        return true;
      }
      return false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted?jump:startGame,
      child: Scaffold(
        body: Column(children: [
          Expanded(
            flex:3,
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Stack(
                  children: [
                    MyBird(
                      birdY: birdY, 
                      birdHeight: birdWidth, 
                      birdWidth: birdHeight,
                    ),
                    Container(
                      alignment: const Alignment(0,-0.5),
                      child: Text(
                        gameHasStarted?'':'T A P  T O  P L A Y',
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
          Expanded(
            child: Container(
              color: Colors.brown,
              ),
            ),
        ]),
      ),
    );
  }
}