import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/models/job_application_model.dart';
import 'package:employ/provider/job_posts_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../utilities/navigation.dart';

class SubmittedJobApplication extends StatelessWidget {
  final String jobPostId;

  const SubmittedJobApplication({required this.jobPostId, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final JobPostsProvider jobPostsProvider =
        Provider.of<JobPostsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            // app bar
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      NavigationMethods().toPreviousPage(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                    ),
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  CFont.primary('JOB APPLICATIONS'),
                  const Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 2,
              color: CColor.grey,
            ),
            SingleChildScrollView(
              child: StreamBuilder(
                stream: jobPostsProvider.listOfJobApplications(jobPostId),
                builder: (BuildContext context,
                    AsyncSnapshot<List<JobApplicationModel>> snapshot) {
                  return snapshot.data == null ? Center(child: CFont.darkSecondary('No job applications yet')) : ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                              color: snapshot.data![index].isSeenByEmployer == false ? CColor.black : null,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    await jobPostsProvider.jobApplicationHasBeenViewed(jobPostId, snapshot.data![index].applicantUserId);
                                    NavigationMethods().toViewApplicationPage(context, snapshot.data![index], jobPostId);
                                  },
                                  child: Row(
                                    children: [
                                      snapshot.data![index].applicantProfileUrl == null ?
                                      CircleAvatar(
                                        backgroundColor: snapshot.data![index].isSeenByEmployer == false ? CColor.white : CColor.black,
                                        radius: 35,
                                        child: Icon(Icons.person, size: 50, color:snapshot.data![index].isSeenByEmployer == false ? CColor.black : CColor.white,),
                                      ) : ClipOval(
                                  child: Image.network(
                                          snapshot
                                              .data![index].applicantProfileUrl!,
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 20,),
                                      CFont.smallerPrimary(snapshot.data![index].applicantName == null ? 'Job Applicant' : snapshot.data![index].applicantName!,
                                      color: snapshot.data![index].isSeenByEmployer == false ? CColor.white : CColor.black,),
                                      const Spacer(flex: 1,),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 1,
                              color: snapshot.data![index].isSeenByEmployer == false ? CColor.white : CColor.grey,
                            ),
                          ],
                        );
                      });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
