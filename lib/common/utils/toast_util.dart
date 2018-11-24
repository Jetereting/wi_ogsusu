import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';

class ToastUtil{

  static void showSuccess(BuildContext context, String msg){
    Flushbar(flushbarPosition: FlushbarPosition.BOTTOM)
      ..title = "Success"
      ..icon = Icon(
        Icons.check_circle,
        size: 28.0,
        color: Colors.green[500],
      )
      ..titleText = new Text(
          "Success",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.green[500],
          )
      )
      ..message = msg
      ..duration = Duration(seconds: 3)
      ..backgroundGradient = new LinearGradient(colors: [Colors.black87, Colors.black87])
      ..shadowColor = Colors.black45
      ..show(context);
  }

  static void showError(BuildContext context, String msg){
    Flushbar(flushbarPosition: FlushbarPosition.BOTTOM)
      ..title = "Error!"
      ..icon = Icon(
        Icons.error_outline,
        size: 28.0,
        color: Colors.red[500],
      )
      ..titleText = new Text(
          "Error!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.red[500],
          )
      )
      ..message = msg
      ..duration = Duration(seconds: 3)
      ..backgroundGradient = new LinearGradient(colors: [Colors.black87, Colors.black87])
      ..shadowColor = Colors.black45
      ..show(context);
  }
}