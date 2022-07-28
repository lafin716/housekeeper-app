
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:housekeeper_front/api/housekeeper/response.dart';
import 'package:housekeeper_front/api/housekeeper/user_api.dart';
import 'package:housekeeper_front/model/token_model.dart';
import 'package:housekeeper_front/usecase/input.dart';
import 'package:housekeeper_front/usecase/output.dart';
import 'package:housekeeper_front/usecase/usecase.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class LoginUseCase implements UseCase {
  late String id;
  late String pw;
  LoginUseCase({required this.id, required this.pw});

  @override
  Future<Output> execute() async {
    var input = LoginInput(id: id, pw: pw);
    input.validate();

    Response response = await UserApi.signIn(id, pw);
    if (!response.success) {
      return LoginOutput.fail(
          message: '회원 정보를 다시 확인해주세요.'
      );
    }
    var loginData = UserModel(
      type: response.data['type'],
      accessToken: response.data['accessToken'],
      refreshToken: response.data['refreshToken'],
      createdAt: response.data['createdAt'],
    );

    var storage = FlutterSecureStorage();
    await storage.write(key: 'ACCESS_TOKEN', value: loginData.accessToken);

    return LoginOutput.ok(
        message: '로그인 성공',
        data: response.data,
    );
  }
}

class LoginInput implements Input {
  late String id;
  late String pw;
  LoginInput({required this.id, required this.pw});

  @override
  bool validate() {
    if (id.isEmpty) throw Exception('아이디를 입력하세요.');
    if (pw.isEmpty) throw Exception('비밀번호를 입력하세요.');

    return true;
  }
}

class LoginOutput implements Output {
  bool result = false;
  String message = '로그인 정보를 다시 확인하세요.';
  Map data = {};

  LoginOutput.ok({required this.message, required this.data}) {
    result = true;
  }

  LoginOutput.fail({required this.message}) {
    result = false;
  }
}