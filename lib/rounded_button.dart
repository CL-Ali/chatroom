import 'package:flutter/material.dart';
import 'constants.dart';

class RoundButton extends StatelessWidget {

  RoundButton({

    required this.ontap,required this.title,required this.color
  }) ;
  final Color color;
  final String title;
  final GestureTapCallback ontap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style:ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
        ),
        child: Container(
            width: 200,
            height: 50,
            child: Center(child: Text(title,style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),))), onPressed:ontap);
  }
}
