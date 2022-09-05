import 'package:employ/constants/custom_colors.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../constants/custom_fonts.dart';
import '../../../../constants/custom_icons.dart';
import '../../../../widgets/custom_buttons.dart';
import '../work_experience/edit_resume_work_experience.dart';
class EditResumeObjectives extends StatefulWidget {
  const EditResumeObjectives({Key? key}) : super(key: key);

  @override
  State<EditResumeObjectives> createState() => _EditResumeObjectivesState();
}

class _EditResumeObjectivesState extends State<EditResumeObjectives> {
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
                        NavigationMethods().toPreviousPage(context);
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

            // Contact details tab
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(CIcon.createResumeObjectiveIcon, width: 20,),
                  SizedBox(width: 20,),
                  CFont.smallerPrimary('Objectives'),
                  Spacer(flex: 1,),
                  GestureDetector(
                      onTap: () {
                        NavigationMethods().toCreateResumePage(context);
                      },
                      child: SvgPicture.asset(CIcon.arrowDownwardIos, width: 20,)),
                ],),
            ),
            Container(width: double.maxFinite, height: 2, color: CColor.grey),

            // objective textfield
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(height: 400,
              child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 200,decoration: BoxDecoration(border: Border.all(color: CColor.grey,width: 2)),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Please type here ...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10)
                  ),
                ),),
                SizedBox(height: 10,),
                Wrap(
                  children: [
                    CFont.secondary('e.g I would like to gain experience as a software engineer '
                        'while working with the team')
                  ],
                )
              ],),),
            ),
            Container(width: double.maxFinite, height: 2, color: CColor.grey),

            SizedBox(height: 30,),

            // next button
            CButton.primary(text: 'Next', onPressed: () {NavigationMethods().toEditResumeWorkExperience(context);})
          ],
        ),
      ),
    );
  }
}
