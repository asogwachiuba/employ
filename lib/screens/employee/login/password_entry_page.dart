import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/screens/forgot_password/forgot_password.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:employ/widgets/custom_buttons.dart';
import 'package:employ/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../import_resume/import_resume.dart';

class PasswordEntryPage extends StatelessWidget {
  PasswordEntryPage({Key? key}) : super(key: key);

  final TextEditingController _password = TextEditingController();

  void forgotPassword(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
      type: PageTransitionType.fade,
      child: ForgotPassword(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColor.white,
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    NavigationMethods().toPreviousPage(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ],
          ),
          const Spacer(flex: 2),
          CFont.primary('Welcome Onboard!', color: CColor.black),
          const SizedBox(height: 20),
          CFont.small('Please enter your password to continue',
              color: CColor.black),
          const Spacer(flex: 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: CFont.secondary('Password'),
              ),
              CField.password(
                controller: _password,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        forgotPassword(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: CFont.small('Forgotten Password?',
                            color: CColor.red),
                      )),
                ],
              ),
            ],
          ),
          const Spacer(flex: 3),
          CButton.primary(
              text: 'Login',
              onPressed: () {
                NavigationMethods().toEmployeesHomePage(context);
              }),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
