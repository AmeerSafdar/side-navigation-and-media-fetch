// ignore_for_file: unused_element, use_rethrow_when_possible

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task4/bloc/audio_blocs/audio_state.dart';
import 'package:task4/bloc/audio_blocs/audio_events.dart';
import 'package:task4/repository/audio_reposirty.dart';

class AudioBlocs extends Bloc<GetAudio,AudioStates>{
AudioRepository audioRepo=AudioRepository();

 AudioBlocs({required this.audioRepo}) : super(AudioStates()){
  
  on<FetchAudio>(_fetchAudio);
  on<Closed>(_disposedScreen);
  on<GetDuration>(_getDuration);

 }
  _getDuration(event,emit){
  try {
    final length=audioRepo.pickPosition();
    emit(
    state.copyWith(
    status: AudioStatus.success,
    audio: length.elementAt(2),
    duration: length.elementAt(0),
    position:length.elementAt(1)
    ));
  } catch (e) {
    throw e;
  }
}

 _disposedScreen(event, emit){
  try {
    emit(state.copyWith(
    status: AudioStatus.initial
    ));
    
  } catch (e) {
    emit(state.copyWith(
    status: AudioStatus.failure
    ));
  }
 }
 FutureOr<void> _fetchAudio(event, emit) async{
   askPermission();
   try {
      emit(
    state.copyWith(
    status: AudioStatus.initial
    ));
     final data=await audioRepo.pickAudio();
     final length=audioRepo.pickPosition();
    emit(
    state.copyWith(
    status: AudioStatus.success,
    audio: data,
    duration: length.elementAt(0),
    position:length.elementAt(1)
    ));
   } catch (e) {
    emit(state.copyWith(
    status: AudioStatus.failure
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