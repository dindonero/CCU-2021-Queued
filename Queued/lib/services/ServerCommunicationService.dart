import 'dart:convert';

import 'package:Queued/dto/CategoryDto.dart';
import 'package:Queued/dto/StoreDto.dart';
import 'package:Queued/dto/TicketDto.dart';
import 'package:Queued/dto/UserAccountDto.dart';
import 'package:http/http.dart' as http;

import '../domain/category.dart';

String url = "http://192.168.1.5:8080";
String registerUrl = "/user/register";
String loginUrl = "/user/login";
String categoriesUrl = "/category/getAll";
Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

Future<UserAccountDto> loginUser(UserAccountDto userToLogin) async {
  var user = json.encode(userToLogin.toJson());
  var response = await http.post(url + loginUrl, body: user, headers: headers);
  if (response.statusCode == 200 || response.statusCode == 202) {
    var responseJson = json.decode(response.body);
    return UserAccountDto.fromJson(responseJson);
  }
  return null;
}

Future<List<Category>> getAllCategories() async {
  var response = await http.get(url + categoriesUrl, headers: headers);
  if (response.statusCode == 200 || response.statusCode == 202) {
    List<dynamic> responseJson = json.decode(response.body);
    return responseJson
        .map((category) => CategoryDto.fromJson(category).toDomain())
        .toList();
  }
  return null;
}

Future<List<StoreDto>> getStoresFromCategory(int categoryId) async {
  var response = await http.get(
      url + "/category/" + categoryId.toString() + "/store",
      headers: headers);
  if (response.statusCode == 200 || response.statusCode == 202) {
    List<dynamic> responseJson = json.decode(response.body);
    return responseJson.map((store) => StoreDto.fromJson(store)).toList();
  }
  return null;
}

Future<TicketDto> getNewUserTicket(int userId, int counterId) async {
  var response = await http.get(
      url +
          "/ticket/user/" +
          userId.toString() +
          "/counter/" +
          counterId.toString() +
          "/new",
      headers: headers);
  if (response.statusCode == 200 || response.statusCode == 202) {
    return TicketDto.fromJson(json.decode(response.body));
  }
  return null;
}

Future<List<TicketDto>> getAllUserTickets(int userId) async {
  var response = await http.get(
      url +
          "/ticket/user/" +
          userId.toString(),
      headers: headers);
  if (response.statusCode == 200 || response.statusCode == 202) {
    List<dynamic> responseJson = json.decode(response.body);
    return responseJson.map((ticket) => TicketDto.fromJson(ticket)).toList();
  }
  return null;
}