
class JobPostModel {
  final String? employerName;
  final String? jobPostId;
  final String? jobTitle;
  final String? jobDescription;
  final String? salary;
  final String? employerId;
  final String? requiredWorkExperience;
  final String? requiredSkills;
  final String? jobIndustry;
  final String? jobType;
  final String? jobLocation;
  final String? jobApplicationDeadline;
  final String? employerLogoUrl;
  bool hasNewJobApplication;

  JobPostModel({
    required this.employerId,
    required this.jobApplicationDeadline,
    required this.jobLocation,
    required this.jobTitle,
    required this.jobDescription,
    required this.salary,
    required this.requiredWorkExperience,
    required this.jobType,
    required this.requiredSkills,
    required this.jobIndustry,
    required this.jobPostId,
    required this.employerName,
    required this.employerLogoUrl,
    this.hasNewJobApplication = false
  });

  factory JobPostModel.fromJson(Map<String, dynamic>? json) {
    return JobPostModel(
        jobTitle: json!['jobTitle'],
        employerName: json['employerName'],
        jobLocation: json['jobLocation'],
        employerId: json['employerId'],
        jobIndustry: json['jobIndustry'],
        jobApplicationDeadline: json['jobApplicationDeadline'],
        requiredSkills: json['requiredSkills'],
        jobType: json['jobType'],
        requiredWorkExperience: json['requiredWorkExperience'],
        jobDescription: json['jobDescription'],
        salary: json['salary'],
        jobPostId: json['jobPostId'],
        employerLogoUrl: json['employerLogoUrl'],
        hasNewJobApplication: json['hasNewJobApplication']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'jobTitle': jobTitle,
      'employerName': employerName,
      'employerId': employerId,
      'jobLocation': jobLocation,
      'jobIndustry': jobIndustry,
      'jobApplicationDeadline': jobApplicationDeadline,
      'requiredSkills': requiredSkills,
      'jobType': jobType,
      'requiredWorkExperience': requiredWorkExperience,
      'jobDescription': jobDescription,
      'salary': salary,
      'jobPostId': jobPostId,
      'employerLogoUrl': employerLogoUrl,
      'hasNewJobApplication': hasNewJobApplication
    };
  }

}
