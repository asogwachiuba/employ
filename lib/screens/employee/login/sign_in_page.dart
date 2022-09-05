import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/constants/custom_icons.dart';
import 'package:employ/screens/employee/login/widgets/alert_dialog.dart';
import 'package:employ/utilities/validator.dart';
import 'package:employ/widgets/custom_buttons.dart';
import 'package:employ/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:go_router/go_router.dart';

import '../signup_pages/signup_page.dart';


class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final TextEditingController _controller = TextEditingController();
  final int _duration = 300;
  double _opacity = 1;

  void _goBack() {
    Navigator.pop(context);
  }

  void _verifyEmail(String email) {
    if (Validate.email(email)) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return ValidEmail(title: '', message: 'Email verified sucessfully');
          });
      setState(() {
        _opacity = 0;
      });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const ErrorEmail(
              title: 'Invalid Email',
              message: 'Enter in a valid Email adress',
            );
          });
    }
  }

  void _googleSignin() {}

  void _facebookSignin() {}

  void _signup() {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: SignupPage(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                IconButton(
                    onPressed: _goBack,
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: CColor.black,
                    ))
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                CFont.primary('Ready to get started?'),
                const SizedBox(height: 10),
                CFont.small('Create an account or sign in',
                    color: CColor.black),
              ],
            ),
            const SizedBox(height: 50),
            Column(
              children: [
                CButton.secondaryIcon(
                    text: 'Continue with Google',
                    icon: CIcon.google,
                    onPressed: _googleSignin),
                const SizedBox(height: 50),
                CButton.secondaryIcon(
                    text: 'Continue with Facebook',
                    icon: CIcon.facebook,
                    onPressed: _facebookSignin),
              ],
            ),
            const SizedBox(height: 50),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 2,
                color: CColor.black,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CFont.secondary('or', color: CColor.black),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 2,
                color: CColor.black,
              ),
            ]),
            const SizedBox(height: 50),
            CField.email(
              controller: _controller,
              onSubmit: _verifyEmail,
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CFont.small('Don\'t have an account?  ', color: CColor.black),
              GestureDetector(
                  onTap: _signup,
                  child: CFont.small('Sign up', color: CColor.red)),
            ]),
            const SizedBox(height: 50),
            AnimatedOpacity(
              duration: Duration(milliseconds: _duration),
              opacity: _opacity,
              child: CButton.primary(
                  text: 'Get started',
                  onPressed: () {
                    _verifyEmail(_controller.text);
                  }),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
