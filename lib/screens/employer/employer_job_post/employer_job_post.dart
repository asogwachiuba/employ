import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/constants/custom_images.dart';
import 'package:employ/models/job_post_model.dart';
import 'package:employ/provider/company_profile_provider.dart';
import 'package:employ/provider/job_posts_provider.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:employ/utilities/show_snackbar.dart';
import 'package:employ/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../../../utilities/is_not_null_textformfields_checkers.dart';
import '../../../utilities/pick_date.dart';
import '../../../widgets/custom_buttons.dart';

class EmployerJobPost extends StatefulWidget {
  final JobPostModel? jobPostModel;
  const EmployerJobPost({
    this.jobPostModel ,
    Key? key}) : super(key: key);

  @override
  State<EmployerJobPost> createState() => _EmployerJobPostState();
}

class _EmployerJobPostState extends State<EmployerJobPost> {
  final TextEditingController _jobTitleFieldController =
      TextEditingController();
  final TextEditingController _companyNameFieldController =
      TextEditingController();
  final TextEditingController _jobDescriptionFieldController =
      TextEditingController();
  final TextEditingController _salaryFieldController = TextEditingController();
  final TextEditingController _requiredWorkExperienceFieldController =
      TextEditingController();
  final TextEditingController _requiredSkillsFieldController =
      TextEditingController();
  final TextEditingController _jobIndustryFieldController =
      TextEditingController();
  final TextEditingController _jobTypeFieldController = TextEditingController();
  final TextEditingController _jobLocationFieldController =
      TextEditingController();
  final TextEditingController _jobApplicationDeadlineFieldController =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _companyNameFieldController.dispose();
    _salaryFieldController.dispose();
    _jobIndustryFieldController.dispose();
    _jobLocationFieldController.dispose();
    _jobTypeFieldController.dispose();
    _jobApplicationDeadlineFieldController.dispose();
    _requiredSkillsFieldController.dispose();
    _requiredWorkExperienceFieldController.dispose();
    _jobDescriptionFieldController.dispose();
    _jobTitleFieldController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    if(widget.jobPostModel != null){
      _companyNameFieldController.text = widget.jobPostModel?.employerName ?? 'Update company name';
      _jobLocationFieldController.text = widget.jobPostModel?.jobLocation ?? 'Update company location';
      _jobApplicationDeadlineFieldController.text = widget.jobPostModel?.jobApplicationDeadline ?? 'Update application deadline';
      _jobTypeFieldController.text = widget.jobPostModel?.jobType ?? 'Update job type';
      _jobIndustryFieldController.text = widget.jobPostModel?.jobIndustry ?? 'Update company industry';
      _requiredSkillsFieldController.text = widget.jobPostModel?.requiredSkills ?? 'Update skills required';
      _requiredWorkExperienceFieldController.text = widget.jobPostModel?.requiredWorkExperience ?? 'Update work experience required';
      _salaryFieldController.text = widget.jobPostModel?.salary ?? 'Update salary';
      _jobTitleFieldController.text = widget.jobPostModel?.jobTitle ?? 'Update Job title';
      _jobDescriptionFieldController.text = widget.jobPostModel?.jobDescription ?? 'Update job description';

    }
    super.initState();
  } // list of controllers
  List<TextEditingController> listOfTextControllers = [];

  @override
  Widget build(BuildContext context) {
    listOfTextControllers.addAll([
      _jobDescriptionFieldController,
      _jobTitleFieldController,
      _salaryFieldController,
      _requiredWorkExperienceFieldController,
      _requiredSkillsFieldController,
      _jobIndustryFieldController,
      _jobTypeFieldController,
      _jobApplicationDeadlineFieldController,
      _jobLocationFieldController
    ]);
    final _jobPostProvider = Provider.of<JobPostsProvider>(context);
    final _companyProfileProvider = Provider.of<CompanyProfileProvider>(context);

    return Scaffold(
      backgroundColor: CColor.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // App bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        NavigationMethods().toPreviousPage(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),

            // Job post Image
            SvgPicture.asset(
              CImg.jobPost,
              height: 200,
            ),

            // Image Text
            CFont.small('Provide basic information about a job',
                color: CColor.black),

            const SizedBox(
              height: 10,
            ),
            // reminder text
            ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.8),
                child: CFont.small(
                    'Fill in all the details necessary to receive quality job applications!!!',
                    color: CColor.red)),

            const SizedBox(
              height: 30,
            ),

            // Job title textfield
            SizedBox(
              height: 350,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Job title
                    Padding(
                        padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: CFont.secondary('Job Title',
                                color: CColor.black))),

                    CField.general(
                        controller: _jobTitleFieldController, hint: ''),

                    const SizedBox(
                      height: 10,
                    ),

                    // Company Name
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: CFont.secondary('Company/Employer Name',
                              color: CColor.black)),
                    ),
                    CField.general(
                        controller: _companyNameFieldController, hint: ''),

                    const SizedBox(
                      height: 10,
                    ),

                    // Job description textile
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: CFont.secondary('Job Description',
                              color: CColor.black)),
                    ),
                    CField.general(
                        controller: _jobDescriptionFieldController, hint: ''),

                    const SizedBox(
                      height: 10,
                    ),

                    // Salary textile
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child:
                              CFont.secondary('Salary', color: CColor.black)),
                    ),
                    CField.general(
                        controller: _salaryFieldController, hint: ''),

                    const SizedBox(
                      height: 10,
                    ),

                    // Required Work Experience textile
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: CFont.secondary('Experience Required',
                              color: CColor.black)),
                    ),
                    CField.general(
                        controller: _requiredWorkExperienceFieldController,
                        hint: ''),

                    const SizedBox(
                      height: 10,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // Job Location textile
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: CFont.secondary('Job Location',
                              color: CColor.black)),
                    ),
                    CField.general(
                        controller: _jobLocationFieldController, hint: ''),

                    const SizedBox(
                      height: 10,
                    ),

                    // Required skills textile
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: CFont.secondary('Required skill set',
                              color: CColor.black)),
                    ),
                    CField.general(
                        controller: _requiredSkillsFieldController, hint: ''),

                    const SizedBox(
                      height: 10,
                    ),

                    // Job Type textile
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child:
                              CFont.secondary('Job Type', color: CColor.black)),
                    ),
                    CField.general(
                        controller: _jobTypeFieldController, hint: ''),

                    const SizedBox(
                      height: 10,
                    ),


                    // Job application deadline textile
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CFont.secondary('Application Deadline',
                            color: CColor.black),
                      ),
                    ),
                    Stack(
                      children: [
                        CField.general(
                            controller: _jobApplicationDeadlineFieldController,
                            hint: ''),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              pickDate(context).then((value) =>
                                  _jobApplicationDeadlineFieldController.text =
                                      value.toString().substring(0, 10));
                            });
                          },
                          child: Container(
                            color: Colors.transparent,
                            height: 50,
                            width: MediaQuery.of(context).size.width,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

            // post the job
            CButton.primary(
                text: 'POST',
                onPressed: () {
                  if (isNullTextFormFieldsCheck(listOfTextControllers) ==
                      true) {
                    if(widget.jobPostModel != null) _companyProfileProvider.deleteSelectedJobPost(widget.jobPostModel!.jobPostId!);
                    _jobPostProvider.uploadJobPost(
                        _jobTitleFieldController.text,
                        _jobDescriptionFieldController.text,
                        _salaryFieldController.text,
                        _requiredWorkExperienceFieldController.text,
                        _requiredSkillsFieldController.text,
                        _jobIndustryFieldController.text,
                        _jobTypeFieldController.text,
                        _jobApplicationDeadlineFieldController.text,
                        _jobLocationFieldController.text,
                        _companyNameFieldController.text);

                    _jobLocationFieldController.clear();
                    _jobApplicationDeadlineFieldController.clear();
                    _jobTypeFieldController.clear();
                    _jobIndustryFieldController.clear();
                    _requiredSkillsFieldController.clear();
                    _requiredWorkExperienceFieldController.clear();
                    _salaryFieldController.clear();
                    _jobDescriptionFieldController.clear();
                    _jobTitleFieldController.clear();
                    _companyNameFieldController.clear();
                  } else {
                    showSnackBar(
                        'Please complete the form before posting',
                        context,
                        const Duration(milliseconds: 1000),
                        Colors.red);
                  }
                }),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}
