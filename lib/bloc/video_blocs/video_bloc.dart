// ignore_for_file: prefer_const_constructors, await_only_futures

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task4/bloc/video_blocs/video_events.dart';
import 'package:task4/bloc/video_blocs/video_state.dart';
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

 _play(event,emit){
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

 FutureOr<void> _fetchVideo(event, emit) async{
  try {
    video=await getVideRepo.pickVideo(event.src);
    thumbImg=await getVideRepo.getThumbNail();
    emit(
    state.copyWith(
    status: VideoStatus.success,
    thumbnailImg: thumbImg,
    video: video
    ));
 
  } catch (e) {
    emit(state.copyWith(
    status: VideoStatus.failure,
    video: video,
    thumbnailImg: thumbImg

    ));
  }
   }
 }