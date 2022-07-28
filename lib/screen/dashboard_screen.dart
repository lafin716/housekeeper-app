import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:footer/footer.dart';

class DashBoardScreen extends StatefulWidget {
  late String accessToken;

  DashBoardScreen({required this.accessToken});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  Map<String, bool> selected = {
    'dashboard': true,
    'building': false,
    'room': false,
    'stuff': false,
  };

  void selectMenu(String key) {
    selected.forEach((key, value) => selected[key] = false);
    selected[key] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('대시보드'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 100.0,
              child: DrawerHeader(
                child: Center(
                  child:
                    Text(
                      'HouseKeeper',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
            ),
            ListTile(
              title: Text('대시보드'),
              onTap: () { selectMenu('dashboard'); },
              selected: true,
            ),
            ListTile(
              title: Text('건물관리'),
              onTap: () { selectMenu('building'); },
              selected: false,
            ),
            ListTile(
              title: Text('방 관리'),
              onTap: () { selectMenu('room'); },
              selected: false,
            ),
            ListTile(
              title: Text('물건 관리'),
              onTap: () { selectMenu('stuff'); },
              selected: false,
            ),
          ],
        ),
      ),
    );
  }
}
