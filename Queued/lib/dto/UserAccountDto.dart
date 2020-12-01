class UserAccountDto {

  UserAccountDto(this.id, this.firstName, this.lastName, this.email, this.password, this.dateOfBirth);

  int id;

  String firstName;

  String lastName;

  String email;

  String password;

  DateTime dateOfBirth;

  UserAccountDto.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.firstName = json['firstName'];
    this.lastName = json['lastName'];
    this.email = json['email'];
    this.password = json['password'];
    this.dateOfBirth = DateTime.fromMillisecondsSinceEpoch(json['dateOfBirth']);
  }

  Map<String, dynamic> toJson(){
      return {'id': this.id.toString(), 'firstName': this.firstName, 'lastName': this.lastName, 'email': this.email, 'password': this.password, 'dateOfBirth': this.dateOfBirth.toString()};
  }


}
