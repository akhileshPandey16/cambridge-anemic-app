import 'package:cambridge_anemic/constants.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
final String logInUrl='http://localhost:3000/v1/api/login';
final String signUpUrl='http://localhost:3000/v1/api/sign_up';
final String uploadUrl='http://localhost:3000/v1/api/upload';
final String getCountUrl='http://localhost:3000/v1/api/documents-count';

final storage = new FlutterSecureStorage();
Future getData(String url) async{
  return await http.get(url);
}
Future postData(String url) async{
  Map<String,String> headers={
    "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJha0BnbWFpbC5jb20iLCJpYXQiOjE1ODEzMjQ2NjV9.RKIGpxxeRn6z8Lu4uLFsq0RMvvDl3Z63MNmUyJ80HEw",
    "id":'1'
  };
//  headers.putIfAbsent('token', () => 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJha0BnbWFpbC5jb20iLCJpYXQiOjE1ODEzMjQ2NjV9.RKIGpxxeRn6z8Lu4uLFsq0RMvvDl3Z63MNmUyJ80HEw');
  return await http.post(url,headers: headers);
}
Future login(String email,String pass) async{
  try{
    http.Response res= await http.post(logInUrl,body: {
      "firstname":email,
      "password":pass
    });
    return res;
  }
  catch(e){
    print(e);
  }
}
Future signUp(Object userData) async{
  try{
    http.Response res= await http.post(signUpUrl,body:userData);
    return res;
  }
  catch(e){
    print(e);
  }
}

Future uploadImage(File imageFile,documents docType) async {
//  var dcount= await getDocumentCount();
//  print("Here");
//  dcount=jsonDecode(dcount);
//  print("Dcouint");
//  print(dcount);
//  var count=dcount['count'];
  // send
  try {
  // open a bytestream
  var stream = new http.ByteStream(
      DelegatingStream.typed(imageFile.openRead()));
  // get file length
  var length = await imageFile.length();
  // string to uri
  var uri = Uri.parse(uploadUrl);
  var ext=imageFile.path.split('.').last;
  String name="";
  docType==documents.bloodReportDocument?name="bloodReport":name="nailBitsImage";

  // create multipart request
  var request = new http.MultipartRequest("POST", uri);

  // multipart that takes file

  var multipartFile = new http.MultipartFile('file', stream, length,
      filename: basename("${docType}.${ext}"));
  // add file to multipart
  request.files.add(multipartFile);
  request.headers['token'] =
  'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiZW1haWwiOiJha0BnbWFpbC5jb20iLCJpYXQiOjE1ODI0ODczOTV9.6KDVzvQjKOtxhEYrnUh3vU-cSrDzIqYi5LQJlY3izMc';
  request.headers['id'] = '1';

  var response = await request.send();
  print(response.statusCode);

  // listen for response and message
  response.stream.transform(utf8.decoder).listen((value) {});
  return response.statusCode;
}
  catch(e){
    //Throw err connecting to network, ensure data is on
    print(e);
    return 500;
  }
}
Future getDocumentCount() async{
 try{
   var resp= await postData(getCountUrl);
   print("Response Returned Count");
   print(resp.body);
   print(resp.statusCode);
   return resp.body;
 }
 catch(e){
   print(e);
 }
}
Future getPreSignedUrl() async{

}
Future uploadOnPreSignedUrl() async{

}

getSnackBar(String text){
  return  SnackBar(
      content: Text(text),
      action: SnackBarAction(
          label: 'Okay',
          onPressed: () {
            // Some code to undo the change.
          }
      ));
}

