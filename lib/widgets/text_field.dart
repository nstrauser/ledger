import 'package:flutter/material.dart';
import '../shared/theme.dart';

class MyTextField extends StatelessWidget {

  final controller;
  final onChanged;
  final hintText;
  final style;
  final maxLines;
  final minLines;
  final width;

  MyTextField({this.onChanged, this.hintText, this.style, this.controller, this.maxLines, this.minLines, this.width});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: width,
        margin: EdgeInsets.symmetric(vertical: 15),
//      width: 150.0,
        height: 55,
        child: TextFormField(

          controller: controller,
          style: style,
          onChanged: onChanged,
          maxLines: maxLines,
          minLines: minLines,
          decoration: InputDecoration(
              hintText: hintText,
              fillColor: kBackgroundDarker,
              focusedBorder: OutlineInputBorder(
//                  borderSide: BorderSide(color: kBrickRedDarker, width: 0.8)
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.white70, fontSize: 15),
//            labelStyle: labelStyle,
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 0.5),
                  borderRadius: BorderRadius.circular(5.0)
              )
              ),
        ),
      ),
    );
  }
}
