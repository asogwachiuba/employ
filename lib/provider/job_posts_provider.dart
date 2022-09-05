import 'package:employ/firebase_service/employee_firebase_service.dart';
import 'package:employ/models/job_application_model.dart';
import 'package:employ/models/job_post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../firebase_service/employer_firebase_service.dart';

class JobPostsProvider with ChangeNotifier {
  final employerFirestoreService = EmployerFirebaseService();
  final employeeFirestoreService = EmployeeFirebaseService();
  var uuid = const Uuid();

  // retrieves all job posts available
  Future<List<JobPostModel>> get listOfJobPosts async =>
      await EmployeeFirebaseService().getAllJobPosts();

  Future<String?> get companyLogoUrl async =>
      await employerFirestoreService.getCompanyLogoUrl();

  Future<String?> get companyProfileName async =>
      await employerFirestoreService.getCompanyName();

  Future<String?> getUserProfileUrl() async {
    String? userProfileUrl = await employeeFirestoreService.getUserProfileUrl();
    return userProfileUrl;
  }

  // Post a job
  uploadJobPost(
      String jobTitle,
      String jobDescription,
      String? salary,
      String requiredWorkExperience,
      String requiredSkills,
      String jobIndustry,
      String jobType,
      String jobApplicationDeadline,
      String jobLocation,
      String companyName) async {
    JobPostModel newJobPost = JobPostModel(
        employerName:
            companyName.isEmpty ? await companyProfileName : companyName,
        jobApplicationDeadline: jobApplicationDeadline,
        jobLocation: jobLocation,
        jobTitle: jobTitle,
        jobDescription: jobDescription,
        salary: salary,
        requiredWorkExperience: requiredWorkExperience,
        jobType: jobType,
        requiredSkills: requiredSkills,
        jobIndustry: jobIndustry,
        jobPostId: uuid.v1(),
        employerId: FirebaseAuth.instance.currentUser?.uid,
        employerLogoUrl: await companyLogoUrl);

    employerFirestoreService.upsertJobPost(newJobPost);
  }

  // submit job application
  Future<void> submitApplication(
      String jobPostId,
      String? applicantName,
      String? applicantPhoneNumber,
      String? applicantMail,
      String applicantResumeId) async {
    String? profileUrl = await getUserProfileUrl();
    JobApplicationModel newJobApplication = JobApplicationModel(
        applicantName: applicantName ?? 'Unavailable',
        applicantMail: applicantMail ?? 'Unavailable',
        applicantPhoneNumber: applicantPhoneNumber ?? 'Unavailable',
        applicantResumeId: applicantResumeId,
        applicantProfileUrl: profileUrl, applicantUserId: FirebaseAuth.instance.currentUser!.uid,
    );
    employeeFirestoreService.upsertJobApplication(newJobApplication, jobPostId);
  }

  // update job application isSeenByEmployer to true
  jobApplicationHasBeenViewed(
      String jobPostId, String applicantUserId) {
    employerFirestoreService.jobApplicationHasBeenViewed(
        jobPostId, applicantUserId);
  }

// updates job model application status for new job applications
  updateJobModelApplicationStatus(
      String jobPostId, bool newJobApplicationStatus) {
    employeeFirestoreService.updatePostedJobApplicationStatus(
        jobPostId, newJobApplicationStatus);
  }

  // retrieves list of job applications for a specific job post
  Future<List<JobApplicationModel>> getListOfJobApplications(
      String jobPostId) async {
    return await employeeFirestoreService.getListOfJobApplicantions(jobPostId);
  }

  Stream<List<JobApplicationModel>> listOfJobApplications(String jobPostId) {
    return employerFirestoreService.getJobApplications(jobPostId);
  }
}
