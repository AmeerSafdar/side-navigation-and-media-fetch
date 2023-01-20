// ignore_for_file: prefer_const_constructors, await_only_futures

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task4/bloc/video_blocs/video_events.dart';
import 'package:task4/bloc/video_blocs/video_state.dart';
import 'package:task4/repository/get_video_repository.dart';
import 'package:video_player/video_player.dart';

class VideoBloc extends Bloc<GetVideo,VideoStates>{
 GetVideoRepo getVideRepo =GetVideoRepo();

 VideoBloc({required this.getVideRepo}) : super(VideoStates()){

   on<FetchVideo>(_fetchVideo);
   on<Closed>(_disposedScreen);
   
 }

 FutureOr<void> _fetchVideo(event, emit) async{
  askPermission();
  try {
    emit(state.copyWith(
    status: VideoStatus.initial
    ));
    VideoPlayerController? video=await getVideRepo.pickVideo(event.src);
    Uint8List? thumbImg=await getVideRepo.getThumbNail();
    emit(state.copyWith(
    status: VideoStatus.success,
    thumbnailImg: thumbImg,
    video: video
    ));
 
  } catch (e) {
    emit(state.copyWith(
    status: VideoStatus.failure,
    ));
  }
   }

    _disposedScreen(event, emit){
  try {

    emit(state.copyWith(
    status: VideoStatus.initial
    ));
    
  } catch (e) {
    emit(state.copyWith(
    status: VideoStatus.failure
    ));
  }
 }

askPermission() async{
    PermissionStatus status = await Permission.mediaLibrary.request();
    if(status.isDenied == true || status.isPermanentlyDenied)
      {
        askPermission();
      }
    else
      {
        return true;
      }
      return ;
  }
 
 }