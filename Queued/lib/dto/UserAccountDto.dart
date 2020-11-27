class UserAccountDto {

  const UserAccountDto({this.id, this.firstName, this.lastName, this.email, this.password, this.dateOfBirth});

  final int id;

  final String firstName;

  final String lastName;

  final String email;

  final String password;

  final DateTime dateOfBirth;

  factory UserAccountDto.fromJson(Map<String, dynamic> json) {
    return UserAccountDto(id: json['id'], firstName: json['firstName'], lastName: json['lastName'], email: json['email'], password: json['password'], dateOfBirth: json['dateOfBirth']);
  }

}
