class ProfModel {
  String education;
  String passing;
  String grade;
  String experience;
  String designation;
  String domain;

  ProfModel(
      {this.education,
      this.passing,
      this.grade,
      this.experience,
      this.designation,
      this.domain});

  factory ProfModel.fromJson(Map<String, dynamic> json) {
    return ProfModel(
      designation: json['design'],
      domain: json['domain'],
      education: json['education'],
      experience: json['exp'],
      grade: json['grade'],
      passing: json['passing'],
    );
  }
}
