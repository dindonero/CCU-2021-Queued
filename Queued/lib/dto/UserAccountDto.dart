class UserAccountDto {

  UserAccountDto({this.id, this.firstName, this.lastName, this.email, this.password});

  int id;

  String firstName;

  String lastName;

  String email;

  String password;


  UserAccountDto.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.firstName = json['firstName'];
    this.lastName = json['lastName'];
    this.email = json['email'];
    this.password = json['password'];
  }

  Map<String, dynamic> toJson(){
      return {'id': this.id.toString(), 'firstName': this.firstName, 'lastName': this.lastName, 'email': this.email, 'password': this.password};
  }


}
