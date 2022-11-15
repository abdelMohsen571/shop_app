import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(@required message, @required ToastState state) =>
    Fluttertoast.showToast(
        msg: message,
        backgroundColor: chooseToastColor(state),
        gravity: ToastGravity.BOTTOM,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        fontSize: 16,
        timeInSecForIosWeb: 5);

enum ToastState { SUCCES, ERROR, WARNING }

Color? chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.SUCCES:
      color = Colors.green;
      break;
    case ToastState.WARNING:
      color = Colors.amber;
      break;
    case ToastState.ERROR:
      color = Colors.red;
      break;
  }
  return color;
}
