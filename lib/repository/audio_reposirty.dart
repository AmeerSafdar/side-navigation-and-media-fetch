// ignore_for_file: use_rethrow_when_possible, unused_local_variable, unused_import, prefer_typing_uninitialized_variables, prefer_const_constructors, unrelated_type_equality_checks

import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:task4/bloc/audio_blocs/audio_bloc.dart';
import 'package:task4/helper/const/string_helper.dart';

class AudioRepository{
  final AudioPlayer _audioPlayer=AudioPlayer();
  Duration? duration,position;
  var result;
 Future<AudioPlayer?> pickAudio() async{
   try{ 

     result=await FilePicker.platform.pickFiles(
      allowedExtensions: [StringHelp.map3],
      type: FileType.custom
    );
    _audioPlayer.play(UrlSource(result!.files.single.path!));
    _audioPlayer.resume();
    }
    catch(e){
      throw e;
    }
    
  return _audioPlayer;
  }

   pickPosition(){
    _audioPlayer.onPositionChanged.listen((p) {
      position=p;

    });

    _audioPlayer.onDurationChanged.listen((Duration d) {
        duration=d;
});
  return [duration,position,_audioPlayer];
  }


  play(){
   try{ 
    if (_audioPlayer.resume()==false) {{
    _audioPlayer.play(UrlSource(result!.files.single.path!));}
    }
    else{
      _audioPlayer.pause();
    }}
    catch(e){
      throw e;
    }
  
  }

}