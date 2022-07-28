import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:housekeeper_front/main.dart';

class LogoutScreen extends StatefulWidget {
  final String id;
  final String pw;

  LogoutScreen({required this.id, required this.pw});

  @override
  State<LogoutScreen> createState() => _LogoutScreenState();
}

class _LogoutScreenState extends State<LogoutScreen> {
  static final storage = FlutterSecureStorage();
  late String id;
  late String pw;

  @override
  void initState() {
    super.initState();
    id = widget.id;
    pw = widget.pw;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그아웃'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('id : ' + id),
            Text('pw : ' + pw),
            RaisedButton(onPressed: () {
              storage.delete(key: 'login');
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(builder: (context) => MainPage())
              );
            },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
