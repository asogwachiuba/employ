import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_icons.dart';
import 'package:employ/models/employer_model.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:employ/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../constants/custom_fonts.dart';
import '../../../provider/company_profile_provider.dart';
import '../../../widgets/custom_buttons.dart';

class EmployerProfileInfo extends StatefulWidget {
  const EmployerProfileInfo({Key? key}) : super(key: key);

  @override
  State<EmployerProfileInfo> createState() => _EmployerProfileInfoState();
}

class _EmployerProfileInfoState extends State<EmployerProfileInfo> {
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController aboutCompanyController = TextEditingController();
  TextEditingController companyMailAddressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController industryController = TextEditingController();

  @override
  void dispose() {
    companyNameController.dispose();
    companyAddressController.dispose();
    aboutCompanyController.dispose();
    companyMailAddressController.dispose();
    industryController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  // defines state of profile tabs
  bool _editNameTab = false;
  bool _editAboutCompanyTab = false;
  bool _editContactInformationTab = false;
  bool _editIndustryTab = false;

  @override
  Widget build(BuildContext context) {
    var companyProfileProvider = Provider.of<CompanyProfileProvider>(context);

    return StreamBuilder(
      stream: companyProfileProvider.companyProfileInfo,
      builder: (BuildContext context, AsyncSnapshot<EmployerProfileModel> snapshot) {
        List<String> industry = [];
        industry.add(snapshot.data?.companyIndustry ?? 'Update your company\'s industry');

        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );

          case ConnectionState.done:
          default:
            if(snapshot.hasError) {
              final error = snapshot.error;
              return Center(
                  child: CFont.darkSecondary('This error occurred:  $error'));
            }

            if(snapshot.hasData) {
              return Container(
                color: CColor.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,      child: SingleChildScrollView(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 40),

                      // App bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CFont.primary('Profile'),
                            const Spacer(flex: 1,),
                            const Text('Logout'),
                            IconButton(onPressed:() {NavigationMethods().toLogOut(context);} , icon: const Icon(Icons.logout))
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(width: double.maxFinite, height: 2, color: CColor.grey),

                      // profile name tab
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SizedBox(
                            height: 150,
                            child: _editNameTab == false
                                ? Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                snapshot.data!.companyProfilePhotoUrl == null ? const CircleAvatar(
                                  radius: 40,
                                  backgroundColor: CColor.black,
                                  child: Icon(Icons.person, size: 30,),
                                ) : ClipOval(
                                  child: Image.network(snapshot.data!.companyProfilePhotoUrl!, fit: BoxFit.cover,width: 80,height: 80,),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CFont.smallerPrimary(snapshot.data!.companyName ?? 'Not Available. Update your Profile Name',
                                        align: TextAlign.start),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    CFont.small(snapshot.data!.companyLocation ?? 'Not Available. Update your Profile Name',
                                        align: TextAlign.start),
                                  ],
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _editNameTab = true;
                                      });
                                    },
                                    child: const Icon(Icons.edit))
                              ],
                            )
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CField.general(
                                          controller: companyNameController,
                                          hint: 'Edit name of company',
                                          onSubmit: (entry) {
                                            companyProfileProvider.updateCompanyName(entry);
                                            companyNameController.clear();
                                          }),
                                      CField.general(
                                        controller: companyAddressController,
                                        onSubmit: (entry) {
                                          companyProfileProvider.updateCompanyLocation(entry);
                                          companyAddressController.clear();
                                        },
                                        hint: 'Edit location of company',
                                      )
                                    ],
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _editNameTab = false;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.done,
                                      size: 30,
                                    )),
                                const SizedBox(
                                  width: 5,
                                )
                              ],
                            )),
                      ),

                      Container(width: double.maxFinite, height: 2, color: CColor.grey),

                      // about company tab
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, minHeight: 150),
                            child: _editAboutCompanyTab == false
                                ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  CIcon.profileAboutIcon,
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CFont.smallerPrimary('About',
                                        align: TextAlign.start),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
                                      child: CFont.secondary(snapshot.data!.companyDescription ?? 'Not Available. Update your Company Description',
                                          align: TextAlign.start,
                                          color: CColor.black),
                                    )
                                  ],
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _editAboutCompanyTab = true;
                                      });
                                    },
                                    child: const Icon(Icons.edit))
                              ],
                            )
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  child: Center(
                                    child: CField.general(
                                        controller: aboutCompanyController,
                                        hint: 'Edit Company\'s About',
                                        onSubmit: (entry) {
                                          companyProfileProvider.updateCompanyDescription(entry);
                                          aboutCompanyController.clear();
                                        }),
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _editAboutCompanyTab = false;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.done,
                                      size: 30,
                                    )),
                                const SizedBox(
                                  width: 5,
                                )
                              ],
                            )),
                      ),

                      Container(width: double.maxFinite, height: 2, color: CColor.grey),

                      // Contact information tab
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: SizedBox(
                            height: 150,
                            child: _editContactInformationTab == false
                                ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SvgPicture.asset(
                                  CIcon.contactIcon,
                                  width: 20,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CFont.smallerPrimary('Contact Information',
                                        align: TextAlign.start),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    CFont.secondary(snapshot.data!.companyMail ?? 'Not Available. Update your company contact information',
                                        align: TextAlign.start,
                                        color: CColor.black),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    CFont.secondary(snapshot.data!.companyPhoneNumber ?? 'Not Available. Update your contact information',
                                        align: TextAlign.start, color: CColor.black)
                                  ],
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _editContactInformationTab = true;
                                      });
                                    },
                                    child: const Icon(Icons.edit))
                              ],
                            )
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      CField.general(
                                          controller: companyMailAddressController,
                                          hint: 'Edit Company\'s Mail Address',
                                          onSubmit: (entry) {
                                            companyMailAddressController.clear();
                                          }),
                                      CField.general(
                                          controller: phoneNumberController,
                                          hint: 'Edit Phone Number',
                                          onSubmit: (entry) {
                                            companyProfileProvider.updateCompanyPhoneNumber(entry);
                                            phoneNumberController.clear();
                                          }),
                                    ],
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _editContactInformationTab = false;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.done,
                                      size: 30,
                                    )),
                                const SizedBox(
                                  width: 5,
                                )
                              ],
                            )),
                      ),

                      Container(width: double.maxFinite, height: 2, color: CColor.grey),

                      // Industry tab
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          //height: 150,
                            child: _editIndustryTab == false
                                ? Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      CIcon.skillsIcon,
                                      width: 20,
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    CFont.smallerPrimary('Industry',
                                        align: TextAlign.start),
                                    const Spacer(
                                      flex: 1,
                                    ),
                                    GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _editIndustryTab = true;
                                          });
                                        },
                                        child: const Icon(Icons.edit))
                                  ],
                                ),
                                GridView.builder(
                                    padding: EdgeInsets.zero,
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: industry.length,
                                    gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        childAspectRatio: 5,
                                        maxCrossAxisExtent: 200),
                                    itemBuilder: (context, index) {
                                      return Chip(
                                          deleteIcon: const Icon(Icons.delete,size: 15,),
                                          onDeleted: () {
                                            setState(() {
                                              industry.removeAt(index);
                                            });
                                          },
                                          label: CFont.small(industry[index],
                                              color: CColor.black));
                                    })
                              ],
                            )
                                : Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.7,
                                  child: Center(
                                    child: CField.general(
                                        controller: industryController,
                                        hint: 'Edit Company Industry',
                                        onSubmit: (entry) {
                                          companyProfileProvider.updateCompanyIndustry(entry);
                                          industryController.clear();
                                        }),
                                  ),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _editIndustryTab = false;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.done,
                                      size: 30,
                                    )),
                                const SizedBox(
                                  width: 5,
                                )
                              ],
                            )),
                      ),
                      Container(width: double.maxFinite, height: 2, color: CColor.grey),

                      const SizedBox(
                        height: 100,
                      ),

                      // Post a job button
                      CButton.primary(
                          text: 'Post a job',
                          onPressed: () {
                            NavigationMethods().toEmployerJobPostPage(context, null);
                          }),
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ),
              );
            }

            return Center(
              child: CFont.smallerPrimary('No data available yet!!!'),
            );
        }

      },
    );
  }
}
