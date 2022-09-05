class JobApplicationModel {
  final String? applicantName;
  final String? applicantPhoneNumber;
  final String? applicantMail;
  final String applicantResumeId;
  final String applicantUserId;
  final String? applicantProfileUrl;
  bool isSeenByEmployer;

  JobApplicationModel(
      {required this.applicantName,
      required this.applicantMail,
      required this.applicantPhoneNumber,
      required this.applicantResumeId,
      required this.applicantProfileUrl,
      this.isSeenByEmployer = false,
      required this.applicantUserId});

  factory JobApplicationModel.fromJson(Map<String, dynamic>? json) {
    return JobApplicationModel(
      applicantResumeId: json!['applicantResumeId'],
      applicantName: json['applicantName'],
      applicantPhoneNumber: json['applicantPhoneNumber'],
      applicantMail: json['applicantMail'],
      applicantProfileUrl: json['applicantProfileUrl'],
      isSeenByEmployer: json['isSeenByEmployer'],
        applicantUserId: json['applicantUserId']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'applicantName': applicantName,
      'applicantMail': applicantMail,
      'applicantPhoneNumber': applicantPhoneNumber,
      'applicantResumeId': applicantResumeId,
      'applicantProfileUrl': applicantProfileUrl,
      'isSeenByEmployer': isSeenByEmployer,
      'applicantUserId': applicantUserId
    };
  }
}
