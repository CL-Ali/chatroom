import 'package:flutter/material.dart';

var kSendButtonTextStyle = TextStyle(
  color: Colors.red.shade500,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(

    hintText: 'Type your message here...',
    hintStyle: TextStyle(color: Colors.grey),
    border: InputBorder.none

);

var kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.red.shade500, width: 2.0),
  ),
);
const  kDisplayLabel= TextStyle(

  fontSize: 40.0,
  color: Colors.white,
  fontFamily: 'Fira Code',
  fontWeight: FontWeight.w900,
);
var kDisplayUpperSection= BoxDecoration(

  color:  Colors.red.shade500,

);
var kDisplayLowerSection= BoxDecoration(

  color:  Colors.white,

);

var kDisplayBelowSectionWelcome=BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(100.0),
    ),
    // shade in line of orange and below section
    boxShadow: [BoxShadow(
        color: Color.fromRGBO(19, 18, 18 , 10.0),
        blurRadius: 20,
        offset: Offset(20, 10)
    )]
);

const textFieldInput=TextStyle(color: Colors.black,
  fontFamily: 'DejaVu Sans Mono',
  fontWeight: FontWeight.bold,
);
const KroundedButton=TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontSize: 18,
);
