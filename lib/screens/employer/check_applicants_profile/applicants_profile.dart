import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/models/employees_model.dart';
import 'package:flutter/material.dart';

class ApplicantsProfile extends StatelessWidget {
  final EmployeeProfileModel applicantProfile;

  const ApplicantsProfile(
      {required this.applicantProfile, Key? key, selectedJobApplication})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CColor.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                // Personal information tab of applicant
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CFont.primary(applicantProfile.userName!),
                        const SizedBox(
                          height: 10,
                        ),
                        CFont.small(applicantProfile.userMail!),
                        const SizedBox(
                          height: 5,
                        ),
                        CFont.small(applicantProfile.userLocation!),
                        const SizedBox(
                          height: 5,
                        ),
                        CFont.small(applicantProfile.userPhoneNumber!)
                      ],
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    applicantProfile.userProfilePhotoUrl == null
                        ? const CircleAvatar(
                            backgroundColor: CColor.black,
                            radius: 40,
                            child: Icon(
                              Icons.person,
                              color: CColor.white,
                              size: 60,
                            ),
                          )
                        : ClipOval(
                            child: Image.network(
                              applicantProfile.userProfilePhotoUrl!,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: CColor.blue,
                  height: 1,
                ),

                const SizedBox(
                  height: 10,
                ),

                // about tab of applicant
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 5,
                      color: CColor.blue,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CFont.darkSecondary('About'),
                        const SizedBox(
                          height: 5,
                        ),
                        ConstrainedBox(
                            constraints: BoxConstraints(
                                maxWidth: MediaQuery.of(context).size.width),
                            child: CFont.small(
                                applicantProfile.userDescription ??
                                    'Not available yet',
                                align: TextAlign.start,
                                color: CColor.black, maxLines: 50))
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: CColor.blue,
                  height: 1,
                ),

                const SizedBox(
                  height: 10,
                ),

                // work experience tab of applicant
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 5,
                      color: CColor.blue,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CFont.darkSecondary('Work Experience'),
                          const SizedBox(
                            height: 5,
                          ),
                          ConstrainedBox(
                              constraints: BoxConstraints(
                                  maxWidth: MediaQuery.of(context).size.width),
                              child: applicantProfile.userWorkExperience == null
                                  ? CFont.small(
                                      'No work experience available yet')
                                  : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: applicantProfile.userWorkExperience!.length,
                                      itemBuilder: (context, index) => Card(
                                            color: Colors.white,
                                            shadowColor: CColor.black,
                                            elevation: 15,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: CFont.small(applicantProfile
                                                  .userWorkExperience![index],
                                              maxLines: 100,
                                              align: TextAlign.start),
                                            ),
                                          )))
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: CColor.blue,
                  height: 1,
                ),

                const SizedBox(
                  height: 10,
                ),

                // User skills tab of applicant
                SizedBox(
                  height: 150,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 5,
                        color: CColor.blue,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CFont.darkSecondary('Skill Set'),
                            const SizedBox(
                              height: 5,
                            ),
                            if (applicantProfile.userSkills == null)
                              CFont.small('Not available yet',
                                  color: CColor.black)
                            else
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.5),
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics: const BouncingScrollPhysics(),
                                    itemCount:
                                        applicantProfile.userSkills!.length,
                                    itemBuilder: (context, index) {
                                      return Chip(
                                        padding: EdgeInsets.zero,
                                        label: CFont.small(
                                            applicantProfile.userSkills![index],
                                            color: CColor.black),
                                        backgroundColor: CColor.grey,
                                        shadowColor: CColor.black,
                                      );
                                    }),
                              )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  color: CColor.blue,
                  height: 1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
