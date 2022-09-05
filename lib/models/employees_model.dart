
class EmployeeProfileModel {
  final String? userDescription;
  final String? userId;
  final String? userIsAdmin;
  final String? userLocation;
  final String? userMail;
  final String? userName;
  final String? userPhoneNumber;
  final String? userProfilePhotoUrl;
  final List<String>? userSkills;
  final List<String>? userWorkExperience;

  EmployeeProfileModel({
    this.userSkills,
    required this.userId,
    this.userIsAdmin,
    this.userLocation,
    this.userMail,
    this.userName,
    this.userPhoneNumber,
    this.userProfilePhotoUrl,
    this.userDescription,
    this.userWorkExperience
  });

  factory EmployeeProfileModel.fromJson(Map<String, dynamic>? json) {
    return EmployeeProfileModel(
      userLocation: json!['userLocation'],
      userSkills: json['userSkills'],
      userProfilePhotoUrl: json['userProfilePhotoUrl'],
      userPhoneNumber: json['userPhoneNumber'],
      userMail: json['userMail'],
      userName: json['userName'],
      userDescription: json['userDescription'],
      userIsAdmin: json['userIsAdmin'],
      userId: json['userId'],
      userWorkExperience: json['userWorkExperience'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userSkills': userSkills,
      'userLocation': userLocation,
      'userProfilePhotoUrl': userProfilePhotoUrl,
      'userDescription': userDescription,
      'userPhoneNumber': userPhoneNumber,
      'userMail': userMail,
      'userName': userName,
      'userId': userId,
      'userIsAdmin': userIsAdmin,
      'userWorkExperience': userWorkExperience
    };
  }

}
