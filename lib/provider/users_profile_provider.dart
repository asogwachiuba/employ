import 'package:employ/firebase_service/employee_firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../models/employees_model.dart';

class UsersProfileProvider with ChangeNotifier {
  final employeeFirestoreService = EmployeeFirebaseService();
  late String employeeProfileUrl;
  late String employeeLocation;

  void provideEmployeesDetailsToUserProvider(
      String profileUrl, String location) {
    employeeProfileUrl = profileUrl;
  }

  createCompanyProfileInfo(
      String userName, String userPhoneNumber, String userLocation) {
    EmployeeProfileModel newCompanyProfile = EmployeeProfileModel(
        userId: FirebaseAuth.instance.currentUser?.uid,
        userPhoneNumber: userPhoneNumber,
        userMail: FirebaseAuth.instance.currentUser?.email,
        userName: userName,
        userLocation: userLocation);

    employeeFirestoreService.insertUserProfile(newCompanyProfile);
  }

  //User profile Getters
  Stream<EmployeeProfileModel> get userProfileInfo =>
      employeeFirestoreService.getSpecificUserProfile();

  bool validateUserIsAnEmployee() {
    return employeeFirestoreService.validatesUserAsEmployee();
  }

  uploadProfilePicture(String photoUrl) {
    employeeFirestoreService.updateUserProfilePhotoUrl(photoUrl);
  }

  updateUserName(String newUserName) {
    employeeFirestoreService.updateUsersName(newUserName);
  }

  updateUserLocation(String newLocation) {
    employeeFirestoreService.updateUsersLocation(newLocation);
  }

  updateUsersDescription(String newUsersDescription) {
    employeeFirestoreService.updateUsersDescription(newUsersDescription);
  }

  updateUserSkillSet(List<String>? newSkillSet) {
    employeeFirestoreService.updateUsersSkills(newSkillSet);
  }

  updateUserWorkExperience(List<String>? newWorkExperience) {
    employeeFirestoreService.updateUsersWorkExperience(newWorkExperience);
  }

  updateUserPhoneNumber(String newPhoneNumber) {
    employeeFirestoreService.updateUsersPhoneNumber(newPhoneNumber);
  }
}
