import 'package:employ/constants/custom_colors.dart';
import 'package:employ/widgets/custom_buttons.dart';
import 'package:employ/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';
import '../../../../constants/custom_fonts.dart';
import '../../../../constants/custom_icons.dart';
import '../objectives/edit_resume_objectives.dart';

class EducationEditForm extends StatefulWidget {
  const EducationEditForm({Key? key}) : super(key: key);

  @override
  State<EducationEditForm> createState() => _EducationEditFormState();
}
TextEditingController controller = TextEditingController();

// navigate to previous screen
void _goBack(BuildContext context) {
  Navigator.pop(context);
}

// navigate to edit resume objectives screen
void _navigateToEditResumeObjectives(BuildContext context) {
  Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: const EditResumeObjectives(),
      ));
}

class _EducationEditFormState extends State<EducationEditForm> {
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

              // Contact details tab
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(CIcon.educationIcon, width: 20,),
                    const SizedBox(width: 20,),
                    CFont.smallerPrimary('Education'),
                    Spacer(flex: 1,),
                    SvgPicture.asset(CIcon.arrowDownwardIos, width: 20,),
                  ],),
              ),
              Container(width: double.maxFinite, height: 2, color: CColor.grey),
              SizedBox(height: 30,),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100.0),
                    child: Align(
                      alignment: const Alignment(-3, -0.5),
                      child: Container(
                        width: MediaQuery.of(context).size.width / 1.5,
                        height: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 50, color: CColor.lightRed)),
                      ),
                    ),
                  ),
                  Positioned(left: 0,right: 0,top: 20,
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        children: [
                          //Surname textile
                          CField.general(controller: controller,hint: 'Name of Instituition'),
                          SizedBox(height: 30,),
                          //Firstname textile
                          CField.general(controller: controller,hint: 'Degree e.g Bsc. Accounting'),
                          SizedBox(height: 30,),
                          //Phone textile
                          CField.general(controller: controller,hint: 'Location e.g Lagos, Nigeria'),
                          SizedBox(height: 30,),
                          //Email textile
                          CField.general(controller: controller,hint: 'Year of Graduation e.g 2012 - 2017'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(width: double.maxFinite, height: 2, color: CColor.grey),
              SizedBox(height: 30,),

              // next button
              CButton.primary(text: 'Done', onPressed: () {_goBack(context);})
            ],
          )),
    );
  }
}
