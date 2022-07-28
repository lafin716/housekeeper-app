
import 'dart:convert';

class Response {
  bool success = false;
  late int status;
  String body;
  Map data = {};

  Response({required this.status, required this.body}) {
    if (status == 200) {
      success = true;
    }

    data = jsonDecode(body);
    success = data['result'];
  }
}