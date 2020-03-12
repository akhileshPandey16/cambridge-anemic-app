
import 'package:cambridge_anemic/constants.dart';
import 'package:cambridge_anemic/screens/camera.dart';
import 'profile.dart';
import 'package:flutter/material.dart';
import 'upload_record.dart';


class Dashboard extends StatelessWidget {
  Dashboard({this.cameras});
  var cameras;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.people)),
                Tab(icon: Icon(Icons.info),)
              ],
            ),
            title: Text('Dashboard'),
          ),
          body: TabBarView(
            children: [
              UploadRecordScreen(),
              ProfileScreen(),
            ],
          ),
        ),
      ),
    );
  }
}