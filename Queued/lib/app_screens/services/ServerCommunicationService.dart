import 'dart:convert';

import 'package:Queued/dto/UserAccountDto.dart';
import 'package:http/http.dart' as http;

String url = "http://192.168.1.72:8080";
String client = "/user";
String register = "/register";
String login = "/login";
Map<String,String> headers = {
  'Content-type' : 'application/json',
  'Accept': 'application/json',
};

Future<UserAccountDto> loginUser(UserAccountDto userToLogin) async {
  var user = json.encode(userToLogin.toJson());
  var response = await http.post(url + client + login, body: user, headers: headers);
  if (response.statusCode == 200 || response.statusCode == 202) {
    var responseJson = json.decode(response.body);
    return UserAccountDto.fromJson(responseJson);
  }
}
