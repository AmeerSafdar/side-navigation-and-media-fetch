// ignore_for_file: use_build_context_synchronously


import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task4/bloc/audio_blocs/audio_bloc.dart';
import 'package:task4/bloc/audio_blocs/audio_events.dart';
import 'package:task4/bloc/image_blocs/image_screen_bloc.dart';
import 'package:task4/bloc/image_blocs/image_screen_event.dart';
import 'package:task4/bloc/video_blocs/video_bloc.dart';
import 'package:task4/bloc/video_blocs/video_events.dart';
import 'package:task4/helper/const/const.dart';
import 'package:task4/helper/const/string_helper.dart';

class PermissionUtils{
 askCameraPermission(BuildContext context) async{
    PermissionStatus status = await Permission.camera.request();
    if(status.isDenied == true)
      {  
         dialogUtils.showAlertDialog(context, 
     yesButtonTaped: (){
      Navigator.pop(context);
     }, 
     noBtnPress: () => Navigator.pop(context), action: StringHelp.PERMISSION, titleContent:StringHelp.PERMISSION_DENIED );

         }
      if(status.isPermanentlyDenied == true)
      {  
     dialogUtils.showAlertDialog(context, 
     yesButtonTaped: (){
      Navigator.pop(context);
      openAppSettings();
     }, 
     noBtnPress: () => Navigator.pop(context), action: StringHelp.PERMISSION, titleContent:StringHelp.PERMISSION_DENIED );

      }
    else
      {
        Navigator.pop(context);
        BlocProvider.of<ImageBloc>(context)
                            .add(FetchImage(ImageSource.camera));
      }
  }

askGalleryPermission(BuildContext context) async{
    PermissionStatus? status ;

  if (Platform.isAndroid) {
  final androidInfo = await DeviceInfoPlugin().androidInfo;
  if (androidInfo.version.sdkInt <= 32) {
    status=await Permission.storage.request();
  }  else {
   status= await Permission.photos.request();
  }
}
    if(status!.isDenied == true)
      {  
        dialogUtils.showAlertDialog(context, 
     yesButtonTaped: (){
      Navigator.pop(context);
     }, 
     noBtnPress: () => Navigator.pop(context), action: StringHelp.PERMISSION, titleContent:StringHelp.PERMISSION_DENIED );

         }

    else if(status.isPermanentlyDenied){

     dialogUtils.showAlertDialog(
      context,
       yesButtonTaped: (){
         Navigator.pop(context);
         openAppSettings(); 
         }, 
       noBtnPress: ()=> Navigator.pop(context),
      action: StringHelp.PERMISSION, titleContent:"${StringHelp.PERMISSION_DENIED} ${StringHelp.OPEN_APP_SETTINGS}" );

    }
      
    else
      {
         Navigator.pop(context);
                        BlocProvider.of<ImageBloc>(context)
                            .add(FetchImage(ImageSource.gallery));
      }
  }


  askVideoCameraPermission(BuildContext context) async{
    PermissionStatus status = await Permission.camera.request();
    if(status.isDenied == true)
      {  
        dialogUtils.showAlertDialog(context, 
     yesButtonTaped: (){
      Navigator.pop(context);
     }, 
     noBtnPress: () => Navigator.pop(context), action: StringHelp.PERMISSION, titleContent:StringHelp.PERMISSION_DENIED );

         }
      if(status.isPermanentlyDenied == true)
      {  
     dialogUtils.showAlertDialog(context, 
     yesButtonTaped: (){
      Navigator.pop(context);
      openAppSettings();
     }, 
     noBtnPress: () => Navigator.pop(context), action: StringHelp.PERMISSION, titleContent:StringHelp.PERMISSION_DENIED );

      }
    else
      {
        Navigator.pop(context);
                        BlocProvider.of<VideoBloc>(context)
                            .add(FetchVideo(ImageSource.camera));
      }
  }

askVideoGalleryPermission(BuildContext context) async{
  PermissionStatus? status ;

  if (Platform.isAndroid) {
  final androidInfo = await DeviceInfoPlugin().androidInfo;
  if (androidInfo.version.sdkInt <= 32) {
    status=await Permission.storage.request();
  }  else {
   status= await Permission.photos.request();
  }
}
    if(status!.isDenied == true)
      {  
       dialogUtils.showAlertDialog(context, 
     yesButtonTaped: (){
      Navigator.pop(context);
     }, 
     noBtnPress: () => Navigator.pop(context), action: StringHelp.PERMISSION, titleContent:StringHelp.PERMISSION_DENIED );

         }

    else if(status.isPermanentlyDenied){

     dialogUtils.showAlertDialog(
      context,
       yesButtonTaped: (){
         Navigator.pop(context);
         openAppSettings(); 
         }, 
       noBtnPress: ()=> Navigator.pop(context),
      action: StringHelp.PERMISSION, titleContent:StringHelp.PERMISSION_DENIED );

    }
      
    else
      {
         Navigator.pop(context);
                        BlocProvider.of<VideoBloc>(context)
                            .add(FetchVideo(ImageSource.gallery));
      }
  }
  

  audioPermission(BuildContext context) async{
  PermissionStatus? status ;

  if (Platform.isAndroid) {
  final androidInfo = await DeviceInfoPlugin().androidInfo;
  if (androidInfo.version.sdkInt <= 32) {
    status=await Permission.storage.request();
  }  else {
   status= await Permission.photos.request();
  }
}
  

   if(status!.isDenied == true)
      {  
       dialogUtils.showAlertDialog(context, 
     yesButtonTaped: (){
      Navigator.pop(context);
     }, 
     noBtnPress: () => Navigator.pop(context), action: StringHelp.PERMISSION, titleContent:StringHelp.PERMISSION_DENIED );

      }

   if(status.isPermanentlyDenied){
     dialogUtils.showAlertDialog(
      context,
       yesButtonTaped: (){
         Navigator.pop(context);
         openAppSettings(); 
         }, 
       noBtnPress: ()=> Navigator.pop(context),
      action: StringHelp.PERMISSION, titleContent:"${StringHelp.PERMISSION_DENIED} ${StringHelp.OPEN_APP_SETTINGS}" );

    }
    else{
      BlocProvider.of<AudioBlocs>(context)
                                .add(FetchAudio());
    }
  }}