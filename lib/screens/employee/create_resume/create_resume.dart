import 'package:employ/constants/custom_icons.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../constants/custom_colors.dart';
import '../../../constants/custom_fonts.dart';
import '../edit_resume/contact_details/edit_resume_contact_details.dart';
import '../login/password_entry_page.dart';

class CreateResume extends StatefulWidget {
  const CreateResume({Key? key}) : super(key: key);

  @override
  State<CreateResume> createState() => _CreateResumeState();
}

class _CreateResumeState extends State<CreateResume> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
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
              Container(width: double.maxFinite, height: 2, color: CColor.grey),

              // Contact details tab
              GestureDetector(
                onTap: () {
                  NavigationMethods().toEditResumeContactDetailsPage(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(CIcon.createResumeContactIcon, width: 20,),
                    SizedBox(width: 20,),
                    CFont.smallerPrimary('Contact Details'),
                    Spacer(flex: 1,),
                    Icon(Icons.arrow_forward_ios),
                  ],),
                ),
              ),
              Container(width: double.maxFinite, height: 1, color: CColor.grey),

              SizedBox(height: 10,),

              // Objectives tab
              Container(width: double.maxFinite, height: 1, color: CColor.grey),
              GestureDetector(
                onTap: () {
                  NavigationMethods().toEditResumeObjectives(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(CIcon.createResumeObjectiveIcon, width: 20,),
                      SizedBox(width: 20,),
                      CFont.smallerPrimary('Objectives'),
                      Spacer(flex: 1,),
                      Icon(Icons.arrow_forward_ios),
                    ],),
                ),
              ),
              Container(width: double.maxFinite, height: 1, color: CColor.grey),

              SizedBox(height: 10,),

              // Work experience tab
              Container(width: double.maxFinite, height: 1, color: CColor.grey),
              GestureDetector(
                onTap: () {
                  NavigationMethods().toEditResumeWorkExperience(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(CIcon.workExperinceIcon, width: 20,),
                      SizedBox(width: 20,),
                      CFont.smallerPrimary('Work Experience'),
                      Spacer(flex: 1,),
                      Icon(Icons.arrow_forward_ios),
                    ],),
                ),
              ),
              Container(width: double.maxFinite, height: 1, color: CColor.grey),

              SizedBox(height: 10,),
              //Education tab
              Container(width: double.maxFinite, height: 1, color: CColor.grey),
              GestureDetector(
                onTap: () {
                  NavigationMethods().toEditResumeEducation(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(CIcon.educationIcon, width: 25,),
                      SizedBox(width: 20,),
                      CFont.smallerPrimary('Education'),
                      Spacer(flex: 1,),
                      Icon(Icons.arrow_forward_ios),
                    ],),
                ),
              ),
              Container(width: double.maxFinite, height: 1, color: CColor.grey),

              SizedBox(height: 10,),

              // Skills tab
              Container(width: double.maxFinite, height: 1, color: CColor.grey),
              GestureDetector(
                onTap: () {
                  NavigationMethods().toEditResumeSkills(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(CIcon.skillsIcon, width: 20,),
                      SizedBox(width: 20,),
                      CFont.smallerPrimary('Skills'),
                      Spacer(flex: 1,),
                      Icon(Icons.arrow_forward_ios),
                    ],),
                ),
              ),
              Container(width: double.maxFinite, height: 1, color: CColor.grey),

              SizedBox(height: 10,),

              // Languages tab
              Container(width: double.maxFinite, height: 1, color: CColor.grey),
              GestureDetector(
                onTap: () {
                  NavigationMethods().toEditResumeLanguage(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(CIcon.createResumeLangIcon, width: 20,),
                      SizedBox(width: 20,),
                      CFont.smallerPrimary('Languages'),
                      Spacer(flex: 1,),
                      Icon(Icons.arrow_forward_ios),
                    ],),
                ),
              ),
              Container(width: double.maxFinite, height: 1, color: CColor.grey),

              SizedBox(height: 10,),

              // Interest tab
              Container(width: double.maxFinite, height: 1, color: CColor.grey),
              GestureDetector(
                onTap: () {
                  NavigationMethods().toEditResumeInterest(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(CIcon.createResumeInterestIcon, width: 20,),
                      SizedBox(width: 20,),
                      CFont.smallerPrimary('Interest'),
                      Spacer(flex: 1,),
                      Icon(Icons.arrow_forward_ios),
                    ],),
                ),
              ),
              Container(width: double.maxFinite, height: 1, color: CColor.grey),

              SizedBox(height: 10,),

              // Template tab
              Container(width: double.maxFinite, height: 1, color: CColor.grey),
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(CIcon.createResumeTemplatesIcon, width: 20,),
                      SizedBox(width: 20,),
                      CFont.smallerPrimary('Templates'),
                    ],),
                ),
              ),
              Container(width: double.maxFinite, height: 1, color: CColor.grey),

            ],
          )),
    );
  }
}
