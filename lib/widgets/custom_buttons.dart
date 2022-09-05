import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/constants/custom_icons.dart';
import 'package:flutter/material.dart';

class CButton {
  Color color = CColor.black;
  static Widget primary({required String text, required Function onPressed, var color }) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50),
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(7)),
        child: CFont.primary(text, color: CColor.white),
      ),
    );
  }

  static Widget secondaryIcon(
      {required String text,
      required String icon,
      required Function onPressed}) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 2, color: CColor.grey),
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            const SizedBox(width: 30),
            Image.asset(
              icon,
              width: 30,
            ),
            const SizedBox(width: 10),
            FittedBox(child: CFont.primary(text, color: CColor.black)),
          ],
        ),
      ),
    );
  }
}
