
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

//custom alert toast
///param: @BuildContext, @Color color, @String msg
Flushbar alertNotification(BuildContext context, Color color, String msg){
return   Flushbar(
      icon: Icon(
        Icons.info_outline,
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(15.0),
shouldIconPulse: true,
isDismissible: true,
margin: const EdgeInsets.all(8.0),
      borderRadius: 8.0,
      message: msg,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: color.withOpacity(.9),
      duration: Duration(seconds: 6),
    )..show(context);
}