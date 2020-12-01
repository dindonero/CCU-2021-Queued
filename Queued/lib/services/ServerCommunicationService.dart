import 'dart:convert';

import 'package:Queued/dto/CategoryDto.dart';
import 'package:Queued/dto/UserAccountDto.dart';
import 'package:http/http.dart' as http;

import '../domain/category.dart';

String url = "http://192.168.1.72:8080";
String registerUrl = "/user/register";
String loginUrl = "/user/login";
String categoriesUrl = "/category/getAll";
Map<String,String> headers = {
  'Content-type' : 'application/json',
  'Accept': 'application/json',
};

Future<UserAccountDto> loginUser(UserAccountDto userToLogin) async {
  var user = json.encode(userToLogin.toJson());
  var response = await http.post(url + loginUrl, body: user, headers: headers);
  if (response.statusCode == 200 || response.statusCode == 202) {
    var responseJson = json.decode(response.body);
    return UserAccountDto.fromJson(responseJson);
  }
}

Future<List<Category>> getAllCategories() async {
  var response = await http.get(url + categoriesUrl, headers: headers);
  if (response.statusCode == 200 || response.statusCode == 202) {
    List<dynamic> responseJson = json.decode(response.body);
    return responseJson.map((category) => CategoryDto.fromJson(category).toDomain()).toList();
  }
}