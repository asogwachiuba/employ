import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/constants/custom_icons.dart';
import 'package:employ/models/job_post_model.dart';
import 'package:employ/provider/job_posts_provider.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EmployeeHomeTab extends StatefulWidget {
  const EmployeeHomeTab({Key? key}) : super(key: key);

  @override
  State<EmployeeHomeTab> createState() => _EmployeeHomeTabState();
}

class _EmployeeHomeTabState extends State<EmployeeHomeTab> {
  final TextEditingController _searchBarController = TextEditingController();
  List<JobPostModel> displayList = [];
  List<JobPostModel> fullList = [];
  List<JobPostModel> listOfSearchResult = [];

  // represents state of the search bar
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    var jobPostsProvider = Provider.of<JobPostsProvider>(context);
    return Container(
      color: CColor.white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                // App bar
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        NavigationMethods().toLogOut(context);
                      },
                      child: const Icon(
                        Icons.logout,
                        size: 25,
                      ),
                    ),
                    const SizedBox(width: 5,),
                    CFont.small('Sign Out'),

                    const Spacer(
                      flex: 1,
                    ),
                    CFont.primary('Available Jobs'),
                    const Spacer(
                      flex: 1,
                    ),
                    // IconButton(
                    //     onPressed: () {
                    //       NavigationMethods().toEmployeeSettingsPage(context);
                    //     },
                    //     icon: const Icon(
                    //       Icons.settings_outlined,
                    //       size: 25,
                    //     )),
                  ],
                ),

                const SizedBox(
                  height: 30,
                ),

                // search bar
                Card(
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: CColor.grey, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                  ),
                  shadowColor: CColor.black,
                  elevation: 5,
                  child: TextField(
                    onSubmitted: (searchKeyword) {
                      setState(() {
                        jobSearch(searchKeyword);
                      });
                    },
                    controller: _searchBarController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(top: 15),
                        prefixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              jobSearch(_searchBarController.text);
                            });
                          },
                          child: const Icon(
                            Icons.search,
                            color: CColor.grey,
                            size: 20,
                          ),
                        ),
                        border: InputBorder.none,
                        hintTextDirection: TextDirection.ltr,
                        hintText: '              Find your next remote job',
                        hintStyle: const TextStyle(
                          color: CColor.grey,
                        )),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),

          Container(width: double.maxFinite, height: 3, color: CColor.grey),

          const SizedBox(
            height: 30,
          ),

          //list of job offers
          FutureBuilder<List<JobPostModel>>(
              future: jobPostsProvider.listOfJobPosts,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator(
                      color: CColor.black,
                    );

                  case ConnectionState.done:
                  default:
                    if (snapshot.hasError) {
                      final error = snapshot.error;
                      return Center(
                        child: Text('This error occurred: $error'),
                      );
                    }

                    if (snapshot.hasData) {
                      fullList = snapshot.data ??
                          [
                            JobPostModel(
                                employerId: 'To be posted',
                                jobApplicationDeadline: 'To be uploaded',
                                jobLocation: 'To be uploaded',
                                jobTitle: 'To be uploaded',
                                jobDescription: 'To be uploaded',
                                salary: 'To be uploaded',
                                requiredWorkExperience: 'To be uploaded',
                                jobType: 'To be uploaded',
                                requiredSkills: 'To be uploaded',
                                jobIndustry: 'To be uploaded',
                                jobPostId: 'To be uploaded',
                                employerName: 'To be uploaded',
                                employerLogoUrl: '')
                          ];

                      isSearching == false
                          ? displayList = fullList
                          : displayList = listOfSearchResult;
                      return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: displayList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0, bottom: 15),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    NavigationMethods().toJobDetails(
                                        context, displayList[index]);
                                  });
                                },
                                child: Card(
                                  shape: const RoundedRectangleBorder(
                                    side: BorderSide(
                                        color: CColor.grey, width: 2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
                                  ),
                                  shadowColor: CColor.black,
                                  elevation: 15,
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            ConstrainedBox(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.5),
                                              child: CFont.smallerPrimary(
                                                  displayList[index].jobTitle ??
                                                      'No Job Title'),
                                            ),
                                            const Spacer(
                                              flex: 1,
                                            ),
                                            Container(
                                              color: CColor.grey,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      CIcon.workExperinceIcon,
                                                      width: 15,
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    ConstrainedBox(
                                                      constraints: BoxConstraints(
                                                          maxWidth: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.2),
                                                      child:
                                                          SingleChildScrollView(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        child: CFont.small(
                                                            displayList[index]
                                                                    .jobType ??
                                                                'No Job-type',
                                                            color:
                                                                CColor.black),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            if (displayList[index]
                                                    .employerLogoUrl ==
                                                null)
                                              const SizedBox(
                                                width: 0,
                                              )
                                            else
                                              ClipOval(
                                                child: Image.network(
                                                  displayList[index]
                                                      .employerLogoUrl!,
                                                  fit: BoxFit.cover,
                                                  width: 50,
                                                  height: 50,
                                                ),
                                              ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            CFont.secondary(
                                                displayList[index]
                                                        .employerName ??
                                                    'To be uploaded',
                                                color: CColor.blue),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            CFont.small('Job Location:   ',
                                                color: CColor.black),
                                            CFont.secondary(
                                              displayList[index].jobLocation ??
                                                  'Company location not available',
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            CFont.small(
                                                'Application deadline:   ',
                                                color: CColor.black),
                                            CFont.secondary(
                                                displayList[index]
                                                        .jobApplicationDeadline ??
                                                    'Application deadline not available',
                                                color: CColor.red),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          });
                    }

                    return const Text("No data available yet");
                }
              })
        ],
      ),
    );
  }

  void jobSearch(String searchKeyword) {
    searchKeyword.isEmpty
        ? {isSearching = false}
        : {
            listOfSearchResult = fullList
                .where((element) => element.jobTitle!
                    .toLowerCase()
                    .contains(searchKeyword.toLowerCase()))
                .toList(),
            isSearching = true
          };
  }
}
