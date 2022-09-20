import 'package:flutter/material.dart';
import 'constants.dart';
class TextInputField extends StatelessWidget {
  TextInputField({
    required this.textInput,
  }) ;
  final TextField textInput;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade200))
      ),
      child: Center(child: textInput),
    );
  }
}
