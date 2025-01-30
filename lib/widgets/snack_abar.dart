import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showSnackbar(BuildContext context, String message, {bool isTrue = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isTrue == true ? Colors.green : Colors.redAccent,
      duration: Duration(seconds: 2),
    ),
  );
}

void showToast(String message) {
  Fluttertoast.showToast(
      msg: message.toString(),
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 10,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0);
}
