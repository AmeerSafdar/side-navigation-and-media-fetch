// ignore_for_file: sort_child_properties_last, use_function_type_syntax_for_parameters, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task4/bloc/image_blocs/image_screen_bloc.dart';
import 'package:task4/bloc/image_blocs/image_state.dart';
import 'package:task4/helper/const/icon_helper.dart';
import 'package:task4/helper/const/string_helper.dart';
import 'package:task4/representation/widget/text_widget.dart';

class DialogUtils{
  showAlertDialog(
    BuildContext context,{required VoidCallback yesButtonTaped,
     required VoidCallback noBtnPress, required String action,required String titleContent}){  
      Widget cancelButton = TextButton(
      child: TextWidget(txt: StringHelp.CANCEL,),
      onPressed:noBtnPress,
    );
    Widget continueButton = TextButton(
      child: TextWidget(txt:StringHelp.OK),
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


 imagePickDialog(BuildContext context)  {
        return AlertDialog(
          title: TextWidget(txt: StringHelp.PICK_IMAGE_FROM),
          content: SingleChildScrollView(
            child: BlocBuilder<ImageBloc, ImageStates>(
              builder: (context, state) {
                return Column(
                  children: <Widget>[
                    ListTile(
                      leading: IconHelper.IMAGE_ICON,
                      onTap: ()=>Navigator.pop(context,ImageSource.gallery),
                      title: TextWidget(txt: StringHelp.PICK_FROM_GALLERY),
                    ),
                    ListTile(
                      leading: IconHelper.VIDEO_ICON,
                      onTap: ()=>Navigator.pop(context,ImageSource.camera),
                      title:TextWidget(txt: StringHelp.PICK_FROM_CAMERA),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: TextWidget(txt: StringHelp.CANCEL),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }

  
}