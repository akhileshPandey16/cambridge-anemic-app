import 'package:flutter/material.dart';
import '../constants.dart';
import '../services/network.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dashboard.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'signup.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  final username = TextEditingController();
  final password = TextEditingController();
  final storage = new FlutterSecureStorage();

  void initState() {
    readCredentials();
  }

  bool loading=false;
void readCredentials() async{
//  await storage.delete(key: "token");
  String value = await storage.read(key: "token");
  if(value==null){
    print("No credentials Found");
  }
  else{
    print("Credentials Found! Logging in the user");
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) => Dashboard(),
    ));
  }
}
void loginUser(BuildContext context) async{
    try{
      loading=true;
      print("Login pressed");
      var res =await login(username.text,password.text);

      if(res==null||res.statusCode!=200){
        setState(() {
          username.clear();
          password.clear();
          loading=false;
          Scaffold.of(context).showSnackBar(getSnackBar("Unable to login please check credentials or try later"));
          print("Faliure");
        });
      }
      else{
        {
          var data=jsonDecode(res.body);
          await storage.write(key:"token", value:data['token']);
          await storage.write(key:"email", value:username.text);
          await storage.write(key:"userId", value:data['id']);

          setState(() {
            loading=false;
            print("Success");
            Scaffold.of(context).showSnackBar(getSnackBar("Login Successfull"));
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Dashboard(),
            ));
          });
        }
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
        title: Text("LOGIN"),
      ),
      body:Builder(
        builder: (context)=>
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0,horizontal: 50.0),
              child:Form(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          controller:username,
                          decoration: InputDecoration(
                              hintText: "Email Id"
                          ),
                        ),
                        TextFormField(
                          controller: password,
                          decoration: InputDecoration(
                              hintText: "Password"
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
                              loginUser(context);
                            });
                          },
                          child: Text(
                              'LOGIN',
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
                            Text("Dont have an account? ",style:  kLabelStyle),
                            GestureDetector(
                              child: Text("Sign Up", style:  kLinkStyle,),
                              onTap: (){
                                print("Signup called from login");
                                Navigator.push(context,
                                    MaterialPageRoute(
                                      builder: (context)=>SignupScreen(),
                                    ));
                              },
                            )
                          ],
                        )
                      ]
                  )
              ),
            ),
      )

    );
  }
}
