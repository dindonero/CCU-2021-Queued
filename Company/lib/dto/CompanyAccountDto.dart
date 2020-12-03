class CompanyAccountDto {
  CompanyAccountDto(this.id, this.companyName, this.email, this.password,
      this.secondaryEmail);

  int id;

  String companyName;

  String email;

  String password;

  DateTime secondaryEmail;

  CompanyAccountDto.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.companyName = json['companyName'];
    this.email = json['email'];
    this.password = json['password'];
    this.secondaryEmail = json['secondaryEmail'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id.toString(),
      'companyName': this.companyName,
      'email': this.email,
      'password': this.password,
      'secondaryEmail': this.secondaryEmail
    };
  }
}
