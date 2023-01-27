// ignore_for_file: prefer_const_constructors, await_only_futures, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task4/bloc/video_blocs/video_events.dart';
import 'package:task4/bloc/video_blocs/video_state.dart';
import 'package:task4/helper/const/const.dart';
import 'package:task4/repository/get_video_repository.dart';
import 'package:video_player/video_player.dart';

class VideoBloc extends Bloc<GetVideo,VideoStates>{
 GetVideoRepo getVideRepo =GetVideoRepo();
 VideoPlayerController? video;
 Uint8List ? thumbImg;
 VideoBloc({required this.getVideRepo}) : super(VideoStates()){

   on<FetchVideo>(_fetchVideo);
   on<Play>(_play);
   on<Pause>(_pause);
   
 }

 _play(Play event, Emitter<VideoStates> emit){
   getVideRepo.play();
   emit(
    state.copyWith(
    status: VideoStatus.success,
    thumbnailImg: thumbImg,
    video: video
    ));
 }
  _pause(event,emit){
   getVideRepo.pause();
   emit(
    state.copyWith(
    status: VideoStatus.pause,
    thumbnailImg: thumbImg,
    video: video
    ));
 }

 Future<void> _fetchVideo(FetchVideo event, Emitter<VideoStates> emit) async{
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
                status: VideoStatus.cameraDenied,
                ));}
        else if(await status.isPermanentlyDenied){
        emit(
              state.copyWith(
                status: VideoStatus.cameraPermanentDenied
                ));
       }
       else if(await status.isGranted) {
        video=await getVideRepo.pickVideo(imgSrc);
        thumbImg=await getVideRepo.getThumbNail();
        emit(
             state.copyWith(
             status: VideoStatus.success,
             thumbnailImg: thumbImg!,
             video: video!
               ));
       }
      }
      if (imgSrc == ImageSource.gallery) {
         Future<PermissionStatus> status = permissionUtils.askCameraPermission(Permission.storage);
        if (await status.isDenied) {
          emit(
              state.copyWith(
              status: VideoStatus.galleryDenied,
                ));
       } 
       else if(await status.isPermanentlyDenied){
        emit(
              state.copyWith(
              status: VideoStatus.galleryPermanentDenied,
                ));
       }
       else if(await status.isGranted){
          video= await getVideRepo.pickVideo(imgSrc);
          thumbImg=await getVideRepo.getThumbNail();
          emit(
             state.copyWith(
             status: VideoStatus.success,
             thumbnailImg: thumbImg!,
             video: video!
               ));
       }
      }
 
  } catch (e) {
    emit(state.copyWith(
    status: VideoStatus.failure,
    video: video,
    thumbnailImg: thumbImg

    ));
  }
   }
 }