import 'package:employ/constants/custom_colors.dart';
import 'package:employ/screens/forgot_password/reset_password_success.dart';
import 'package:employ/widgets/custom_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants/custom_fonts.dart';
import '../../widgets/custom_textfield.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      // goBack(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios)),
                const Spacer(flex: 1),
                CFont.primary('Reset Password ', color: CColor.black),
                const Spacer(flex: 2),
              ],
            ),
            const SizedBox(height: 20),
            CFont.small('Let\'s help you reset your password to a better one',
                color: CColor.black),
            SizedBox(height: 100,),
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: CFont.secondary('Enter new password',align: TextAlign.start,color: CColor.black),
                ),
                CField.password(
                  controller: TextEditingController(),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: CFont.secondary('Confirm new password',align: TextAlign.start,color: CColor.black),
                ),
                CField.password(
                  controller: TextEditingController(),
                ),
              ],
            ),
            SizedBox(height: 80,),
            CButton.primary(text: 'Continue',
                onPressed: () {Navigator.push(
                context,
                PageTransition(
              type: PageTransitionType.fade,
              child: ResetPasswordSuccess(),
            ));}),
            SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
