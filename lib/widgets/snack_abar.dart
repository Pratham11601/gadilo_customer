import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String message, {bool isTrue = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: isTrue == true ? Colors.green : Colors.redAccent,
      duration: Duration(seconds: 2),
    ),
  );
}
