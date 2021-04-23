class BasicModel {
  String fname;
  String lname;
  String contact;
  String email;
  String password;
  String cpassword;
  bool isMale;

  BasicModel(
      {this.fname,
      this.lname,
      this.contact,
      this.email,
      this.isMale,
      this.password,
      this.cpassword});

  factory BasicModel.fromJson(Map<String, dynamic> json) {
    return BasicModel(
        isMale: json['isMale'],
        fname: json['fname'],
        lname: json['lname'],
        contact: json['contact'],
        email: json['email'],
        password: json['password']);
  }
}
