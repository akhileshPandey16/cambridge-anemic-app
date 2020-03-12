
import 'package:flutter/material.dart';
import '../constants.dart';
import '../services/network.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'login.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}



class _SignupScreenState extends State<SignupScreen> {
  @override
  final firstname = TextEditingController();
  final lastname = TextEditingController();
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final storage = new FlutterSecureStorage();


  bool loading=false;


//  HashMap fillHasmap(){
//    userData.putIfAbsent('firstname', () => firstname.text);
//    userData.putIfAbsent('lastname', () => lastname.text);
//    userData.putIfAbsent('email', () => username.text);
//    userData.putIfAbsent('password', () => password.text);
//  }
  void signUpUser() async{
    try{
      loading=true;
      print("Signup pressed");
      Object userData={
        'firstname' : firstname.text,
        'lastname' : lastname.text,
        'email' : username.text,
        'password' : password.text
      };
      var res =await signUp(userData);
      print("Signup returned");
      if(res.statusCode==200){
        print("Body returned");
        var data=jsonDecode(res.body);
        print(data);
        setState(() {
          loading=false;
          print("Success");
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ));
        });
      }
      else{
        setState(() {
          username.clear();
          password.clear();
          loading=true;
          print("Faliure");
        });
      }
    }
    catch(e){
      print(e);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor,
      appBar: AppBar(
        title: Text("CREATE ACCOUNT"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 50.0),
        child:Form(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextFormField(
                    controller:firstname,
                    decoration: InputDecoration(
                        hintText: "First Name"
                    ),
                  ),
                  TextFormField(
                    controller:lastname,
                    decoration: InputDecoration(
                        hintText: "Last Name"
                    ),
                  ),
                  TextFormField(
                    controller:username,
                    decoration: InputDecoration(
                        hintText: "Email Id"
                    ),
                  ),
                  TextFormField(
                    controller: password,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password"
                    ),
                  ),
                  TextFormField(
                    controller: confirmPassword,
                    obscureText: false,
                    decoration: InputDecoration(
                        hintText: "Confirm Password"
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  RaisedButton(
                    elevation: 7,
                    textColor: Colors.black,
                    color: Colors.blue,
                    onPressed: () {
                      setState(() {
                        signUpUser();
                      });
                    },
                    child: Text(
                        'Create Account',
                      style: kButtonStyle,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Visibility(
                    child: SpinKitCubeGrid(
                      color: Colors.blueGrey,
                      size: 40.0,
                    ),
                    visible: loading,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account? ",style:  kLabelStyle),
                      GestureDetector(
                        child: Text("Log in", style:  kLinkStyle,),
                        onTap: (){
                          print("Login called from signup page");
                          Navigator.pop(context);

                        },
                      )
                    ],
                  )
                ]
            )
        ),
      ),
    );
  }
}
