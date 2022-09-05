enum UserType {
  employee,
  employer,
}

class UsersEducationModel{
  String nameOfSchool;
  String degree;
  String fieldOfStudy;
  String duration;
  String grade;

  UsersEducationModel({
    required this.nameOfSchool,
    required this.degree,
    required this.fieldOfStudy,
    required this.duration,
    required this.grade
  });
}


class UsersWorkExperienceModel{
  String? nameOfCompany;
  String? companyAddress;
  String? positionInCompany;
  String? durationOfWork;
  String? jobDescription;

  UsersWorkExperienceModel({
    this.nameOfCompany,
    this.companyAddress,
    this.positionInCompany,
    this.durationOfWork,
    this.jobDescription
  });
}