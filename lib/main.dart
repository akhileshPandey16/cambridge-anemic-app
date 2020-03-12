import 'screens/login.dart';
import 'screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'services/network.dart';
List<CameraDescription> cameras;



main() {
//  getDocumentCount();
  runApp(Cambridge());
}

class Cambridge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      home: Dashboard(),
    );
  }
}


