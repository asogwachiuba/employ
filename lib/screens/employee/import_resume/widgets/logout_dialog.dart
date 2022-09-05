import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:flutter/material.dart';

class LogoutWarning extends StatelessWidget {
  const LogoutWarning({Key? key}) : super(key: key);

  void _logoutResponse(BuildContext context, bool result) {
    Navigator.pop(context, result);
  }

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
            const Icon(Icons.error_outline, color: CColor.red, size: 70),
            const Spacer(flex: 2),
            // Icon(Icons.check_circle_outline)
            CFont.primary('Logout'),
            CFont.secondary('Are you sure you want to logout?',
                color: CColor.black),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              MaterialButton(
                  onPressed: () {
                    _logoutResponse(context, true);
                  },
                  color: CColor.grey,
                  child: CFont.secondary('YES', color: CColor.black)),
              MaterialButton(
                  onPressed: () {
                    _logoutResponse(context, false);
                  },
                  color: CColor.black,
                  child: CFont.secondary('NO', color: CColor.white))
            ]),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
