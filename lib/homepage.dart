import 'dart:async';

import 'package:flappy_bird/barrier.dart';
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
  double velocity=3.5;
  double birdWidth=0.1;
  double birdHeight=0.1;
  int score=0;
  int highscore=0;
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
            content: Text(
              "Score : "+ score.toString(),style: const TextStyle(color: Colors.white),),
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
                    ),
                ),
              ),
            )
          ],
        );
      }
    );
  }

  void resetGame(){
    if(score>highscore){
      highscore=score;
    }
    Navigator.pop(context);
    setState(() {
      birdY=0;
      gameHasStarted=false;
      time=0;
      score=0;
      initialPos=birdY;
    });
  }

  void jump(){
    setState(() {
      time=0;
      initialPos=birdY;
      score+=1;
    });
  }
  
  bool birdIsDead(){
    if(birdY<-1||birdY>1){
        return true;
    }
    for(int i=0;i<barrierX.length;i++){
      if(barrierX[i]<=birdWidth && 
        barrierX[i]+barrierwidth>=-birdWidth&&
        (birdY<=-1+barrierHeight[i][0])||
        birdY+birdHeight>=1-barrierHeight[i][1]){
          return true;
        }
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
                      birdHeight: birdHeight, 
                      birdWidth: birdWidth,
                    ),

                    //MyCoverScreen(gameHasStarted:gameHasStarted),

                    MyBarrier(
                      barrierX: barrierX[0],
                      barrierWidth: barrierwidth,
                      barrierHeight: barrierHeight[0][0],
                      isThisBottomBarrier: false,
                    ),

                    MyBarrier(
                      barrierX: barrierX[0],
                      barrierWidth: barrierwidth,
                      barrierHeight: barrierHeight[0][1],
                      isThisBottomBarrier: true,
                    ),

                    MyBarrier(
                      barrierX: barrierX[1],
                      barrierWidth: barrierwidth,
                      barrierHeight: barrierHeight[1][0],
                      isThisBottomBarrier: false,
                    ),

                    MyBarrier(
                      barrierX: barrierX[1],
                      barrierWidth: barrierwidth,
                      barrierHeight: barrierHeight[1][1],
                      isThisBottomBarrier: true,
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
                  children: const [
                    Text("Score",style: TextStyle(color: Colors.white,fontSize: 20),),
                    SizedBox(
                      height: 20,
                    ),
                    Text("0",style: TextStyle(color: Colors.white,fontSize: 40),),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Best",style: TextStyle(color: Colors.white,fontSize: 20),),
                    SizedBox(
                      height: 20,
                    ),
                    Text("0",style: TextStyle(color: Colors.white,fontSize: 40),),
                  ],
                ),
              ]),
              ),
            ),
        ]),
      ),
    );
  }
}