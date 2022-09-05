import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employ/models/job_application_model.dart';
import 'package:employ/models/job_post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/employees_model.dart';

class EmployeeFirebaseService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  late EmployeeProfileModel myProfile;

  // creates user profile
  Future<void> insertUserProfile(EmployeeProfileModel data) {
    return db
        .collection('Employ-database')
        .doc('Employee-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(data.toMap());
  }

  Future<List<JobPostModel>> getAllJobPosts() async {
    return await db
        .collection('Employ-database')
        .doc('Job-Posts')
        .collection('JOBS')
        .get()
        .then((value) =>
            value.docs.map((e) => JobPostModel.fromJson(e.data())).toList());
  }

  bool validatesUserAsEmployee() {
    bool userIsAnEmployer = db
        .collection('Employ-database')
        .doc('Employee-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      return value
          .data()!['userIsAdmin']; // Access your after your get the data
    }) as bool;

    if (userIsAnEmployer == false) return true;
    return false;
  }

  // get stream of a company's profile info
  Stream<EmployeeProfileModel> getSpecificUserProfile() {
    return db
        .collection('Employ-database')
        .doc('Employee-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .snapshots()
        .map((snapshot) => EmployeeProfileModel.fromJson(snapshot.data()));
  }

  //get userprofile picture url
  Future<String?> getUserProfileUrl() async {
    EmployeeProfileModel userProfile = await db
        .collection('Employ-database')
        .doc('Employee-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) => EmployeeProfileModel.fromJson(value.data()));

    return userProfile.userProfilePhotoUrl;
  }

  // retrieve list of job applications
  Future<List<JobApplicationModel>> getListOfJobApplicantions(
      String jobPostId) async {
    List<JobApplicationModel> list = await db
        .collection('Employ-database')
        .doc('Job-Posts')
        .collection('JOBS')
        .doc(jobPostId)
        .collection('Job-applications')
        .get()
        .then((value) => value.docs
            .map((e) => JobApplicationModel.fromJson(e.data()))
            .toList());
    if (kDebugMode) {
      print(list);
    }
    return list;
  }

  // updates users photo
  void updateUserProfilePhotoUrl(String photoUrl) {
    final userProfilePhotoUrlRef = db
        .collection('Employ-database')
        .doc('Employee-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    userProfilePhotoUrlRef.update({"userProfilePhotoUrl": photoUrl}).then(
        (value) => print("DocumentSnapshot photo successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

// updates users name
  void updateUsersName(String newUserName) {
    final userNameRef = db
        .collection('Employ-database')
        .doc('Employee-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    userNameRef.update({"userName": newUserName}).then(
        (value) => print("DocumentSnapshot user name successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

// updates users location
  void updateUsersLocation(String newUserLocation) {
    final userProfilePhotoUrlRef = db
        .collection('Employ-database')
        .doc('Employee-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    userProfilePhotoUrlRef.update({"userLocation": newUserLocation}).then(
        (value) =>
            print("DocumentSnapshot user location successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

  // updates job model's application status
  void updatePostedJobApplicationStatus(String jobPostId,bool isThereANewJobApplication) {
    final jobPostRef = db
        .collection('Employ-database')
        .doc('Job-Posts')
        .collection('JOBS')
        .doc(jobPostId);
    jobPostRef.update({"hasNewJobApplication": isThereANewJobApplication}).then(
            (value) =>
            print("DocumentSnapshot hasNewJobApplication successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

// updates users description
  void updateUsersDescription(String newUserDescription) {
    final userProfileRef = db
        .collection('Employ-database')
        .doc('Employee-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    userProfileRef.update({"userDescription": newUserDescription}).then(
        (value) => print("DocumentSnapshot user name successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

// updates user skills
  void updateUsersSkills(List<String>? newUserSkills) {
    final userProfileRef = db
        .collection('Employ-database')
        .doc('Employee-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    userProfileRef.update({"userSkills": newUserSkills}).then(
        (value) => print("DocumentSnapshot user skill successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

// updates users phone number
  void updateUsersPhoneNumber(String newUserPhoneNumber) {
    final userProfileRef = db
        .collection('Employ-database')
        .doc('Employee-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    userProfileRef.update({"userPhoneNumber": newUserPhoneNumber}).then(
        (value) =>
            print("DocumentSnapshot user phone number successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

// updates users work experience
  void updateUsersWorkExperience(List<String>? newUserWorkExperience) {
    final userProfileRef = db
        .collection('Employ-database')
        .doc('Employee-profile')
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid);
    userProfileRef.update({"userWorkExperience": newUserWorkExperience}).then(
        (value) => print(
            "DocumentSnapshot user work experience successfully updated!"),
        onError: (e) => print("Error updating document $e"));
  }

// submit job application
  upsertJobApplication(JobApplicationModel jobApplication, String jobPostId) {
    var options = SetOptions(merge: true);

    return db
        .collection('Employ-database')
        .doc('Job-Posts')
        .collection('JOBS')
        .doc(jobPostId)
        .collection('Job-applications')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set(jobApplication.toMap(), options);
  }
}
