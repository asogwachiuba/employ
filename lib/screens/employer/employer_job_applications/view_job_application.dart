import 'dart:io';
import 'package:employ/constants/custom_colors.dart';
import 'package:employ/constants/custom_fonts.dart';
import 'package:employ/models/job_application_model.dart';
import 'package:employ/screens/employer/employer_job_applications/pdf_viewer_page.dart';
import 'package:employ/utilities/navigation.dart';
import 'package:employ/widgets/custom_buttons.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../../../provider/company_profile_provider.dart';

class ViewJobApplicationPage extends StatefulWidget {
  final JobApplicationModel selectedJobApplication;
 final  String jobPostId;

  const ViewJobApplicationPage(
      {required this.selectedJobApplication, required this.jobPostId, Key? key})
      : super(key: key);

  @override
  State<ViewJobApplicationPage> createState() => _ViewJobApplicationPageState();
}

class _ViewJobApplicationPageState extends State<ViewJobApplicationPage> {
  static Future<File?> loadFirebase(String url) async {
    try {
      final refPDF = FirebaseStorage.instance.ref().child(url);
      final bytes = await refPDF.getData();

      if (bytes != null) return _storeFile(url, bytes);
    } catch (e) {
      return null;
    }
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final companyProfileProvider = Provider.of<CompanyProfileProvider>(context);
    return Scaffold(
      backgroundColor: CColor.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  NavigationMethods().toPreviousPage(context);
                },
                child: const Icon(Icons.arrow_back_ios, size: 25,)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  widget.selectedJobApplication.applicantProfileUrl == null
                      ? const CircleAvatar(
                          backgroundColor: CColor.black,
                          radius: 50,
                          child: Icon(
                            Icons.person,
                            color: CColor.white,
                            size: 30,
                          ),
                        )
                      : ClipOval(
                          child: Image.network(
                            widget.selectedJobApplication.applicantProfileUrl!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                  const Spacer(
                    flex: 1,
                  ),
                  CFont.primary(
                      widget.selectedJobApplication.applicantName == null
                          ? ''
                          : widget.selectedJobApplication.applicantName!),
                  const Spacer(
                    flex: 1,
                  )
                ],
              ),
            ),
            Container(
              color: CColor.grey,
              height: 2,
            ),
            const SizedBox(
              height: 15,
            ),
            CFont.darkSecondary(widget
                        .selectedJobApplication.applicantPhoneNumber ==
                    null
                ? 'Phone Number: Not available '
                : 'Phone Number: ${widget.selectedJobApplication.applicantPhoneNumber!}'),
            const SizedBox(
              height: 5,
            ),
            CFont.darkSecondary(widget.selectedJobApplication.applicantMail ==
                    null
                ? 'Mail: Mail address is not available'
                : 'Mail: ${widget.selectedJobApplication.applicantMail!}'),
            const SizedBox(
              height: 15,
            ),
            Container(
              color: CColor.grey,
              height: 2,
            ),
            const SizedBox(
              height: 50,
            ),
            CButton.primary(
                text:
                    'Open ${widget.selectedJobApplication.applicantName} Resume',
                onPressed: () async {
                  final url =
                      'Resumes/${widget.jobPostId}/${widget.selectedJobApplication.applicantResumeId}${widget.selectedJobApplication.applicantMail}';
                  final file = await loadFirebase(url);
                  file != null ? openPDF(context, file) : null;
                }),
            const SizedBox(
              height: 50,
            ),
            CButton.primary(text: 'Check ${widget.selectedJobApplication.applicantName} profile', onPressed: () async {
              await NavigationMethods().toViewApplicantsProfilePage(context,await companyProfileProvider.applicantProfile(widget.selectedJobApplication.applicantUserId));
            })
          ],
        ),
      ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
  );
}
