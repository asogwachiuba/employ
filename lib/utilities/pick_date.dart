import 'package:flutter/material.dart';

Future<DateTime?> pickDate(BuildContext context) async {
  final DateTime? datePicked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050));

  if (datePicked != null) return datePicked;
  return null;
}
