import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'package:user_data_from_api/app/data/model/data_model.dart';

import 'package:user_data_from_api/app/utils/object_factory.dart';
import 'package:user_data_from_api/app/utils/urls.dart';

class ApiProvider {
  Future<List<UserDetails>?> getUserDataList() async {
    final response = await ObjectFactory().apiClient.getUserDataList();

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.data);
      return userDetailsFromJson(json.encode(response.data));
    } else {
      return null;
    }
  }

  Future<UserDetails?> createUserData(Map data) async {
    var body = json.encode(data);
    const String apiUrl =
        "https://crudcrud.com/api/92a17cc329b945cc9dc2341754bf9f63/user_data";

    final response = await http.post(Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 201) {
      final String responseData = response.body;
      print(responseData);
    } else {
      int resCode = response.statusCode;
      print('data not inserted  $resCode');
      return null;
    }
  }

  Future<UserDetails?> updateUserData(Map data, String id) async {
    var body = json.encode(data);
    const String apiUrl =
        "https://crudcrud.com/api/92a17cc329b945cc9dc2341754bf9f63/user_data";

    final response = await http.put(Uri.parse('$apiUrl/' + '$id'),
        headers: {"Content-Type": "application/json"}, body: body);

    if (response.statusCode == 201) {
      final String responseData = response.body;
      print(responseData);
    } else {
      int resCode = response.statusCode;
      print('data not inserted  $resCode');
      return null;
    }
  }

  Future<http.Response> deleteUserData(String id) async {
    final http.Response response = await delete(
      Uri.parse(
          "https://crudcrud.com/api/92a17cc329b945cc9dc2341754bf9f63/user_data/$id"),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print("delete dtat");
    print(response.statusCode.toString());

    return response;
  }
}
