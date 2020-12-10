import 'dart:convert';

import 'package:Staff/dto/CompanyAccountDto.dart';
import 'package:Staff/dto/StoreDto.dart';
import 'package:Staff/dto/CounterDto.dart';
import 'package:http/http.dart' as http;

class ServerCommunicationService {
  static String url = "http://192.168.1.9:8080";
  static String registerUrl = "/user/register";
  static String loginUrl = "/company/staff/login";
  static String categoriesUrl = "/category/getAll";
  static String storesUrl = "/stores/getAll";
  static String staffUrl = "/staff/getStores";
  static Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  static Future<CompanyAccountDto> loginStaff(
      CompanyAccountDto staffToLogin) async {
    var staff = json.encode(staffToLogin.toJson());
    var response =
        await http.post(url + loginUrl, body: staff, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 202) {
      var responseJson = json.decode(response.body);
      return CompanyAccountDto.fromJson(responseJson);
    }
    return null;
  }

  static Future<List<StoreDto>> getAllStoresFromStaffEmail(String email) async {
    var response =
        await http.post(url + staffUrl, body: email, headers: headers);
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


  static Future<CounterDto> staffNextTicket(int counterId, String staffCounter) async {
    print('start next ticket on server');
    var response = await http.get(url + "/ticket/counter/" + counterId.toString() + " /staffCounter/"+ staffCounter + "/next",
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 202) {
      return CounterDto.fromJson(json.decode(response.body));
    }
    print(response.statusCode);
    return null;
  }

  static Future<CounterDto> staffHasEnteredCounter(int counterId) async {
    var response = await http.get(url + "/counter/" + counterId.toString() + " /staff/enter",
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 202) {
      return CounterDto.fromJson(json.decode(response.body));
    }
    print(response.statusCode);
    return null;
  }

  static Future<CounterDto> staffHasLeftCounter(int counterId) async {
    var response = await http.get(url + "/counter/" + counterId.toString() + " /staff/leave",
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 202) {
      return CounterDto.fromJson(json.decode(response.body));
    }
    print(response.statusCode);
    return null;
  }

  static Future<CounterDto> getCounterId(int counterId) async {
    var response = await http.get(url + "/counter/" + counterId.toString(),
        headers: headers);
    if (response.statusCode == 200 || response.statusCode == 202) {
      return CounterDto.fromJson(json.decode(response.body));
    }
    print(response.statusCode);
    return null;
  }
}
