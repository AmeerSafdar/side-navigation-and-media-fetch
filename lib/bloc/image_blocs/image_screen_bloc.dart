// ignore_for_file: depend_on_referenced_packages, use_rethrow_when_possible, use_build_context_synchronously

import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task4/bloc/image_blocs/image_screen_event.dart';
import 'package:task4/bloc/image_blocs/image_state.dart';
import 'package:task4/helper/const/const.dart';
import 'package:task4/repository/get_imageRepo.dart';

class ImageBloc extends Bloc<GetImage,ImageStates>{
ImageRepository imgRepo;
File? data;
 ImageBloc({required this.imgRepo}) : super( const ImageStates()){

  on<FetchImage>(_retrieveImage);
  
 }

 FutureOr<void> _retrieveImage(FetchImage event, Emitter<ImageStates> emit) async{
   try {
    ImageSource imgSrc=await showDialog(
      context: event.context, 
      builder: (context) => dialogUtils.imagePickDialog(context),
      );
      
      if (imgSrc == ImageSource.camera) {
       Future<PermissionStatus> status= permissionUtils.askCameraPermission(Permission.camera) ;
       if (await status.isDenied) {
        emit(
              state.copyWith(
              status: ImageStatus.cameraDenied
                ));
                 } 
       else if(await status.isPermanentlyDenied){
          emit(
              state.copyWith(
              status: ImageStatus.cameraPermanentDenied
                ));
        }
       else if(await status.isGranted) {
        data=await imgRepo.pickImage(imgSrc);
        emit(
              state.copyWith(
              img: data!,
              status: ImageStatus.success
                ));
       }
      }
      if (imgSrc == ImageSource.gallery) {
        Future<PermissionStatus> status= permissionUtils.askCameraPermission(Permission.storage);
        if (await status.isDenied) {
          emit(
              state.copyWith(
              status: ImageStatus.galleryDenied
                ));
       } 
       else if(await status.isPermanentlyDenied){
        emit(
              state.copyWith(
              status: ImageStatus.galleryPermanentDenied
                ));
       }
       else if(await status.isGranted){
          data=await imgRepo.pickImage(imgSrc);
           emit(
              state.copyWith(
              img: data!,
              status: ImageStatus.success
                ));
       }
      }
    
   } 
   catch (e) {
    emit(state.copyWith(
    status: ImageStatus.failure,
    img:data
    ));
   }
 }

}