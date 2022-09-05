import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_icons.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../constants/custom_fonts.dart';
import '../create_resume/create_resume.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

void _goBack(BuildContext context) {
  Navigator.pop(context);
}

void _navigateToOneOfTheTabs(BuildContext context, Widget widget) {
  Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: widget,
      ));
}
class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Spacer(flex: 1,),
                  CFont.primary('Settings'),
                  Spacer(flex: 1,),
                ],
              ),
            ),
            Container(width: double.maxFinite, height: 2, color: CColor.grey),

            // account tab
            GestureDetector(
              onTap: () {
                NavigationMethods().toPreviousPage(context);
              },
              child: Container(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(CIcon.settingsAccountIcon,width: 20,),
                      SizedBox(width: 40,),
                      CFont.darkSecondary('My Profile')
                    ],
                  ),
                ),
              ),
            ),
            Container(width: double.maxFinite, height: 2, color: CColor.grey),

            // create CV tab
            GestureDetector(
              onTap: () {
                NavigationMethods().toCreateResumePage(context);
              },
              child: Container(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(CIcon.settingsAccountIcon,width: 20,),
                      SizedBox(width: 40,),
                      CFont.darkSecondary('Create CV')
                    ],
                  ),
                ),
              ),
            ),
            Container(width: double.maxFinite, height: 2, color: CColor.grey),

            // about tab
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(CIcon.settingsAccountIcon,width: 20,),
                      SizedBox(width: 40,),
                      CFont.darkSecondary('About')
                    ],
                  ),
                ),
              ),
            ),
            Container(width: double.maxFinite, height: 2, color: CColor.grey),

            // help centre tab
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(CIcon.settingsAccountIcon,width: 20,),
                      SizedBox(width: 40,),
                      CFont.darkSecondary('Help Centre')
                    ],
                  ),
                ),
              ),
            ),
            Container(width: double.maxFinite, height: 2, color: CColor.grey),

            // privacy policy tab
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(CIcon.settingsAccountIcon,width: 20,),
                      SizedBox(width: 40,),
                      CFont.darkSecondary('Privacy Policy')
                    ],
                  ),
                ),
              ),
            ),
            Container(width: double.maxFinite, height: 2, color: CColor.grey),

            // log out tab
            GestureDetector(
              onTap: () {},
              child: Container(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(CIcon.settingsAccountIcon,width: 20,),
                      SizedBox(width: 40,),
                      CFont.darkSecondary('Log Out')
                    ],
                  ),
                ),
              ),
            ),
            Container(width: double.maxFinite, height: 2, color: CColor.grey),

          ],
        ),
      ),
    );
  }
}
