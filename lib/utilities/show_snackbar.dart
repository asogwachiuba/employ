import 'package:flutter/material.dart';

showSnackBar(String snackText, BuildContext context, Duration d, Color? color) {
  final snackBar = SnackBar(
    content: Text(snackText, style: TextStyle(color: color ?? Colors.white)),
    backgroundColor: Colors.black,
    duration: d,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
