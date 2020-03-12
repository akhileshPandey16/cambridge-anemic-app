import 'package:flutter/material.dart';
const kBackGroundColor=Colors.white;
const kLabelStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 20,
  color: Colors.black
);
const kLinkStyle = TextStyle(
  fontWeight: FontWeight.w400,
  fontSize: 20,
  color: Colors.blueAccent,
  decoration: TextDecoration.underline
);

const kTitleStyle=TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 40,
);
const kButtonStyle=TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.w900,
    fontSize: 25,

);
enum states{
    init,
    uploadBloodReport,
    cancelled
}
enum documents{
    nailBitsDocument,
    bloodReportDocument
}