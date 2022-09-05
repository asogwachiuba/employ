import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_images.dart';
import 'package:employ/widgets/custom_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../constants/custom_fonts.dart';
import '../employee/login/sign_in_page.dart';

class ResetPasswordSuccess extends StatelessWidget {
  const ResetPasswordSuccess({Key? key}) : super(key: key);

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
                CFont.primary('Forgot Password ?', color: CColor.black),
                const Spacer(flex: 2),
              ],
            ),
            const SizedBox(height: 20),
            CFont.small('Try not to forget your password again friends',
                color: CColor.black),
            const SizedBox(height: 20),
            Container(
              width: 300,
              height: 300,
              child: SvgPicture.asset(CImg.happy,fit: BoxFit.fitWidth,),
            ),
            SizedBox(height: 10,),
            CFont.smallerPrimary('Password changed successfully!'),
            SizedBox(height: 50,),
            CButton.primary(text: 'Sign In', onPressed:() {Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: SigninPage(),
                ));} )
          ],
        ),
      ),
    );
  }
}
