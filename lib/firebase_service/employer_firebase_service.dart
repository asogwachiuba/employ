import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employ/models/employer_model.dart';
import 'package:employ/models/job_application_model.dart';
import 'package:employ/models/job_post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/employees_model.dart';

class EmployerFirebaseService {
  FirebaseFirestore db = FirebaseFirestore.instance;

  // get stream of companies profile info
  Stream<List<EmployerProfileModel>> getCompanyProfile() {
    return db
        .collection('Employ-database')
        .doc('Employer-profile')
        .collection('Users')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => EmployerProfileModel.fromJson(doc.data()))
            .toList());
  }

  // get stream of job applications
  Stream<List<JobApplicationModel>> getJobApplications(String jobPostId) {
    return db.collection('Employ-database')
        .doc('Job-Posts')
        .collection('JOBS')
        .doc(jobPostId)
        .collection('Job-applications')
        .snapshots()
        .map((snapshot) => snapshot.docs
    .map((doc) => JobApplicationModel.fromJson(doc.data())).toList());
  }

  // get stream of a company's profile info
  Stream<EmployerProfileModel> getSpecificCompanyProfile() {
    return db
        .collection('Employ-database')
        .doc('Employer-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .map((snapshot)  {
          EmployerProfileModel myProfileInfo = EmployerProfileModel.fromJson(snapshot.data());
          return myProfileInfo;});
  }


  //get list of jobs posted by company
  Future<List<JobPostModel>?> getAllJobPostsOfCompany() async {
    return await db
        .collection('Employ-database')
        .doc('Job-Posts')
        .collection('JOBS')
        .where('employerId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) =>
            value.docs.map((e) => JobPostModel.fromJson(e.data())).toList());
  }


  //get company logo url
  Future<String?> getCompanyLogoUrl() async {
    EmployerProfileModel companyProfile = await db
        .collection('Employ-database')
        .doc('Employer-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => EmployerProfileModel.fromJson(value.data()));

    return companyProfile.companyLogoUrl;
  }

  //get company name
  Future<String?> getCompanyName() async {
    EmployerProfileModel companyProfile = await db
        .collection('Employ-database')
        .doc('Employer-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => EmployerProfileModel.fromJson(value.data()));

    return companyProfile.companyName;
  }

  // delete a job post
  void deleteAJobPost(String jobPostId) {
    db
        .collection('Employ-database')
        .doc('Job-Posts')
        .collection('JOBS')
        .doc(jobPostId)
        .delete();
  }

  // Update company profile photo
  void updateCompanyProfilePhotoUrl(String photoUrl) {
    final companyProfilePhotoRef = db
        .collection('Employ-database')
        .doc('Employer-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    companyProfilePhotoRef.update({"companyProfilePhotoUrl": photoUrl}).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

  // Update company name
  void updateCompanyName(String companyName) {
    final companyNameRef = db
        .collection('Employ-database')
        .doc('Employer-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    companyNameRef.update({"companyName": companyName}).then(
        (value) =>
            print("Document Snapshot Company Name successfully updated!"),
        onError: (e) => print("Error updating document field $e"));
  }

  // Update company phone number
  void updateCompanyPhoneNumber(String companyPhoneNumber) {
    final companyPhoneNumberRef = db
        .collection('Employ-database')
        .doc('Employer-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    companyPhoneNumberRef
        .update({"companyPhoneNumber": companyPhoneNumber}).then(
            (value) => print(
                "Document Snapshot company PhoneNumber successfully updated!"),
            onError: (e) => print("Error updating document field $e"));
  }

  // Update company industry
  void updateCompanyIndustry(String companyIndustry) {
    final companyPhoneNumberRef = db
        .collection('Employ-database')
        .doc('Employer-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    companyPhoneNumberRef.update({"companyIndustry": companyIndustry}).then(
        (value) =>
            print("Document Snapshot company industry successfully updated!"),
        onError: (e) => print("Error updating document field $e"));
  }

  // Update company location
  void updateCompanyLocation(String companyLocation) {
    final companyLocationRef = db
        .collection('Employ-database')
        .doc('Employer-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    companyLocationRef.update({"companyLocation": companyLocation}).then(
        (value) =>
            print("Document Snapshot company location successfully updated!"),
        onError: (e) => print("Error updating document field $e"));
  }

  // Update company description
  void updateCompanyDescription(String companyDescription) {
    final companyDescriptionRef = db
        .collection('Employ-database')
        .doc('Employer-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    companyDescriptionRef
        .update({"companyDescription": companyDescription}).then(
            (value) => print(
                "Document Snapshot company industry successfully updated!"),
            onError: (e) => print("Error updating document field $e"));
  }

  // Update company logo photo
  void updateCompanyLogoUrl(String logoUrl) {
    final companyProfilePhotoRef = db
        .collection('Employ-database')
        .doc('Employer-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    companyProfilePhotoRef.update({"companyLogoUrl": logoUrl}).then(
        (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

  Future<void> insertCompanyProfile(EmployerProfileModel data) {
    return db
        .collection('Employ-database')
        .doc('Employer-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(data.toMap());
  }

// Post a job
  upsertJobPost(JobPostModel jobPost) {
    var options = SetOptions(merge: true);

    return db
        .collection('Employ-database')
        .doc('Job-Posts')
        .collection('JOBS')
        .doc(jobPost.jobPostId)
        .set(jobPost.toMap(), options);
  }

  // Update submitted job application isSeen state
  void jobApplicationHasBeenViewed(String jobPostId,String applicantUserId) {
    final jobApplicationRef = db
        .collection('Employ-database')
        .doc('Job-Posts')
        .collection('JOBS')
        .doc(jobPostId).collection('Job-applications').doc(applicantUserId);
    jobApplicationRef.update({"isSeenByEmployer": true }).then(
            (value) => print("DocumentSnapshot successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

  //get applicant profile info
  Future<EmployeeProfileModel> getApplicantProfileInfo(String userId) async {
    EmployeeProfileModel applicantProfile = await db
        .collection('Employ-database')
        .doc('Employee-profile')
        .collection('Users')
        .doc(userId)
        .get()
        .then((value) => EmployeeProfileModel.fromJson(value.data()));

    return applicantProfile;
  }
}
