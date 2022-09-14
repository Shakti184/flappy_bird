import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {
  // const MyBird({ Key? key }) : super(key: key);
  final birdY;
  final double birdWidth;
  final double birdHeight;
  const MyBird({Key? key, this.birdY,required this.birdHeight,required this.birdWidth}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(0,(2*birdY+birdHeight)/(2-birdHeight)),
      child: Image.asset(
        "lib/images/01.png",
        width:MediaQuery.of(context).size.height*birdWidth/2,
        height:MediaQuery.of(context).size.height*3/4*birdHeight/2,
        fit:BoxFit.fill,
        ),
    );
  }
}