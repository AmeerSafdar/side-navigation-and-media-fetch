// ignore_for_file: unused_element, use_rethrow_when_possible, prefer_const_constructors, invalid_use_of_visible_for_testing_member

import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task4/bloc/audio_blocs/audio_state.dart';
import 'package:task4/bloc/audio_blocs/audio_events.dart';
import 'package:task4/helper/const/const.dart';
import 'package:task4/repository/audio_reposirty.dart';

class AudioBlocs extends Bloc<GetAudio,AudioStates>{
AudioRepository audioRepo=AudioRepository();
AudioPlayer? data;
List<dynamic>? length;
 AudioBlocs({required this.audioRepo}) : super(AudioStates()){
  
  on<FetchAudio>(_fetchAudio);
  on<GetDuration>(_getDuration);
  on<Play>(_play);
  on<Pause>(_pause);
  on<Drag>(_drag);
 }

_drag(Drag event, Emitter<AudioStates> emit){
  length![1]=event.duration;
emit(
    state.copyWith(
    status: AudioStatus.success,
    position:length![1],
    duration: length!.elementAt(0),
    audio: data
    ));
}
 _play(Play event, Emitter<AudioStates> emitt){
  audioRepo.play();
  final length=audioRepo.pickPosition();
  emit(
    state.copyWith(
    status: AudioStatus.success,
    audio: length.elementAt(2),
    duration: length.elementAt(0),
    position:length.elementAt(1)
    ));
 }
  _pause(Pause event, Emitter<AudioStates> emit){
   audioRepo.play();
   length=audioRepo.pickPosition();
  emit(
    state.copyWith(
    status: AudioStatus.pause,
    audio: length!.elementAt(2),
    duration: length!.elementAt(0),
    position:length!.elementAt(1)
    ));
 }
  _getDuration(GetDuration event, Emitter<AudioStates> emit){
  try {
    length=audioRepo.pickPosition();
    emit(
    state.copyWith(
    status: AudioStatus.success,
    audio: length!.elementAt(2),
    duration: length!.elementAt(0),
    position:length!.elementAt(1)
    ));
    
  } catch (e) {
    throw e;
  }
}
 FutureOr<void> _fetchAudio(FetchAudio event, Emitter<AudioStates> emit) async{
   try {
    Future<PermissionStatus> status= permissionUtils.askCameraPermission(Permission.storage);
    if (await status.isDenied) {
       emit(
          state.copyWith(
          status: AudioStatus.denied,
          audio: data,
          duration: length!.elementAt(0),
          position:length!.elementAt(1)

          ));
       } 
       else if(await status.isPermanentlyDenied){

       emit(
          state.copyWith(
          status: AudioStatus.permamentDenied,
          audio: data,
          duration: length!.elementAt(0),
          position:length!.elementAt(1)
          ));

       }
       else if(await status.isGranted) {
        data=await audioRepo.pickAudio();
        length=audioRepo.pickPosition();
        emit(
          state.copyWith(
          status: AudioStatus.success,
          audio: data,
          duration: length!.elementAt(0),
          position:length!.elementAt(1)
    ));
       }
   } 
   catch (e) {
    emit(
      state.copyWith(
    status: AudioStatus.failure,
    audio: data,
    duration: length?.elementAt(0) ,
    position:length?.elementAt(1)
    ));
   }
 }
 }