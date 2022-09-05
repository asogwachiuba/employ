import 'dart:io';
import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/models/employer_model.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:employ/utilities/show_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

import '../../../provider/company_profile_provider.dart';

class EmployerHomeTab extends StatefulWidget {
  const EmployerHomeTab({Key? key}) : super(key: key);

  @override
  State<EmployerHomeTab> createState() => _EmployerHomeTabState();
}

class _EmployerHomeTabState extends State<EmployerHomeTab> {
  File? _profileImage;
  File? _logoImage;
  final imagePicker = ImagePicker();
  String? profilePhotoDownloadUrl;
  String? logoDownloadUrl;
  final user = FirebaseAuth.instance.currentUser;

  Future profileImagePickerMethod() async {
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

  Future logoImagePickerMethod() async {
    // picking the file
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pick != null) {
        _logoImage = File(pick.path);
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
      Reference ref =
          FirebaseStorage.instance.ref().child("Employer/${user?.uid}/Profile-image");
      ref.delete();
      await ref.putFile(_profileImage!);
      profilePhotoDownloadUrl = await ref.getDownloadURL();
      if (kDebugMode) {
        print(profilePhotoDownloadUrl);
      }
    } else {
      showSnackBar('Image not uploaded', context,
          const Duration(milliseconds: 800), null);
    }
  }

  Future uploadLogoImage() async {
    if (_logoImage != null) {
      Reference ref =
          FirebaseStorage.instance.ref().child("Employer/${user?.uid}/Logo-image");
      ref.delete();
      await ref.putFile(_logoImage!);
      logoDownloadUrl = await ref.getDownloadURL();
      if (kDebugMode) {
        print(logoDownloadUrl);
      }
    } else {
      showSnackBar('Image not uploaded', context,
          const Duration(milliseconds: 800), null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final companyProfileProvider =
        Provider.of<CompanyProfileProvider>(context, listen: false);
    return StreamBuilder<EmployerProfileModel>(
        stream: companyProfileProvider.companyProfileInfo,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(),
              );

            case ConnectionState.done:
            default:
              if (snapshot.hasError) {
                final error = snapshot.error;
                return Center(
                    child: CFont.darkSecondary('This error occurred:  $error'));
              }

              if (snapshot.hasData) {

                return Container(
                  color: CColor.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Company Image
                              Container(
                                color: CColor.white,
                                height: 250,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      bottom: 50,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        color: CColor.grey,
                                        height: 250,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: snapshot.data
                                                    ?.companyProfilePhotoUrl ==
                                                null
                                            ? Stack(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                children: [
                                                  const Icon(
                                                    Icons.person,
                                                    size: 200,
                                                  ),
                                                  Positioned(
                                                      right: 0,
                                                      top: 0,
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          await profileImagePickerMethod();
                                                          await uploadProfileImage();
                                                          await companyProfileProvider
                                                              .uploadProfilePicture(
                                                                  profilePhotoDownloadUrl!);
                                                        },
                                                        child: const Icon(
                                                          Icons
                                                              .add_photo_alternate_outlined,
                                                          size: 80,
                                                        ),
                                                      ))
                                                ],
                                              )
                                            : GestureDetector(
                                                onTap: () async {
                                                  await profileImagePickerMethod();
                                                  await uploadProfileImage();
                                                  await companyProfileProvider
                                                      .uploadProfilePicture(
                                                          profilePhotoDownloadUrl!);
                                                },
                                                child: Image.network(
                                                  snapshot.data
                                                          ?.companyProfilePhotoUrl ??
                                                      '',
                                                  fit: BoxFit.fill,
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                )),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundColor: Colors.white,
                                        child: GestureDetector(
                                          onTap: () async {
                                            await logoImagePickerMethod();
                                            await uploadLogoImage();
                                            await companyProfileProvider
                                                .uploadLogoPicture(
                                                    logoDownloadUrl!);
                                          },
                                          child: CircleAvatar(
                                            radius: 40,
                                            backgroundColor: CColor.black,
                                            child:
                                                snapshot.data?.companyLogoUrl ==
                                                        null
                                                    ? const Icon(
                                                        Icons
                                                            .add_photo_alternate_rounded,
                                                        size: 30,
                                                      )
                                                    : ClipOval(
                                                        child: Image.network(
                                                        snapshot.data
                                                                ?.companyLogoUrl ??
                                                            '',
                                                        width: 200,
                                                        height: 200,
                                                        fit: BoxFit.cover,
                                                      )),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              // Company name
                              Center(
                                child: CFont.smallerPrimary(snapshot.data?.companyName ?? 'Update your company\'s name!!!'),
                              ),

                              const SizedBox(
                                height: 20,
                              ),

                              // Company details tab
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10, bottom: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Column(mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          CFont.small(snapshot.data?.companyLocation ?? 'Not updated', color: CColor.black),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CFont.small('Company Location'),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          CFont.small(snapshot.data?.companyIndustry ?? 'Not updated', color: CColor.black),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          CFont.small('Company Industry'),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Column(mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                            child: IconButton(
                                                padding: EdgeInsets.zero,
                                                onPressed: () {
                                              NavigationMethods().toLogOut(context);
                                            }, icon: const Icon(Icons.logout, size: 25,)),
                                          ),
                                          CFont.small('Sign Out'),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),

                              // contact information tile
                              Container(
                                  width: double.maxFinite,
                                  height: 2,
                                  color: CColor.black),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child:
                                    CFont.smallerPrimary('Contact Information'),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  children: [
                                    CFont.secondary('Email: '),
                                    CFont.secondary(snapshot.data?.companyMail ?? 'Not updated yet',
                                        color: CColor.black)
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  children: [
                                    CFont.secondary('Phone Number: '),
                                    CFont.secondary(snapshot.data?.companyPhoneNumber ?? 'Not updated yet',
                                        color: CColor.black)
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: double.maxFinite,
                                  height: 3,
                                  color: CColor.grey),

                              const SizedBox(
                                height: 10,
                              ),

                              // home tile
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: CFont.smallerPrimary('Home'),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: ConstrainedBox(
                                    child: CFont.small(
                                        snapshot.data?.companyDescription ?? 'Not updated yet. Please update your company\'s description',
                                        color: CColor.black,
                                        align: TextAlign.start),
                                    constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              0.8,
                                    )),
                              )
                            ],
                          ),
                        ),
                        Container(
                            width: double.maxFinite,
                            height: 3,
                            color: CColor.grey),
                      ],
                    ),
                  ),
                );
              }

              return Center(
                child: CFont.smallerPrimary('No data available yet!!!'),
              );
          }
        });
  }
}
