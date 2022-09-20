import 'package:chatroom/screens/login_screen.dart';
import 'package:flutter/material.dart';
showAlertDialog(BuildContext context,String error) {
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pushNamed(context, LoginScreen.id);
    },

  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text('Alert!'),
    content:Text( error),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}