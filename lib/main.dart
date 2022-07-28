import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:housekeeper_front/screen/dashboard_screen.dart';
import 'package:housekeeper_front/screen/logout_screen.dart';
import 'package:housekeeper_front/usecase/output.dart';
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
      title: 'HouseKeeper',
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

  String? storedEmail = "";
  String? accessToken = "";
  String? refreshToken = "";

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
    storedEmail = await storage.read(key: "storedEmail");
    accessToken = await storage.read(key: "accessToken");
    refreshToken = await storage.read(key: "refreshToken");

    if (accessToken != null) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => DashBoardScreen(accessToken: accessToken!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('images/icon.png', width: 75,),
              TextField(
                controller: idController,
                decoration: InputDecoration(labelText: '아이디'),
              ),
              TextField(
                controller: pwController,
                decoration: InputDecoration(labelText: '비밀번호'),
              ),
              Padding(padding: EdgeInsets.all(20.0)),
              RaisedButton(
                onPressed: () async {
                  var login = LoginUseCase(
                    id: idController.text.toString(),
                    pw: pwController.text.toString(),
                  );

                  LoginOutput response = await login.execute();
                  if (response.result) {
                    Navigator.pushReplacement(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => DashBoardScreen(accessToken: response.data.accessToken)
                        )
                    );
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(response.message))
                  );
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
