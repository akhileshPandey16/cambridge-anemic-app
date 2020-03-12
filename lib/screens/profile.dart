import 'package:cambridge_anemic/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
Widget  _textLabelAndAnser(String answer){
 return Container(
   width: double.infinity,
   decoration: BoxDecoration(
     border: Border(
       bottom: BorderSide(
       )
     ),
   ),
   child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: <Widget>[
       Text(answer,style: kLabelStyle,),
       SizedBox(height: 5,)
     ],
   ),
 );
}
  @override
  Widget build(BuildContext context) {
    return  Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Text("PROFILE",style: kTitleStyle,),
              Center(
                child: CircleAvatar(
                  radius: 100,
                  child: Image.asset('nailBits.jpg'),
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _textLabelAndAnser("John Smith"),
                    SizedBox(height: 10,),
                    _textLabelAndAnser("Medical License: #458661NZ1"),
                    SizedBox(height: 10,),
                    _textLabelAndAnser("Email : doctor@hostpital.com"),
                    SizedBox(height: 10,),
                    _textLabelAndAnser("Contact : +91 883 050 3006"),
                    SizedBox(height: 10,),
                    _textLabelAndAnser("Clinic Address: 221B Baker Street"),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Total Patient Records",style: kLabelStyle,),
                        Icon(FontAwesomeIcons.userMd)
                      ],
                    ),
                    Center(child: Text("42",style: kTitleStyle,))



                  ],
                ),
              )
            ],
          );


  }
}
