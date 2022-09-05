import 'dart:ffi';

import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/constants/custom_images.dart';
import 'package:employ/screens/employee/import_resume/widgets/logout_dialog.dart';
import 'package:employ/screens/employee/import_resume/widgets/resume_import_modal.dart';
import 'package:employ/screens/select_user_type.dart';
import 'package:employ/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

class ImportResume extends StatelessWidget {
  const ImportResume({Key? key}) : super(key: key);

  Future<void> _goBack(BuildContext context) async {
    bool _logout = await showDialog<bool>(
            context: context,
            builder: (context) {
              return LogoutWarning();
            }) ??
        false;
    if (_logout) {
      Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: SelectUserType(),
          ),
          (route) => false);
    }
  }

  void _importResume(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return ResumeImportModal();
        });
  }

  void _fillManually(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
          type: PageTransitionType.fade,
          child: Column(),
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
                    _goBack(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios)),
            ],
          ),
          const Spacer(flex: 1),
          SvgPicture.asset(CImg.announce),
          const SizedBox(height: 20),
          CFont.secondary('Finish your profile to personalize your search'),
          const SizedBox(height: 20),
          CButton.primary(
              text: 'Import Resume',
              onPressed: () {
                _importResume(context);
              }),
          const SizedBox(height: 30),
          CButton.primary(
              text: 'Fill in manually',
              onPressed: () {
                _fillManually(context);
              }),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
