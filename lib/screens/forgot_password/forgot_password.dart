import 'package:employ/widgets/custom_buttons.dart';
import 'package:employ/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../constants/custom_fonts.dart';
import '../../utilities/navigation.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();
  final bool _isSubmitted = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
              children: [
                IconButton(
                  onPressed: () {
                    NavigationMethods().toPreviousPage(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  iconSize: 25,
                ),
                const Spacer(
                  flex: 1,
                ),
                CFont.primary('Forgot Password ?'),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
                const SizedBox(
                  height: 30,
                ),
                CFont.small('Please enter your email address '
                'to receive a link to create a new password'),
                const Spacer(flex: 4,),

                CField.email(controller: _controller,),

                const Spacer(flex: 2,),

                CButton.primary(text: 'Send OTP', onPressed: () {}),

                const Spacer(flex: 1,)
        ],
      ),
          )),
    );
  }
}
