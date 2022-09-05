import 'dart:io';

import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_icons.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:employ/widgets/custom_textfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../constants/custom_fonts.dart';
import '../../../models/employees_model.dart';
import '../../../provider/users_profile_provider.dart';
import '../../../utilities/show_snackbar.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _skillSetController = TextEditingController();
  final TextEditingController _workExperienceController =
      TextEditingController();

  File? _profileImage;
  final imagePicker = ImagePicker();
  String? profilePhotoDownloadUrl;
  final user = FirebaseAuth.instance.currentUser;
  int? _indexOfWorkExperienceToEdit;

  @override
  void dispose() {
    _nameController.dispose();
    _locationController.dispose();
    _aboutController.dispose();
    _skillSetController.dispose();
    _phoneNumberController.dispose();
    _workExperienceController.dispose();
    super.dispose();
  }

  // selects profile image from device
  Future pickProfileImage() async {
    // picking the file
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _profileImage = File(pick.path);
      } else {
        // show snackbar
        showSnackBar('No file selected', context,
            const Duration(milliseconds: 800), Colors.red);
      }
    });
  }

// uploading image to cloud storage,retrieving the download url and saving it to cloud firestore
  Future uploadProfileImage() async {
    if (_profileImage != null) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("Employee/${user?.uid}/Profile-image");
      ref.delete();
      await ref.putFile(_profileImage!);
      profilePhotoDownloadUrl = await ref.getDownloadURL();
      // upload photo url to users data in firebase storage
      if (kDebugMode) {
        print(profilePhotoDownloadUrl);
      }
    } else {
      showSnackBar('Image not uploaded', context,
          const Duration(milliseconds: 800), Colors.red);
    }
  }

  // defines state of profile tabs
  bool _editNameTab = false;
  bool _editAboutCompanyTab = false;
  bool _editContactInformationTab = false;
  bool _editIndustryTab = false;
  bool _editWorkExperience = false;

  @override
  Widget build(BuildContext context) {
    var usersProfileProvider = Provider.of<UsersProfileProvider>(context);

    //deletes user work experience
    deleteSpecificUserWorkExperience(
        List<String>? listWorkExperience, int index) {
      listWorkExperience?.removeAt(index);
      usersProfileProvider.updateUserWorkExperience(listWorkExperience);
    }

    // updates users work experience
    updateSpecificWorkExperience(
      List<String>? listWorkExperience,
    ) {
      List<String>? _listOfWorkExperience = [];
      if (listWorkExperience != null)
        _listOfWorkExperience = listWorkExperience;
      if (_workExperienceController.text.isNotEmpty &&
          _indexOfWorkExperienceToEdit == null) {
        print('about to add to list');
        _listOfWorkExperience.add(_workExperienceController.text);
        print(_workExperienceController.text);
        usersProfileProvider.updateUserWorkExperience(_listOfWorkExperience);
      } else {
        if (_workExperienceController.text.isNotEmpty) {
          _listOfWorkExperience[_indexOfWorkExperienceToEdit!] =
              _workExperienceController.text;
          usersProfileProvider.updateUserWorkExperience(_listOfWorkExperience);
        }
      }
    }

    return StreamBuilder(
      stream: usersProfileProvider.userProfileInfo,
      builder:
          (BuildContext context, AsyncSnapshot<EmployeeProfileModel> snapshot) {
        List<String> skillSet =
            snapshot.data?.userSkills ?? ['Update your skill sets'];
        return Container(
          color: CColor.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  // App bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CFont.primary('Profile'),
                        const Spacer(
                          flex: 1,
                        ),
                        // IconButton(
                        //     onPressed: () {
                        //       NavigationMethods().toEmployeeSettingsPage(context);
                        //     },
                        //     icon: const Icon(Icons.settings_outlined)),
                        CFont.small('Sign Out'),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              NavigationMethods().toLogOut(context);
                              // NavigationMethods().toPreviousPage(context);
                              // NavigationMethods().toPreviousPage(context);
                            },
                            icon: const Icon(Icons.logout))
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                      width: double.maxFinite, height: 2, color: CColor.grey),

                  // profile name tab
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),

                    // profile name, location and photo tab
                    child: SizedBox(
                        height: 150,
                        width: MediaQuery.of(context).size.width,
                        child: _editNameTab == false
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  snapshot.data?.userProfilePhotoUrl == null
                                      ? GestureDetector(
                                          onTap: () async {
                                            await pickProfileImage();
                                            await uploadProfileImage();
                                            await usersProfileProvider
                                                .uploadProfilePicture(
                                                    profilePhotoDownloadUrl!);
                                          },
                                          child: const CircleAvatar(
                                            radius: 40,
                                            backgroundColor: CColor.black,
                                            child: Icon(
                                              Icons.person,
                                              color: CColor.white,
                                              size: 50,
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            await pickProfileImage();
                                            await uploadProfileImage();
                                            await usersProfileProvider
                                                .uploadProfilePicture(
                                                    profilePhotoDownloadUrl!);
                                          },
                                          child: ClipOval(
                                            child: Image.network(
                                              snapshot
                                                  .data!.userProfilePhotoUrl!,
                                              width: 80,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ConstrainedBox(
                                        constraints:
                                            const BoxConstraints(maxWidth: 250),
                                        child: CFont.smallerPrimary(
                                            snapshot.data?.userName ??
                                                'Not Available. Update your Profile Name',
                                            align: TextAlign.start),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      CFont.small(
                                          snapshot.data?.userLocation ??
                                              'Not Available. Update your Location',
                                          align: TextAlign.start),
                                    ],
                                  ),
                                  const Spacer(
                                    flex: 3,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _editNameTab = true;
                                        });
                                      },
                                      child: const Icon(Icons.edit)),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CField.general(
                                            controller: _nameController,
                                            hint: 'Edit name of company',
                                            onSubmit: (entry) {
                                              usersProfileProvider
                                                  .updateUserName(entry);
                                              _nameController.clear();
                                            }),
                                        CField.general(
                                          controller: _locationController,
                                          onSubmit: (entry) {
                                            usersProfileProvider
                                                .updateUserLocation(entry);
                                            _locationController.clear();
                                          },
                                          hint: 'Edit your location/Address',
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

                  Container(
                      width: double.maxFinite, height: 2, color: CColor.grey),

                  // about company tab
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width,
                            minHeight: 150),
                        child: _editAboutCompanyTab == false
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CFont.smallerPrimary('About',
                                          align: TextAlign.start),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.65),
                                        child: CFont.secondary(
                                            snapshot.data?.userDescription ??
                                                'Not Available. Update your personal Description',
                                            align: TextAlign.start,
                                            color: CColor.black,
                                        maxLines: 50),
                                      )
                                    ],
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _aboutController.text = snapshot.data!.userDescription!;
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Center(
                                      child: CField.large(
                                          controller: _aboutController,
                                          hint: 'Edit About', numberOfMaxCharacters: 200),
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          usersProfileProvider
                                              .updateUsersDescription(_aboutController.text);
                                          _aboutController.clear();
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

                  Container(
                      width: double.maxFinite, height: 2, color: CColor.grey),

                  // user work experience tab
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width,
                            minHeight: 250),
                        child: _editWorkExperience == false
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    CIcon.workExperinceIcon,
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CFont.smallerPrimary('Work Experience',
                                            align: TextAlign.start),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        snapshot.data?.userWorkExperience == null
                                            ? ConstrainedBox(
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.65),
                                                child: CFont.small(
                                                    'Not Available. Update your relevant work experiences for employers to view.\nUse  paragraph or numbering to highlight some specifics of your work experiences'),
                                              )
                                            : ListView.builder(
                                              itemCount: snapshot
                                                  .data
                                                  ?.userWorkExperience!
                                                  .length,
                                              shrinkWrap: true,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemBuilder: (context, index) =>
                                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      CFont.small(snapshot
                                                              .data!
                                                              .userWorkExperience![
                                                          index],align: TextAlign.start,maxLines: 100),
                                                      Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        children: [
                                                          Chip(
                                                            label: CFont.small(
                                                                'Delete',
                                                                color:
                                                                CColor.black),
                                                            deleteIcon:
                                                            const Icon(
                                                              Icons
                                                                  .delete_forever,
                                                              size: 25,
                                                            ),
                                                            onDeleted: () {
                                                              setState(() {
                                                                deleteSpecificUserWorkExperience(
                                                                    snapshot.data
                                                                        ?.userWorkExperience,
                                                                    index);
                                                              });
                                                            },
                                                            deleteIconColor:
                                                            CColor.red,
                                                            backgroundColor:
                                                            CColor.grey,
                                                          ),
                                                          Chip(
                                                            label: CFont.small(
                                                                'Edit',
                                                                color:
                                                                CColor.black),
                                                            deleteIcon:
                                                            const Icon(
                                                              Icons.edit,
                                                              size: 25,
                                                            ),
                                                            onDeleted: () {
                                                              setState(() {
                                                                _workExperienceController
                                                                    .text = snapshot
                                                                    .data!
                                                                    .userWorkExperience![
                                                                index];
                                                                _editWorkExperience =
                                                                true;
                                                                _indexOfWorkExperienceToEdit =
                                                                    index;
                                                              });
                                                            },
                                                            deleteIconColor:
                                                            CColor.white,
                                                            backgroundColor:
                                                            CColor.grey,
                                                          ),
                                                        ],
                                                      ),
                                                      Container(height: 1,color: CColor.black,),
                                                      const SizedBox(height: 15,)
                                                    ],
                                                  ),
                                            )
                                      ],
                                    ),
                                  ),

                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _editWorkExperience = true;
                                          _indexOfWorkExperienceToEdit = null;
                                        });
                                      },
                                      child: const Icon(Icons.add))
                                ],

                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Column(
                                      children: [
                                        CField.large(
                                            controller: _workExperienceController,
                                            hint: 'Edit your work experience',
                                        numberOfMaxCharacters: 500),
                                      ],
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          updateSpecificWorkExperience(
                                            snapshot.data?.userWorkExperience,
                                          );
                                          _workExperienceController.clear();
                                          _editWorkExperience = false;
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

                  Container(
                      width: double.maxFinite, height: 2, color: CColor.grey),

                  // Contact information tab
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SizedBox(
                        height: 150,
                        child: _editContactInformationTab == false
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    CIcon.contactIcon,
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                0.6),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CFont.smallerPrimary(
                                            'Contact Information',
                                            align: TextAlign.start),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ConstrainedBox(
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6),
                                          child: CFont.secondary(
                                              snapshot.data?.userMail ??
                                                  'Not Available. Update your contact information',
                                              align: TextAlign.start,
                                              color: CColor.black),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        CFont.secondary(
                                            snapshot.data?.userPhoneNumber ??
                                                'Not Available. Update your phone number',
                                            align: TextAlign.start,
                                            color: CColor.black)
                                      ],
                                    ),
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
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CField.general(
                                            controller: _phoneNumberController,
                                            hint: 'Edit Phone Number',
                                            onSubmit: (entry) {
                                              usersProfileProvider
                                                  .updateUserPhoneNumber(entry);
                                              _phoneNumberController.clear();
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
                                          usersProfileProvider
                                              .updateUserPhoneNumber(_phoneNumberController.text);
                                          _phoneNumberController.clear();
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

                  Container(
                      width: double.maxFinite, height: 2, color: CColor.grey),

                  // Industry tab
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        //height: 150,
                        child: _editIndustryTab == false
                            ? Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        CIcon.skillsIcon,
                                        width: 20,
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      CFont.smallerPrimary('Skill Set',
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
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: skillSet.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                              childAspectRatio: 5,
                                              maxCrossAxisExtent: 200),
                                      itemBuilder: (context, index) {
                                        return Chip(
                                            deleteIcon: const Icon(
                                              Icons.delete,
                                              size: 15,
                                            ),
                                            onDeleted: () {
                                              setState(() {
                                                skillSet.removeAt(index);
                                                usersProfileProvider
                                                    .updateUserSkillSet(
                                                        skillSet);
                                              });
                                            },
                                            label: CFont.small(skillSet[index],
                                                color: CColor.black));
                                      })
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,
                                    child: Center(
                                      child: CField.general(
                                          controller: _skillSetController,
                                          hint: 'Edit your skill set',
                                          onSubmit: (entry) {
                                            skillSet.add(entry);
                                            usersProfileProvider
                                                .updateUserSkillSet(skillSet);
                                            _skillSetController.clear();
                                          }),
                                    ),
                                  ),
                                  const Spacer(
                                    flex: 1,
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          skillSet.add(_skillSetController.text);
                                          usersProfileProvider
                                              .updateUserSkillSet(skillSet);
                                          _skillSetController.clear();
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
                  Container(
                      width: double.maxFinite, height: 2, color: CColor.grey),

                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
