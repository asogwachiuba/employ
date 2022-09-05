import 'package:employ/firebase_service/employer_firebase_service.dart';
import 'package:employ/models/employer_model.dart';
import 'package:employ/models/job_post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/employees_model.dart';

class CompanyProfileProvider with ChangeNotifier {
  final employerFirestoreService = EmployerFirebaseService();

  // Getter for a company profile
  Stream<EmployerProfileModel> get companyProfileInfo =>
      employerFirestoreService.getSpecificCompanyProfile();

  // Getter for company's posted jobs
  Future<List<JobPostModel>?> get companyJobPosts =>
      employerFirestoreService.getAllJobPostsOfCompany();

  // Provides applicants profile info
  Future<EmployeeProfileModel> applicantProfile(String userId) {
    return employerFirestoreService.getApplicantProfileInfo(userId);
  }

  // delete a job posted by company
  deleteSelectedJobPost(String jobPostId) {
    employerFirestoreService.deleteAJobPost(jobPostId);
  }

  // creates company's profile on signing up
  createCompanyProfileInfo(
    String companyName,
    String companyLocation,
    String companyPhoneNumber,
  ) {
    EmployerProfileModel newCompanyProfile = EmployerProfileModel(
      companyId: FirebaseAuth.instance.currentUser?.uid,
      companyPhoneNumber: companyPhoneNumber,
      companyMail: FirebaseAuth.instance.currentUser?.email,
      companyName: companyName,
      companyLocation: companyLocation,
      companyProfilePhotoUrl: FirebaseAuth.instance.currentUser?.photoURL,
    );

    employerFirestoreService.insertCompanyProfile(newCompanyProfile);
  }

  uploadProfilePicture(String photoUrl) {
    employerFirestoreService.updateCompanyProfilePhotoUrl(photoUrl);
  }

  uploadLogoPicture(String logoUrl) {
    employerFirestoreService.updateCompanyLogoUrl(logoUrl);
  }

  updateCompanyName(String companyName) {
    employerFirestoreService.updateCompanyName(companyName);
  }

  updateCompanyPhoneNumber(String companyPhoneNumber) {
    employerFirestoreService.updateCompanyPhoneNumber(companyPhoneNumber);
  }

  updateCompanyIndustry(String companyIndustry) {
    employerFirestoreService.updateCompanyIndustry(companyIndustry);
  }

  updateCompanyDescription(String companyDescription) {
    employerFirestoreService.updateCompanyDescription(companyDescription);
  }

  updateCompanyLocation(String companyLocation) {
    employerFirestoreService.updateCompanyLocation(companyLocation);
  }
}
