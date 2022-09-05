
class EmployerProfileModel {
  final String? companyId;
  final String? companyProfilePhotoUrl;
  final String? companyLogoUrl;
  final String? companyName;
  final String? companyMail;
  final String? companyPhoneNumber;
  final String? companyIndustry;
  final String? companyDescription;
  final String? companyLocation;

  EmployerProfileModel({
    this.companyLocation,
    this.companyProfilePhotoUrl,
    this.companyLogoUrl,
    this.companyName,
    this.companyMail,
    this.companyPhoneNumber,
    this.companyIndustry,
    this.companyDescription,
    required this.companyId,
  });

factory EmployerProfileModel.fromJson(Map<String, dynamic>? json) {
  return EmployerProfileModel(
    companyName: json!['companyName'],
    companyLocation: json['companyLocation'],
    companyDescription: json['companyDescription'],
    companyIndustry: json['companyIndustry'],
    companyMail: json['companyMail'],
    companyPhoneNumber: json['companyPhoneNumber'],
    companyId: json['companyId'],
    companyLogoUrl: json['companyLogoUrl'],
    companyProfilePhotoUrl: json['companyProfilePhotoUrl'],
  );
}

Map<String, dynamic> toMap() {
  return {
    'companyLocation': companyLocation,
    'companyName': companyName,
    'companyDescription': companyDescription,
    'companyId': companyId,
    'companyIndustry': companyIndustry,
    'companyMail': companyMail,
    'companyPhoneNumber': companyPhoneNumber,
    'companyProfilePhotoUrl': companyProfilePhotoUrl,
    'companyLogoUrl': companyLogoUrl
  };
}

}
