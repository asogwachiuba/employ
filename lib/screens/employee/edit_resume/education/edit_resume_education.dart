import 'package:employ/constants/custom_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../constants/custom_fonts.dart';
import '../../../../constants/custom_icons.dart';
import '../../../../widgets/custom_buttons.dart';
import '../skills/edit_resume_skills.dart';
import 'education_edit_form.dart';


class EditResumeEducation extends StatefulWidget {
  const EditResumeEducation({Key? key}) : super(key: key);

  @override
  State<EditResumeEducation> createState() => _EditResumeEducationState();
}
void _goBack(BuildContext context) {
  Navigator.pop(context);
}

// navigate to edit resume objectives screen
void _navigateToEditResumeSkills(BuildContext context,Widget widget) {
  Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: widget
      ));
}

class _EditResumeEducationState extends State<EditResumeEducation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40),
            // App bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        _goBack(context);
                      },
                      icon: Icon(Icons.arrow_back_ios)),
                  Spacer(flex: 1,),
                  CFont.primary('Create Resume'),
                  Spacer(flex: 2,)
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(width: double.maxFinite, height: 1, color: CColor.grey),

            // Work Experince tab
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(CIcon.educationIcon, width: 25,),
                  SizedBox(width: 20,),
                  CFont.smallerPrimary('Education'),
                  Spacer(flex: 1,),
                  SvgPicture.asset(CIcon.arrowDownwardIos, width: 20,),
                ],),
            ),
            Container(width: double.maxFinite, height: 2, color: CColor.grey),

            SizedBox(height: 50,),

            // work experiences tile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: CColor.grey,width: 2 )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(CIcon.threeDashes, width: 20,),
                      SizedBox(width: 10,),
                      Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CFont.darkSecondary('University of Lagos'),
                          SizedBox(height: 5,),
                          CFont.small("Bsc. Accounting"),
                        ],),
                      Spacer(flex: 1,),
                      SvgPicture.asset(CIcon.delete),
                      //SizedBox(width: 20,)
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 40,),

            // add more experience tile
            GestureDetector(
              onTap: () {
                _navigateToEditResumeSkills(context,const EducationEditForm());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: CColor.grey,width: 2 )),
                  child: Center(child: SvgPicture.asset(CIcon.add, width: 40,),),
                ),
              ),
            ),
            SizedBox(height: 100,),

            Container(width: double.maxFinite, height: 2, color: CColor.grey),

            SizedBox(height: 50,),

            // next button
            CButton.primary(text: 'Next', onPressed: () {_navigateToEditResumeSkills(context,const EditResumeSkills(),);})
          ],
        ),
      ),
    );
  }
}
