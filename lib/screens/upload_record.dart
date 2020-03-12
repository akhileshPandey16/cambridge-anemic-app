import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cambridge_anemic/constants.dart';
import '../services/network.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'camera.dart';
class UploadRecordScreen extends StatefulWidget {
  @override
  _UploadRecordScreenState createState() => _UploadRecordScreenState();
}

class _UploadRecordScreenState extends State<UploadRecordScreen> {
  Future<Widget> getStateScreen() async{
    String value=await storage.read(key: "state");
    if(value==states.uploadBloodReport){
      return null;
    }
    else if(value==states.init){
      return null;
    }

  }


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(FontAwesomeIcons.userMd,size: 90.0,),
//          Text("Upload New Record",style: kLabelStyle,),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
              builder: (context) => LandingScreen(),
              ));
            },
            textColor: Colors.white,
            padding: const EdgeInsets.all(0.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(10.0),
              child: const Text(
                  'New Patient',
                  style: TextStyle(fontSize: 20)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
