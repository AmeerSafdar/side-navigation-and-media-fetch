// ignore_for_file: unused_element, use_rethrow_when_possible, prefer_const_constructors

import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task4/bloc/audio_blocs/audio_state.dart';
import 'package:task4/bloc/audio_blocs/audio_events.dart';
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

_drag(event,emit){
  length![1]=event.duration;
emit(
    state.copyWith(
    status: AudioStatus.success,
    position:length![1],
    duration: length!.elementAt(0),
    audio: data
    ));
}
 _play(event,emit){
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
  _pause(event,emit){
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
  _getDuration(event,emit){
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
 FutureOr<void> _fetchAudio(event, emit) async{
   try {
      data=await audioRepo.pickAudio();
      length=audioRepo.pickPosition();
    
    emit(
    state.copyWith(
    status: AudioStatus.success,
    audio: data,
    duration: length!.elementAt(0),
    position:length!.elementAt(1)
    ));
   } catch (e) {
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