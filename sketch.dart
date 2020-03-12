import 'package:path/path.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

final String getCountUrl='localhost:3000/v1/api/documents-count';
Future postData(String url) async{
  return await http.post(url);
}
Future getDocumentCount() async{
  try{
    var resp= await postData(getCountUrl);
    print("Response Returned Count");
    print(resp);
  }
  catch(e){
    print(e);
  }
}

main() {
  print("started");
}
