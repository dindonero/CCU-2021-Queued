import 'dart:convert';
import 'dart:io';

import 'package:Queued/app_screens/Exceptions/DataInException.dart';
import 'package:Queued/app_screens/Exceptions/EmailNotRegisteredException.dart';
import 'package:Queued/app_screens/Exceptions/WrongPasswordException.dart';
import 'package:Queued/dto/CategoryDto.dart';
import 'package:Queued/dto/StoreDto.dart';
import 'package:Queued/dto/TicketDto.dart';
import 'package:Queued/dto/UserAccountDto.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../domain/category.dart';

class ServerCommunicationService {
  static String url = "https://85.243.201.25:8080";
  static String registerUrl = "/user/register";
  static String loginUrl = "/user/login";
  static String signinUrl = "/user/register";
  static String categoriesUrl = "/category/getAll";
  static Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<dynamic> sendRequestToServer(String url, dynamic headers, dynamic model) async {
    //uncomment this to add cert exception
    /*ByteData data = await rootBundle.load('lib/assets/medium.crt');
    SecurityContext context = SecurityContext.defaultContext;
    context.setTrustedCertificatesBytes(data.buffer.asUint8List());
    client = HttpClient(context: context);*/

    //this allows for any self signed cert
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String  host, int port) => true);

    HttpClientRequest request;
    if (model == null)
      request = await client.getUrl(Uri.parse(url));
    else
      request = await client.postUrl(Uri.parse(url));
    request.headers.add('Content-type', 'application/json');
    request.headers.add('Accept', 'application/json');
    if (model != null) request.add(utf8.encode(model));
    HttpClientResponse result = await request.close();

    return jsonDecode(await result.transform(utf8.decoder).join());
  }

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
    List<dynamic> response = await sendRequestToServer(url + categoriesUrl, headers, null);
    return response
        .map((category) => CategoryDto.fromJson(category).toDomain())
        .toList();
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

