import 'dart:convert';

import 'package:Company/dto/CategoryDto.dart';
import 'package:Company/dto/StoreDto.dart';
import 'package:Company/dto/TicketDto.dart';
import 'package:Company/dto/UserAccountDto.dart';
import 'package:http/http.dart' as http;

import '../domain/category.dart';
import '../dto/StoreDto.dart';
import '../dto/StoreDto.dart';

class ServerCommunicationService {
  static String url = "http://192.168.1.109:8080";
  static String registerUrl = "/user/register";
  static String loginUrl = "/user/login";
  static String categoriesUrl = "/category/getAll";
  static Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<UserAccountDto> loginUser(UserAccountDto userToLogin) async {
    var user = json.encode(userToLogin.toJson());
    var response =
        await http.post(url + loginUrl, body: user, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 202) {
      var responseJson = json.decode(response.body);
      return UserAccountDto.fromJson(responseJson);
    }
    return null;
  }

  static Future<List<Category>> getAllCategories() async {
    var response = await http.get(url + categoriesUrl, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 202) {
      List<dynamic> responseJson = json.decode(response.body);
      return responseJson
          .map((category) => CategoryDto.fromJson(category).toDomain())
          .toList();
    }
    return null;
  }

  static Future<List<StoreDto>> getStoresFromCategory(int categoryId) async {
    var response = await http.get(
        url + "/category/" + categoryId.toString() + "/store",
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 202) {
      List<dynamic> responseJson = json.decode(response.body);
      return responseJson.map((store) => StoreDto.fromJson(store)).toList();
    }
    return null;
  }

  static Future<TicketDto> getNewUserTicket(int userId, int counterId) async {
    var response = await http.get(
        url +
            "/ticket/user/" +
            userId.toString() +
            "/counter/" +
            counterId.toString() +
            "/new",
        headers: headers);
    if (response.statusCode == 201) {
      return TicketDto.fromJson(json.decode(response.body));
    }
    return null;
  }

  static Future<List<TicketDto>> getAllUserTickets(int userId) async {
    var response = await http.get(url + "/ticket/user/" + userId.toString(),
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 202) {
      List<dynamic> responseJson = json.decode(response.body);
      return responseJson.map((ticket) => TicketDto.fromJson(ticket)).toList();
    }
    return null;
  }

  static Future<List<StoreDto>> getAllCompanyStores(int companyId) async {
    var response = await http.get(url + "/company/" + companyId.toString(),
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 202) {
      List<dynamic> responseJson = json.decode(response.body);
      return responseJson.map((store) => StoreDto.fromJson(store)).toList();
    }
    return null;
  }

  static Future<List<StoreDto>> findStoresByName(String name) async {
    var response = await http.get(url + "/searchStores/" + name.toString(),
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 202) {
      List<dynamic> responseJson = json.decode(response.body);
      return responseJson.map((store) => StoreDto.fromJson(store)).toList();
    }
    return null;
  }

  static Future<int> addNewStore(int companyId, StoreDto store) async {
    var jsonBody = json.encode(store.toJson());
    var response = await http.post(url + "/company/" + companyId.toString() + "/store/register",
        body: jsonBody, headers: headers);
    if (response.statusCode == 201) {
      return json.decode(response.body);
    }
    return null;
  }
}
