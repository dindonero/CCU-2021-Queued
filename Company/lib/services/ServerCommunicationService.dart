import 'dart:convert';

import 'package:http/http.dart' as http;
import '../domain/store.dart';
import 'package:Company/dto/CompanyAccountDto.dart' show CompanyAccountDto;
import 'package:Company/dto/StoreDto.dart';
import 'package:Company/dto/ScheduleDto.dart';

String url = "http://192.168.1.5:8080";
String registerUrl = "/company/register";
String loginUrl = "/company/login";
String storesUrl = "/stores/getAll";
Map<String, String> headers = {
  'Content-type': 'application/json',
  'Accept': 'application/json',
};

Future<CompanyAccountDto> loginUser(CompanyAccountDto companyToLogin) async {
  var user = json.encode(companyToLogin.toJson());
  var response = await http.post(url + loginUrl, body: user, headers: headers);
  if (response.statusCode == 200 || response.statusCode == 202) {
    var responseJson = json.decode(response.body);
    return CompanyAccountDto.fromJson(responseJson);
  }
  return null;
}

Future<List<Store>> getAllStores() async {
  var response = await http.get(url + storesUrl, headers: headers);
  if (response.statusCode == 200 || response.statusCode == 202) {
    List<dynamic> responseJson = json.decode(response.body);
    return responseJson
        .map((category) => StoreDto.fromJson(category).toDomain())
        .toList();
  }
  return null;
}
/*
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
          "/user/" +
          userId.toString() +
          "/counter/" +
          counterId.toString() +
          "/new",
      headers: headers);
  if (response.statusCode == 200 || response.statusCode == 202) {
    return TicketDto.fromJson(json.decode(response.body));
  }
  return null;
}*/
