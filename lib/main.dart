import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:housekeeper_front/screen/logout_screen.dart';
import 'package:housekeeper_front/usecase/user/login_usecase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _LoginState();
}

class _LoginState extends State<MainPage> {
  late TextEditingController idController;
  late TextEditingController pwController;
  String? userInfo = "";

  static final storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwController = TextEditingController();

    // 비동기로 flutter secure storage 불러오는 작업
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    userInfo = await storage.read(key: "login");

    if (userInfo != null) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => LogoutScreen(
          id: userInfo!.split(" ")[1],
          pw: userInfo!.split(" ")[3],
        )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('타이틀'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: idController,
                decoration: InputDecoration(labelText: '아이디'),
              ),
              TextField(
                controller: pwController,
                decoration: InputDecoration(labelText: '비밀번호'),
              ),
              RaisedButton(
                onPressed: () async {

                  var login = LoginUseCase(
                    id: idController.text.toString(),
                    pw: pwController.text.toString(),
                  );

                  var response = await login.execute();
                  print(response);


                  var loginData = {
                    'id': idController.text.toString(),
                    'pw': pwController.text.toString()
                  };
                  await storage.write(
                      key: 'login',
                      value: jsonEncode(loginData),
                  );

                  Navigator.pushReplacement(context, CupertinoPageRoute(
                      builder: (context) => LogoutScreen(
                        id: idController.text,
                        pw: pwController.text,
                      )));
                },
                child: Text('로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
