// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
class TextWidget extends StatelessWidget {
  String txt;
   TextWidget({super.key,required this.txt});

  @override
  Widget build(BuildContext context) {
   return Text(txt);
  }
}