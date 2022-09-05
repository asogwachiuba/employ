import 'dart:io';

import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/provider/job_posts_provider.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:employ/widgets/custom_buttons.dart';
import 'package:employ/widgets/custom_formfield.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utilities/show_snackbar.dart';

class SubmitResume extends StatefulWidget {
  final String jobPostId;
  final String jobLocation;

  const SubmitResume({required this.jobPostId,required this.jobLocation, Key? key}) : super(key: key);

  @override
  State<SubmitResume> createState() => _SubmitResumeState();
}

class _SubmitResumeState extends State<SubmitResume> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _uploadResumeController = TextEditingController();
  final TextEditingController _employeeCurrentLocationController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _fullNameController.dispose();
    _mailController.dispose();
    _phoneNumberController.dispose();
    _uploadResumeController.dispose();
    _employeeCurrentLocationController.dispose();
  }

  String? _nameOfResume;

  File? _selectedResume;
  String? resumeId;
  bool isApplicationSubmitted = true;

  Future pickResume() async {
    // picking the file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'doc', 'docx']);
    setState(() {
      if (result != null) {
        _selectedResume = File(result.files.single.path.toString());
        _nameOfResume = result.names.toString();
        _uploadResumeController.text = _nameOfResume!;
      } else {
        // show snackbar
        showSnackBar('No file selected', context,
            const Duration(milliseconds: 800), Colors.red);
      }
    });
  }

// uploading resume to cloud storage,retrieving the download url
  Future uploadFile(JobPostsProvider jobProvider) async {
    if (_selectedResume != null) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child("Resumes/${widget.jobPostId}/$_nameOfResume${_mailController.text}");
      ref.delete();
      await ref.putFile(_selectedResume!);
      resumeId = await ref.getDownloadURL();
       await jobProvider.submitApplication(widget.jobPostId, _fullNameController.text,
          _phoneNumberController.text, _mailController.text, _nameOfResume!);
      successfullySubmitted();
      if (kDebugMode) {
        //print(resumeId);
      }
    } else {
      showSnackBar('Resume not uploaded', context,
          const Duration(milliseconds: 800), null);
    }
  }

  // updates application status
  void successfullySubmitted() {
    setState(() {
      isApplicationSubmitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final jobPostProvider = Provider.of<JobPostsProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              // App bar
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                    ),
                    onPressed: () {
                      NavigationMethods().toPreviousPage(context);
                    },
                  ),
                  const Spacer(
                    flex: 1,
                  ),
                  // IconButton(
                  //   onPressed: () {
                  //     NavigationMethods().toEmployeeSettingsPage(context);
                  //   },
                  //   icon: const Icon(
                  //     Icons.settings_outlined,
                  //     size: 35,
                  //   ),
                  // ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              ),

              const SizedBox(
                height: 15,
              ),

              // text heading
              Center(
                child: CFont.smallerPrimary('Add your contact information to apply',
                    color: CColor.black),
              ),
              const SizedBox(
                height: 25,
              ),

              // full name text field
              CustomFormField(
                  nameOfTextField: 'Full name',
                  hintText: 'Shina Ajoye',
                  controller: _fullNameController,
                  icon: Icons.person_outline_rounded),

              const SizedBox(
                height: 10,
              ),

              CustomFormField(
                  nameOfTextField: 'Your current location',
                  hintText: '7 street Name, nearest bustop or city',
                  controller: _employeeCurrentLocationController,
                  icon: Icons.person_outline_rounded),

              const SizedBox(
                height: 10,
              ),

              // email text field
              CustomFormField(
                  nameOfTextField: 'Email',
                  hintText: 'Shinaajoye@gmail.com',
                  controller: _mailController,
                  icon: Icons.mail_outline_rounded),

              const SizedBox(
                height: 10,
              ),

              // phone number text field
              CustomFormField(
                  nameOfTextField: 'Phone number',
                  hintText: '+2348087565463',
                  controller: _phoneNumberController,
                  icon: Icons.phone),

              const SizedBox(
                height: 10,
              ),

              // upload resume text field
              GestureDetector(
                onTap: () {
                  pickResume();
                },
                child: Stack(
                  children: [
                    CustomFormField(
                        nameOfTextField: 'Upload resume',
                        hintText: 'use a pdf, docx and doc',
                        controller: _uploadResumeController,
                        icon: Icons.create_new_folder),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 50,
                        color: Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              CButton.primary(
                  text: 'Submit',
                  onPressed: () async {
                    await uploadFile(jobPostProvider);
                    _uploadResumeController.clear();
                    _phoneNumberController.clear();
                    _fullNameController.clear();
                    _mailController.clear();
                    jobPostProvider.updateJobModelApplicationStatus(widget.jobPostId, true);
                    showSnackBar('Resume successfully submitted!!!', context, const Duration(microseconds: 1), CColor.blue);
                  }),

              const SizedBox(
                height: 30,
              ),

              isApplicationSubmitted == true
                  ? CButton.primary(
                      text: 'See Job Location',
                      onPressed: () {
                        if(_employeeCurrentLocationController.text.isNotEmpty) {
                          NavigationMethods().toMap(
                              context, widget.jobLocation, _employeeCurrentLocationController.text);
                        }
                        else {
                          showSnackBar(' Submit your application and fill in your current location', context, const Duration(milliseconds: 800), CColor.red)
                     ;
                        }
                      })
                  : const Text('Submit your application to see Job location')

            ]),
          ),
        ),
      ),
    );
  }
}
