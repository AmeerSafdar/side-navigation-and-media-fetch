// ignore_for_file: sort_child_properties_last, use_function_type_syntax_for_parameters, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:task4/helper/const/string_helper.dart';
import 'package:task4/representation/widget/text_widget.dart';

class DialogUtils{
  showAlertDialog(BuildContext context,{required VoidCallback yesButtonTaped, required VoidCallback noBtnPress, required String action,required String titleContent}){  
      Widget cancelButton = TextButton(
      child: TextWidget(txt: '',),
      onPressed:noBtnPress,
    );
    Widget continueButton = TextButton(
      child: TextWidget(txt:StringHelp.OPEN),
      onPressed: yesButtonTaped,
    );
     AlertDialog alert = AlertDialog(
      title: TextWidget(txt:action),
      content: TextWidget(txt:titleContent),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

   return Future.delayed(Duration.zero,(() {
     showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
   }));
    } 
}