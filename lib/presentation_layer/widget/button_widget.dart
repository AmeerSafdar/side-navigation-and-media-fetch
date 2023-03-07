// ignore_for_file: must_be_immutable, sized_box_for_whitespace

import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
   ButtonWidget({super.key, required this.txt, required this.press});
  String txt;
  VoidCallback press;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      width: size.width-20,
      child: ElevatedButton(
        onPressed:press,
        child: Text(txt),
         ),
    );
  }
}