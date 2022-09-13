import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  // const MyBird({ Key? key }) : super(key: key);
  final birdY;
  final double birdWidth;
  final double birdHeight;
  MyBird({this.birdY,required this.birdHeight,required this.birdWidth});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0,birdY),
      child: Image.asset("lib/images/01.png",width: 50,),
    );
  }
}