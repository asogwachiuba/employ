import 'package:flutter/material.dart';

bool isNullTextFormFieldsCheck(List<TextEditingController> listOfControllers) {
  if (listOfControllers.any((element) => element.text.isEmpty) == false) {
    return false;
  }
 else {
    return true;
  }
}