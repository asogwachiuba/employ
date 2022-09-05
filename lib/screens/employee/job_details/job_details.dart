import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/constants/custom_icons.dart';
import 'package:employ/models/job_post_model.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:employ/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobDetailsPage extends StatelessWidget {
  final JobPostModel selectedJobPost;
  const JobDetailsPage({Key? key, required this.selectedJobPost}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // App bar
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
                        CFont.primary('JOB INFO'),
                        const Spacer(flex: 1,),
                        // IconButton(
                        //   onPressed: () {
                        //     NavigationMethods().toEmployeeSettingsPage(context);
                        //   },
                        //   icon: const Icon(Icons.settings_outlined),
                        //   iconSize: 25,
                        // ),
                      ],
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    // job title
                    CFont.primary(
                      selectedJobPost.jobTitle ?? '',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CFont.small(selectedJobPost.employerName ?? 'Not Available Yet', color: CColor.blue),
                    const SizedBox(
                      height: 10,
                    ),
                    CFont.small(selectedJobPost.jobLocation ?? 'Not Available Yet'),
                    const SizedBox(
                      height: 30,
                    ),
                    CFont.smallerPrimary('Job details'),
                    const SizedBox(
                      height: 5,
                    ),
                    CFont.secondary('Job type'),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              color: CColor.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, bottom: 3.0, right: 8, left: 8),
                            child: Center(
                                child: Row(
                              children: [
                                SvgPicture.asset(
                                  CIcon.workExperinceIcon,
                                  width: 11,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(selectedJobPost.jobType ?? 'Not Available Yet',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),

              Container(
                color: CColor.grey,
                height: 1.5,
              ),
              // Full job description tab
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CFont.smallerPrimary('Full Job Description:',),
                    const SizedBox(
                      height: 5,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),
                      child: Text(selectedJobPost.jobDescription ?? 'Not Available Yet',
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 16, color: CColor.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Experience tabs
                    CFont.smallerPrimary('Experience: '),
                    const SizedBox(
                      height: 5,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),
                      child: Text(selectedJobPost.requiredWorkExperience ?? 'Not Available Yet',
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 16, color: CColor.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Skills Required tabs
                    CFont.smallerPrimary('Skills Required: '),
                    const SizedBox(
                      height: 5,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),
                      child: Text(selectedJobPost.requiredSkills ?? 'Not Available Yet',
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 16, color: CColor.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    // Salary tab
                    CFont.smallerPrimary('Salary: '),
                    const SizedBox(
                      height: 5,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width),
                      child: Text(selectedJobPost.salary ?? 'Not Available Yet',
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 16, color: CColor.grey),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),

              //Apply button
              CButton.primary(
                  text: 'Apply Now',
                  onPressed: () {
                    NavigationMethods().toSubmitResumePage(context, selectedJobPost.jobPostId!, selectedJobPost.jobLocation!);
                  }),
              const SizedBox(
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }
}
