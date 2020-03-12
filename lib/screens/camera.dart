import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cambridge_anemic/constants.dart';
import '../services/network.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  var nailBitsImage;
  double _spaceBt=100;
  bool nailUploadBtn=false;
  bool nailUploading=false;

  var bloodReportImage;
  bool bloodUploadBtn=false;
  bool bloodUploading=false;



  static String snackBarText="Err in uploads";
  String fileName;
  Future callUpload(BuildContext context,documents docType) async{
    try{

    setState(() {
      if(docType==documents.nailBitsDocument){
        nailUploading=true;
        nailUploadBtn=false;
      }
      else{
         bloodUploadBtn=false;
         bloodUploading=true;
      }

    });
    //Upload Part
    if(docType==documents.nailBitsDocument){
      int val=await uploadImage(nailBitsImage,docType);
      setState(() {
        if(val<300){
          print("Success");
          setState(() {
            nailUploading=false;
            nailBitsImage=null;
            snackBarText="Upload Successfull!";
            Scaffold.of(context).showSnackBar(getSnackBar(snackBarText));
          });

        }
        else{
          setState(() {
            nailUploading=false;
            nailUploadBtn=true;
            snackBarText="Error while uploading..";
            Scaffold.of(context).showSnackBar(getSnackBar(snackBarText));
          });

        }
      });
    }
    else if(docType==documents.bloodReportDocument){
      int val=await uploadImage(bloodReportImage,docType);
      setState(() {
        if(val<300){
          print("Success");
            bloodUploading=false;
            bloodReportImage=null;
            snackBarText="Upload Successfull!";
            Scaffold.of(context).showSnackBar(getSnackBar(snackBarText));

        }
        else{
            bloodUploading=false;
            bloodUploadBtn=true;
            snackBarText="Error while uploading..";
            Scaffold.of(context).showSnackBar(getSnackBar(snackBarText));
        }
      });
    }


    }
    catch(e){

    }
  }




  Widget _getNailImage(){
    if(nailBitsImage==null){
      nailUploadBtn=false;
        return Column(
        children: <Widget>[
          Text("Nail Bits",style: kLabelStyle,),
          Image.asset('images/nailBits.jpg'),
        ],
      );
    }
    nailUploadBtn=true;
    var f=nailBitsImage.toString().split('/');
    fileName=f.last;
    print(fileName);
    _spaceBt=20;
    return Column(
      children: <Widget>[
        Text("Nail Bits",style: kLabelStyle,),
        Image.file(nailBitsImage,width: 400,height: 300,),
      ],
    );


  }
  Widget _getBloodReportImage(){
    if(bloodReportImage==null){
      bloodUploadBtn=false;
        return Column(
        children: <Widget>[
          Text("Blood Report",style: kLabelStyle,),
          Image.asset('images/bloodReport.jpg'),
        ],
      );
    }
    bloodUploadBtn=true;
    var f=bloodReportImage.toString().split('/');
    fileName=f.last;
    print(fileName);
    return Column(
      children: <Widget>[
        Text("Blood Report",style: kLabelStyle,),
        Image.file(bloodReportImage,width: 400,height: 300,),
      ],
    );
  }
  _openGallery(BuildContext context,int img) async{
    try{
      var picture= await ImagePicker.pickImage(source: ImageSource.gallery);
      this.setState(() {
        if(img==1){
          nailBitsImage=picture;
        }
        else{
          bloodReportImage=picture;
        }
      });
      Navigator.of(context).pop();
    }
    catch(e){
      print(e);
    }
  }
  _openCamera(BuildContext context,int img) async{
    try{
      var picture= await ImagePicker.pickImage(source: ImageSource.camera);
      this.setState(() {
        if(img==1){
          nailBitsImage=picture;
        }
        else{
          bloodReportImage=picture;
        }
      });
      Navigator.of(context).pop();
    }
    catch(e){
      print(e);
    }

  }
  Future<void> _showChoiceDialog(BuildContext context,int img){
    return showDialog(context: context,
        builder:(BuildContext context){
          return AlertDialog(
            title: Text("Select to Upload"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: (){
                      _openGallery(context,img);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  GestureDetector(
                    child: Text("Camera"),
                    onTap: (){
                      print("Camera Clicked");
                      _openCamera(context,img);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }
  Widget _getText(int img){
    if(img==1){
      String text="";
      if(nailBitsImage==null){
        text= "Select Image";
      }
      else{ text="Change Image";}
      return Text(
        text,
      );
    }
    if(img==2){
      String text="";
      if(bloodReportImage==null){
        text= "Select Image";
      }
      else{ text="Change Image";}
      return Text(
        text,
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("New Patiend Record"),
      ),
      body: ListView(
        children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        _getNailImage(),
                        Visibility(
                          visible: nailUploading,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SpinKitDoubleBounce(
                                color: Colors.blueGrey,
                                size: 20,
                              ),
                              SizedBox(width: 10,),
                              Text("Uploading...",style: kLabelStyle,)
                            ],
                          ),
                        ),
                        SizedBox(height: 15,),
                        Visibility(
                          visible: nailUploadBtn,
                          child:    RaisedButton(
                            onPressed: () {
                              callUpload(context,documents.nailBitsDocument);
                            },
                            textColor: Colors.white,
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: <Color>[
                                    Color(0xFF2A6F33),
                                    Color(0xFF2A6F33),
                                    Color(0xFF78EC6C),
                                  ],
                                ),
                              ),
                              padding: const EdgeInsets.all(10.0),
                              child: const Text(
                                  '      Upload     ',
                                  style: TextStyle(fontSize: 20)
                              ),
                            ),
                          ),
                        ),
                        RaisedButton(
                          onPressed: () {
                            _showChoiceDialog(context,1);
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
                            child: _getText(1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: _spaceBt,),
                  Container(
                  child: Column(
                  children: <Widget>[
                    _getBloodReportImage(),
                    Visibility(
                      visible: bloodUploading,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SpinKitDoubleBounce(
                            color: Colors.blueGrey,
                            size: 20,
                          ),
                          SizedBox(width: 10,),
                          Text("Uploading...",style: kLabelStyle,)
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Visibility(
                      visible: bloodUploadBtn,
                      child:    RaisedButton(
                        onPressed: () {
                          callUpload(context,documents.bloodReportDocument);
                        },
                        textColor: Colors.white,
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF2A6F33),
                                Color(0xFF2A6F33),
                                Color(0xFF78EC6C),
                              ],
                            ),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: const Text(
                              '      Upload     ',
                              style: TextStyle(fontSize: 20)
                          ),
                        ),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        _showChoiceDialog(context,2);
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
                        child: _getText(2),
                      ),
                    ),
                ],
              ),
              )
        ],
      ),
  ]
      )
    );
  }
}
