import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:employ/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../forgot_password/reset_password.dart';
import '../password_entry_page.dart';

class ErrorEmail extends StatelessWidget {
  final String title;
  final String message;
  const ErrorEmail({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 284,
        height: 244,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: CColor.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          children: [
            const Spacer(),
            const Icon(Icons.cancel_outlined, color: CColor.red, size: 70),
            const Spacer(flex: 2),
            // Icon(Icons.check_circle_outline)
            CFont.primary(title),
            CFont.secondary(message, color: CColor.black),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class ValidEmail extends StatelessWidget {
  final String title;
  final String message;
  const ValidEmail({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),
        Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 284,
            height: 244,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: CColor.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              children: [
                const Spacer(),
                const Icon(Icons.check_circle_outline,
                    color: CColor.green, size: 70),
                const Spacer(),
                // Icon(Icons.check_circle_outline)
                CFont.secondary(message, color: CColor.black),
                const Spacer(),
              ],
            ),
          ),
        ),
        const Spacer(),
        Material(
          color: Colors.transparent,
          child: CButton.primary(
              text: 'Continue',
              onPressed: () {
                submit(context);
              }),
        ),
        const Spacer(),
      ],
    );
  }

  void submit(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: PasswordEntryPage(),
        ));
  }
}

class SendOTPToEmail extends StatelessWidget {
  final String title;
  final String message;
  const SendOTPToEmail({Key? key, required this.title, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),
        Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: 284,
            height: 244,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: CColor.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              children: [
                const Spacer(),
                const Icon(Icons.check_circle_outline,
                    color: CColor.green, size: 70),
                const Spacer(),
                // Icon(Icons.check_circle_outline)
                CFont.secondary(message, color: CColor.black),
                const Spacer(),
              ],
            ),
          ),
        ),
        const Spacer(),
        Material(
          color: Colors.transparent,
          child: CButton.primary(
              text: 'Sign In',
              onPressed: () {
                NavigationMethods().toPreviousPage(context);
              }),
        ),
        const Spacer(),
      ],
    );
  }

}
