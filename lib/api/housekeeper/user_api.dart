import 'dart:convert';

import 'package:housekeeper_front/api/housekeeper/response.dart';

import 'api.dart';
import 'package:http/http.dart' as http;

class UserApi {

  static signIn(String email, String password) async {
    var uri = Uri.parse('$api/user/signin');
    http.Response response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode({
        "email" : email,
        "password" : password
      }));

    return Response(
      status: response.statusCode,
      body: response.body,
    );
  }
}
