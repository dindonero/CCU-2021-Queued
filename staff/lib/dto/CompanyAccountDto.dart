class CompanyAccountDto {

  CompanyAccountDto({this.id, this.name, this.email, this.password, this.staffEmail, this.staffPassword});

  int id;

  String name;

  String email;

  String password;

  String staffEmail;

  String staffPassword;

  CompanyAccountDto.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.name = json['name'];
    this.email = json['email'];
    this.password = json['password'];
    this.staffEmail = json['staffEmail'];
    this.staffPassword = json['staffPassword'];
  }

  Map<String, dynamic> toJson(){
      return {'id': this.id.toString(), 'name': this.name, 'email': this.email, 'password': this.password, 'staffEmail': this.staffEmail, 'staffPassword': this.staffPassword};
  }


}
