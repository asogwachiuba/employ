import 'package:employ/constants/custom_colors.dart';
import 'package:flutter/material.dart';

import '../constants/custom_fonts.dart';

class CField {
  static Widget text(
      {required String hint,
      required IconData icon,
      required TextEditingController controller,
      Function(String)? onSubmit, int? maxLine, int? maxLength}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: CColor.grey),
      ),
      child: TextField(
        maxLength: maxLength,
        minLines: 1,
        maxLines: maxLine,
        keyboardType: TextInputType.multiline,
        controller: controller,
        onSubmitted: (String entry) {
          if (onSubmit != null) {
            onSubmit(entry);
          }
        },
        style: const TextStyle(
          color: CColor.black,
          fontSize: 18,
          fontFamily: 'Lato',
        ),
        decoration: InputDecoration(
            hintText: hint, suffixIcon: Icon(icon), border: InputBorder.none),
      ),
    );
  }

  static Widget email(
      {required TextEditingController controller, Function(String)? onSubmit}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: CColor.grey),
      ),
      child: Row(
        children: [
          const SizedBox(width: 30),
          const Icon(Icons.mail_outline),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (String entry) {
                if (onSubmit != null) {
                  onSubmit(entry);
                }
              },
              style: const TextStyle(
                color: CColor.black,
                fontSize: 18,
                fontFamily: 'Lato',
              ),
              decoration: const InputDecoration(
                  hintText: 'Enter email adress', border: InputBorder.none),
            ),
          ),
        ],
      ),
    );
  }

  static Widget password(
      {required TextEditingController controller, Function(String)? onSubmit}) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: CColor.grey),
      ),
      child: TextField(
        controller: controller,
        obscureText: true,
        onSubmitted: (String entry) {
          if (onSubmit != null) {
            onSubmit(entry);
          }
        },
        style: const TextStyle(
          color: CColor.black,
          fontSize: 18,
          fontFamily: 'Lato',
        ),
        decoration: const InputDecoration(
            hintText: 'password',
            border: InputBorder.none,
            suffixIcon: Icon(Icons.visibility_off)),
      ),
    );
  }

  // general textile
  static Widget general(
      {required TextEditingController controller, Function(String)? onSubmit ,int? numberOfMaxCharacters, required String hint}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: CColor.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: CColor.grey),
      ),
      child: Column(
        children: [
          TextField(
            maxLength: numberOfMaxCharacters,
            minLines: 1,
            controller: controller,
            onSubmitted: (String entry) {
              if (onSubmit != null) {
                onSubmit(entry);
              }
            },
            style: const TextStyle(
              color: CColor.black,
              fontSize: 18,
              fontFamily: 'Lato',
            ),
            decoration:  InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(color: CColor.grey,fontSize: 17, fontFamily: 'Lato'),
                border: InputBorder.none,
          ),
    ),
        ],
      ));
  }

  // for large text field
  static Widget large(
      {required TextEditingController controller, int? numberOfMaxCharacters, int? maxLine, required String hint}) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: CColor.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: CColor.grey),
        ),
        child: Column(
          children: [
            TextField(
              maxLength: numberOfMaxCharacters,
              minLines: 3,
              maxLines: maxLine,
              controller: controller,
              style: const TextStyle(
                color: CColor.black,
                fontSize: 18,
                fontFamily: 'Lato',
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: const TextStyle(
                    color: CColor.grey, fontSize: 17, fontFamily: 'Lato'),
                border: InputBorder.none,
              ),
            ),
          ],
        ));
  }

}
