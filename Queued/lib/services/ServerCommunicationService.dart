import 'dart:convert';

import 'package:Queued/app_screens/Exceptions/DataInException.dart';
import 'package:Queued/app_screens/Exceptions/EmailNotRegisteredException.dart';
import 'package:Queued/app_screens/Exceptions/WrongPasswordException.dart';
import 'package:Queued/dto/CategoryDto.dart';
import 'package:Queued/dto/StoreDto.dart';
import 'package:Queued/dto/TicketDto.dart';
import 'package:Queued/dto/UserAccountDto.dart';
import 'package:http/http.dart' as http;

import '../domain/category.dart';

class ServerCommunicationService {
  static String url = "http://85.244.139.60:8080";
  static String registerUrl = "/user/register";
  static String loginUrl = "/user/login";
  static String signinUrl = "/user/register";
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
    if (response.statusCode == 404) throw EmailNotRegisteredException();
    if (response.statusCode == 401) throw WrongPasswordException();
    throw DataInException("An unknown error occurred. Please try again later.");
  }

  static Future<UserAccountDto> createNewUserAccount(
      UserAccountDto newUserAccountDto) async {
    var user = json.encode(newUserAccountDto.toJson());
    var response =
        await http.post(url + signinUrl, body: user, headers: headers);
    if (response.statusCode == 201) {
      var responseJson = json.decode(response.body);
      return UserAccountDto.fromJson(responseJson);
    } else {
      throw DataInException("An error occured: Account already exists");
    }
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

  static Future<TicketDto> cancelUserTicketById(int ticketId) async {
    var response = await http.get(
        url + "/ticket/" + ticketId.toString() + "/cancel",
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 202) {
      return TicketDto.fromJson(json.decode(response.body));
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
}

