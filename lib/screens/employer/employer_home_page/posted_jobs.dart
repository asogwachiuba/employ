import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_icons.dart';
import 'package:employ/models/job_post_model.dart';
import 'package:employ/provider/company_profile_provider.dart';
import 'package:employ/provider/job_posts_provider.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../constants/custom_fonts.dart';

class PostedJobs extends StatefulWidget {
  const PostedJobs({Key? key}) : super(key: key);

  @override
  State<PostedJobs> createState() => _PostedJobsState();
}

class _PostedJobsState extends State<PostedJobs> {
  @override
  Widget build(BuildContext context) {
    final companyProfileProvider = Provider.of<CompanyProfileProvider>(context);
    final jobPostProvider = Provider.of<JobPostsProvider>(context);

    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: CColor.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            CFont.primary('Posted Jobs'),
            const SizedBox(
              height: 20,
            ),

            // list of posted jobs
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: FutureBuilder<List<JobPostModel>?>(
                  future: companyProfileProvider.companyJobPosts,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(
                            color: CColor.black,
                            backgroundColor: CColor.white,
                          ),
                        );

                      case ConnectionState.done:
                      default:
                        if (snapshot.hasError) {
                          final error = snapshot.error;
                          return Expanded(
                            child: Center(
                              child: Text('This error occurred $error'),
                            ),
                          );
                        }

                        if (snapshot.hasData) {
                          return snapshot.data!.isEmpty
                              ? Center(
                                  child: CFont.secondary(
                                      'NO JOB HAS BEEN POSTED YET.\n Go to your profile to post jobs.'),
                                )
                              : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      margin: const EdgeInsets.all(30),
                                      shadowColor: CColor.black,
                                      elevation: 20,
                                      color: CColor.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ConstrainedBox(
                                        constraints: BoxConstraints(
                                          minHeight: 250,
                                          maxWidth: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          maxHeight: 400,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                        maxWidth: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5),
                                                    child: CFont.primary(
                                                        snapshot.data![index]
                                                                .jobTitle ??
                                                            'Unavailable'),
                                                  ),
                                                  const Spacer(
                                                    flex: 1,
                                                  ),
                                                  Container(
                                                    decoration: const BoxDecoration(
                                                        color: CColor.grey,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    10))),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10.0,
                                                              right: 10.0,
                                                              top: 5,
                                                              bottom: 5),
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                            CIcon
                                                                .workExperinceIcon,
                                                            width: 15,
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.15,
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: CFont.small(
                                                                  snapshot
                                                                          .data![
                                                                              index]
                                                                          .jobType ??
                                                                      'Unavailable',
                                                                  color: CColor
                                                                      .black),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              if (snapshot.data![index]
                                                  .employerLogoUrl!.isEmpty)
                                                const SizedBox(
                                                  height: 10,
                                                )
                                              else
                                                ClipOval(
                                                  child: Image.network(
                                                    snapshot.data![index]
                                                        .employerLogoUrl!,
                                                    fit: BoxFit.cover,
                                                    width: 50,
                                                    height: 50,
                                                  ),
                                                ),
                                              CFont.secondary(
                                                  snapshot.data![index]
                                                          .employerName ??
                                                      'Unavailable',
                                                  color: CColor.blue),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  CFont.small(
                                                      'LOCATION :     '),
                                                  CFont.secondary(
                                                      snapshot.data![index]
                                                              .jobLocation ??
                                                          'Unavailable',
                                                      color: CColor.black),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  CFont.small('SALARY :     '),
                                                  CFont.secondary(
                                                      snapshot.data![index]
                                                              .salary ??
                                                          'Unavailable',
                                                      color: CColor.black),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              CFont.small('SKILLS REQUIRED : ',
                                                  color: CColor.grey),
                                              ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    minWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.85,
                                                    maxHeight: 70),
                                                child: SingleChildScrollView(
                                                  child: CFont.secondary(
                                                      snapshot.data![index]
                                                              .requiredSkills ??
                                                          'Unavailable',
                                                      align: TextAlign.start,
                                                      color: CColor.black),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  CFont.small(
                                                      'Application Deadline : '),
                                                  const Spacer(
                                                    flex: 1,
                                                  ),
                                                  CFont.secondary(
                                                      snapshot.data![index]
                                                              .jobApplicationDeadline ??
                                                          'Unavailable',
                                                      color: CColor.red),
                                                ],
                                              ),
                                              const Spacer(
                                                flex: 1,
                                              ),
                                              Center(
                                                child: Wrap(
                                                  spacing: 8,
                                                  children: [
                                                    Chip(
                                                      label: CFont.small('Edit',
                                                          color: CColor.black),
                                                      deleteIcon: const Icon(
                                                        Icons.mode_edit_outline,
                                                        size: 20,
                                                      ),
                                                      elevation: 5,
                                                      deleteIconColor:
                                                          CColor.black,
                                                      onDeleted: () {
                                                        setState(() {
                                                       NavigationMethods().toEmployerJobPostPage(context, snapshot.data![index]);
                                                        });
                                                      },
                                                    ),
                                                    Chip(
                                                      label: CFont.small('Delete',
                                                          color: CColor.black),
                                                      deleteIcon: const Icon(
                                                        Icons.delete,
                                                        size: 20,
                                                      ),
                                                      elevation: 5,
                                                      deleteIconColor:
                                                      CColor.black,
                                                      onDeleted: () {
                                                        setState(() {
                                                          companyProfileProvider
                                                              .deleteSelectedJobPost(
                                                              snapshot
                                                                  .data![
                                                              index]
                                                                  .jobPostId!);
                                                        });
                                                      },
                                                    ),
                                                    Chip(
                                                      backgroundColor: snapshot
                                                                  .data![index]
                                                                  .hasNewJobApplication ==
                                                              false
                                                          ? null
                                                          : CColor.black,
                                                      label: CFont.small(
                                                          snapshot.data![index]
                                                                      .hasNewJobApplication ==
                                                                  false
                                                              ? 'Applications'
                                                              : 'New Application',
                                                          color: snapshot
                                                                      .data![
                                                                          index]
                                                                      .hasNewJobApplication ==
                                                                  false
                                                              ? CColor.black
                                                              : CColor.white),
                                                      elevation: 5,
                                                      deleteIcon: const Icon(
                                                          Icons.file_present,
                                                          size: 20),
                                                      deleteIconColor: snapshot
                                                                  .data![index]
                                                                  .hasNewJobApplication ==
                                                              false
                                                          ? CColor.black
                                                          : CColor.white,
                                                      onDeleted: () async {
                                                        // changes new application status of the selected job post to false
                                                        await jobPostProvider
                                                            .updateJobModelApplicationStatus(
                                                            snapshot
                                                                .data![index]
                                                                .jobPostId!,
                                                            false);
                                                        NavigationMethods()
                                                            .toEmployerSubmittedJobApplicationsPage(
                                                                context,
                                                                snapshot
                                                                    .data![index]
                                                                    .jobPostId!);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                        }
                    }

                    return const Text("No data available yet");
                  }),
            ),
            Container(width: double.maxFinite, height: 3, color: CColor.grey),
          ],
        ),
      ),
    );
  }
}
