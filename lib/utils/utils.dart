import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

class Utils{

  static void flushBar(String message,BuildContext context){
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        message: message,
       flushbarPosition: FlushbarPosition.TOP,
        // forwardAnimationCurve: Curves.bounceInOut,
        backgroundColor: Colors.red,
        margin:const EdgeInsets.symmetric(horizontal: 8),
        icon: const Icon(Icons.error_outline,color: Colors.white,),
        padding: const EdgeInsets.all(8),
        //animationDuration: const Duration(milliseconds: 500),
        duration:const  Duration(seconds: 2),


      )..show(context)
    );
  }
}