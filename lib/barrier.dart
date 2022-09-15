import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  //const MyBarrier({ Key? key }) : super(key: key);
  final double barrierWidth;
  final double barrierHeight;
  final double barrierX;
  final bool isThisBottomBarrier;

  MyBarrier(
    {required this.barrierHeight,
    required this.barrierWidth,
    required this.isThisBottomBarrier,
    required this.barrierX,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: //Alignment(1,-0.3),
      Alignment((2*barrierX+0.5)*(2-barrierWidth),isThisBottomBarrier?1.1:-1.2),
      child: Container(
        //color: Colors.green,
        decoration: BoxDecoration(color: Colors.green,
        border: Border.all(width: 10,color: const Color.fromARGB(255, 2, 112, 7),),
        borderRadius: BorderRadius.circular(15),
        ),
        width:MediaQuery.of(context).size.width*barrierWidth/2,
        height: MediaQuery.of(context).size.height*3/4*barrierHeight/2,
      ),
    );
  }
}