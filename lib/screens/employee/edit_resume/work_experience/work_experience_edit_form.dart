import 'package:employ/constants/custom_colors.dart';
import 'package:employ/widgets/custom_buttons.dart';
import 'package:employ/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../constants/custom_fonts.dart';
import '../../../../constants/custom_icons.dart';

class WorkExperienceEditForm extends StatefulWidget {
  const WorkExperienceEditForm({Key? key}) : super(key: key);

  @override
  State<WorkExperienceEditForm> createState() => _WorkExperienceEditFormState();
}
TextEditingController controller = TextEditingController();

// navigate to previous screen
void _goBack(BuildContext context) {
  Navigator.pop(context);
}

// navigate to edit resume objectives screen
void _navigateTo(BuildContext context, Widget widget) {
  Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.fade,
        child: widget,
      ));
}

class _WorkExperienceEditFormState extends State<WorkExperienceEditForm> {
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
                    SvgPicture.asset(CIcon.workExperinceIcon, width: 20,),
                    SizedBox(width: 20,),
                    CFont.smallerPrimary('Work Experience'),
                    Spacer(flex: 1,),
                    SvgPicture.asset(CIcon.arrowDownwardIos, width: 20,),
                  ],),
              ),
              Container(width: double.maxFinite, height: 2, color: CColor.grey),

              SizedBox(height: 30,),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 200.0),
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
                          //Position textile
                          CField.general(controller: controller,hint: 'Position e.g Product designer'),
                          SizedBox(height: 30,),
                          //Company textile
                          CField.general(controller: controller,hint: 'Company e.g Apple'),
                          SizedBox(height: 30,),
                          //Location textile
                          CField.general(controller: controller,hint: 'Location e.g Lagos, Nigeria'),
                          SizedBox(height: 30,),
                          //Description textile
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(color: CColor.grey, width: 2),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                  //controller: TextController,
                                  maxLength: 100,
                                  maxLines:5,
                                  cursorColor: CColor.black,
                                  decoration: const InputDecoration(
                                      hintText: 'Description of Roles and achievements at the company',
                                      hintStyle: TextStyle(color: CColor.grey, fontSize: 17),
                                      contentPadding: EdgeInsets.all(0),
                                      border: InputBorder.none),

                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          //Start date textile
                          CField.general(controller: controller,hint: 'Start date e.g 03/04/12'),
                          SizedBox(height: 30,),
                          //End date textile
                          CField.general(controller: controller,hint: 'End date e.g 03/04/12'),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),

              // next button
              CButton.primary(text: 'Done', onPressed: () {_goBack(context);}),
              SizedBox(height: 30)

            ],
          )),
    );
  }
}
